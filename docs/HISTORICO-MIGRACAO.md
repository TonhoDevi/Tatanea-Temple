# Histórico da Migração — Do Local pra Produção

Este documento registra a história da migração do Tatanea Temple de "só roda na
minha máquina" pra uma aplicação real em produção: as decisões de modelagem que
vieram antes (o que virou tabela no banco, o que virou página escrita à mão, e
por quê), a escolha da infraestrutura, e a sequência de bugs — cada um só visível
depois do deploy real — que precisou ser corrigida pra tudo funcionar de ponta a
ponta. Serve como referência pra entender por que o sistema é como é hoje, e como
ponto de partida pra quem for mexer nessas áreas depois.

---

## Parte 1 — Antes do deploy: modelar o compêndio

Antes de existir qualquer ambiente de produção, a maior parte do trabalho foi
descobrir **o que deveria virar tabela no banco e o que deveria virar página
escrita à mão no frontend** — e isso não foi óbvio desde o início. O projeto
passou por pelo menos uma tentativa de modelo totalmente normalizado que não
vingou, antes de chegar na divisão atual.

### 1.1. A tentativa de normalizar tudo (e por que não deu certo)

A primeira abordagem para o compêndio de Classes foi tentar representar tudo no
banco: colunas dedicadas para `pontos_de_vida`, `proficiencias`, `equipamento`
etc. Isso não escalou. Conteúdo de D&D tem forma irregular demais — tabelas de
progressão variam de classe pra classe (espaços de magia, pontos de magia,
manobras conhecidas, linhagens de subclasse com colunas próprias), características
às vezes são "escolha uma opção" e às vezes "ganhe todas ao mesmo tempo", e cada
classe tem suas próprias exceções. Forçar isso num schema relacional rígido
significava perder fidelidade ao material de origem ou brigar com migrations a
cada classe nova.

A decisão final foi **dividir por quem consome o dado, não tentar um modelo único
pra tudo**:

- **Raças** — compêndio **totalmente orientado a banco**. `CompendioRacas.vue` e
  `DetalheRaca.vue` renderizam de forma genérica a partir do `RacaDetalheDto`, sem
  nenhuma página dedicada por raça. Isso funciona porque o "formato" de uma raça é
  bem mais regular que o de uma classe (atributos, deslocamento, tamanho,
  altura/peso/idade, uma lista de habilidades especiais) — dá pra representar tudo
  em tabelas sem perder nada.
- **Classes** — o banco fica **restrito ao que a ficha de personagem precisa
  consultar em runtime**: uma lista de habilidades por classe/subclasse, cada uma
  com `nome`, `descrição` e `nível`, marcada com um `tipo` (`HABILIDADE` vs
  `FUNDAMENTO`, pra separar características reais de regras fixas como Pontos de
  Vida/Proficiências/Equipamento que toda classe tem mas não são "ganhas" num
  nível). Isso é o suficiente pra ficha responder "quais habilidades esse
  personagem já tem, dado o nível dele".
- **Páginas de compêndio de classe** (as 13 páginas que o jogador lê pra consultar
  a classe) são **escritas à mão**, uma por classe, em vez de renderizadas
  genericamente a partir do banco — porque tabela de D&D não cabe em schema
  genérico sem perder fidelidade. Compêndio e ficha **não têm relação entre si por
  design**: texto duplicado entre a descrição de uma habilidade no banco e a prosa
  da página estática é uma troca aceita, já que esse texto muda raramente (edições
  planejadas, não um fluxo de manutenção constante).
- Pra não duplicar cabeçalho/CSS/layout nas 13 páginas, elas compartilham um shell
  comum (`ClassePaginaLayout`) — só o corpo (descrição, tabelas, características)
  é próprio de cada classe.

Esse padrão está documentado em detalhe em
[`frontend/src/components/compendio/classes/GUIA_PAGINA_DE_CLASSE.md`](../frontend/src/components/compendio/classes/GUIA_PAGINA_DE_CLASSE.md),
escrito depois que `CacadorPagina.vue` virou o molde das outras 12 classes —
cobre ordem fixa de seções, convenções de tabela vs. lista, termos de jogo
grifados, ícones reutilizáveis e um checklist passo a passo pra criar uma classe
nova.

### 1.2. Raças: modelagem em enums, sub-raças e casos de borda

O schema de Raças passou por uma reescrita própria (`cc6d06f`): campos `String`
soltos (categoria, tamanho, atributo, tipo de habilidade) viraram enums com
`AttributeConverter` dedicado, desacoplando o nome da constante Java do valor
persistido no banco, e a PK deixou de ser um slug pra virar `BIGINT identity`.

Ao popular as ~55 raças/sub-raças reais, surgiram várias decisões de convenção,
registradas porque se repetiriam a cada raça nova:

- **A tabela `racas` não tem aninhamento de sub-raça — é uma lista plana.** Uma
  raça com variantes nomeadas (Aasimar Caído/Arcanjo/Protetor, Elfo Altivo/
  Floral/Drow, Genasi por elemento, Warforged por papel) vira uma linha própria
  por variante, com os traços da raça-base duplicados em cada variante e o bônus
  de atributo extra da variante **consolidado num único total por atributo** (ex.:
  Anão base +2 Constituição + Anão Rochoso +1 Constituição vira uma linha só de
  +3), em vez de deixar dois incrementos separados.
- **O schema não consegue expressar "+N a exatamente um destes dois atributos
  nomeados"** (ex.: "+1 Sabedoria ou Carisma" do Illithid). A convenção adotada
  foi usar o mecanismo de escolha livre (`atributo = NULL, quantidade_escolhas = 1`)
  mesmo sendo mais amplo que o par restrito da fonte — uma simplificação
  deliberada, sempre comentada no SQL, nunca um palpite silencioso.
- **Altura/peso dados como valor único** (não faixa) recebem esse mesmo valor nas
  três colunas (menor/médio/maior); **uma faixa sem "média" explícita** vira o
  ponto médio aritmético.
- **Raças sem conceito de envelhecimento** (Vazios — mortos-vivos que não
  envelhecem; Warforged — constructos sem expectativa de vida declarada) **não
  ganham linha de idade nenhuma**, em vez de forçar um 0/0 artificial numa coluna
  `NOT NULL`.
- `deslocamento` foi ampliado de `INT` pra `DOUBLE PRECISION` (tanto na tabela
  quanto na entidade JPA) porque muitas raças convertidas de pés em metros caem em
  valores como 4.5/7.5/10.5 — um `INT` forçaria arredondamento perdido numa fração
  grande das raças.

### 1.3. Talentos e Talentos Raciais: separar dois conceitos que começaram juntos

Talentos começaram com pré-requisito e bônus de raça embutidos na mesma entidade.
O commit `4b08e27` separou isso: **Talento Racial virou entidade/tabela própria**,
com seu próprio controller/service/repository, e o bônus de atributo ganho ao
pegar um talento virou uma lista estruturada (`TalentoAtributo`: fixo ou a
escolha — o mesmo formato já usado em `RacaAtributo`) em vez de um par
atributo/valor solto. O compêndio real (91 talentos comuns) substituiu o seed de
exemplo em `eacc04c`, com pré-requisitos em texto livre que casam com o padrão
"Atributo N ou maior" convertidos pra pré-requisito estruturado — o resto ficou
em texto puro mesmo.

### 1.4. Classes: da ideia normalizada ao modelo final

`0ec5888` trocou `ClasseHabilidadeDestaque` por `ClasseNivel`/
`ClasseCaracteristica`/`ClasseSubclasseCaracteristica` — deliberadamente restrito
ao que a ficha precisa consultar (habilidades por nível/subclasse), deixando as
tabelas de compêndio (slots de magia, manobras etc.) fora do schema, conforme a
decisão da seção 1.1. Nesse mesmo commit as 13 classes reais substituíram os
dados de exemplo usados só pra desenhar a estrutura.

Convenções fixadas ao escrever cada página de classe (ver o guia completo):

- Toda página tem uma tabela de "Progressão" logo após a "Descrição", antes de
  qualquer outra seção.
- Múltipla escolha é sempre tabela; "ganhe todos estes benefícios" é sempre lista
  `<ul><li>`. Nunca misturar os dois padrões.
- Fórmula de Pontos de Vida é padronizada pra todas as classes, mesmo quando o
  material de origem vem diferente — inclusive descartando uma cláusula ("+
  metade do nível arredondado pra baixo") que existia no material fonte, mas foi
  removida do sistema.
- Quando a tabela de progressão e a prosa de uma característica discordam sobre
  em que nível algo é concedido, a regra é **perguntar ao usuário**, nunca
  assumir qual dos dois está certo (aconteceu uma vez com o Ladino e a resposta
  óbvia — confiar na tabela — estava errada).
- PDFs de origem (`/home/antonio/Documentos/PDFS RPG/`) são lidos direto — colar o
  texto do PDF no chat historicamente saía com a ordem de colunas embaralhada.

A lista de classes (`CompendioClasses.vue`) foi deliberadamente projetada **sem
busca/filtro**: com só 13 classes (e no máximo 3-4 a mais previstas), a UI de
busca deixava a página mais vazia, não mais útil — uma decisão específica pro
tamanho pequeno e fixo desse conjunto, não uma regra geral pros outros compêndios
(Talentos/Raças têm bem mais itens e provavelmente continuam precisando de busca).

### 1.5. A ficha de personagem: fechar a lacuna entre frontend e backend

A ficha de personagem também passou por uma sequência de commits fechando a
distância entre o que já era editável só no navegador e o que de fato persistia:
deslocamento convertido pra decimal, escolha de atributo ("+1 à sua escolha")
persistida numa tabela própria (`personagem_escolhas_atributo`) em vez de existir
só no estado do browser, imagem do personagem salva como `data URI` em vez de um
campo de URL sem forma real de ser preenchido, e depois 17 colunas escalares +
5 listas novas (armadura, iniciativa, tesouro, componentes de PV máximo, slots de
magia) pra cobrir detalhes físicos, personalidade, salvaguardas e as listas que
antes eram provisórias.

### 1.6. Política de migrations neste projeto

Como o backend roda em H2 em memória por padrão e (até o deploy) nunca teve um
banco persistente de verdade, a convenção adotada foi **consolidar migrations em
vez de empilhar uma nova a cada mudança pequena de schema** — editar o
`V1__create_*`/seed relevante diretamente, ou aposentar migrations que deixaram
de ser úteis. Isso só é seguro justamente por não haver dado real em risco; deixa
de valer no momento em que existe um banco de produção com histórico do Flyway a
preservar (que é exatamente o que aconteceu na Parte 2).

---

## Parte 2 — O deploy: de "só roda local" pra produção

Com o compêndio modelado, o passo seguinte foi colocar o sistema no ar. A
arquitetura escolhida, com custo zero e sem cartão de crédito: **frontend na
Vercel, backend em Docker, banco PostgreSQL no Supabase.**

### 2.1. Primeira escolha de backend: Oracle Cloud (revertida)

A primeira infraestrutura desenhada (`7d859e0`) colocava o backend numa VM
"Always Free" da Oracle Cloud, atrás de Caddy pra HTTPS automático — exigindo
criar a VM, abrir portas 80/443 em duas camadas de firewall (regras de VCN +
`iptables` da própria VM), instalar Docker manualmente via SSH, e configurar um
domínio (`nip.io` como alternativa sem domínio próprio) só pra o Caddy conseguir
emitir certificado.

Essa abordagem foi trocada por **Render** (`35856c1`) antes de ir pro ar: Oracle
Cloud exige cartão de crédito mesmo no tier gratuito, enquanto Render tem free
tier sem cartão e faz deploy via Docker direto do GitHub — sem VM, sem Caddy, sem
SSH manual. A troca eliminou toda a seção de setup de VM/firewall/domínio do
`DEPLOY.md`, substituída por "conectar o repo, configurar variáveis de ambiente,
clicar em criar". Trade-off aceito: o free tier do Render "dorme" depois de ~15
minutos sem tráfego, e a primeira requisição depois disso leva 30-50s pra acordar
o container (os dados no Supabase não são afetados, só o servidor fica parado).

### 2.2. A cascata de bugs só visíveis em produção

Depois do primeiro deploy real, uma série de problemas apareceu — cada um deles
invisível em dev (H2 em memória, sem CORS entre origens, tudo na mesma máquina) e
só reproduzível contra o ambiente real. Nessa ordem:

1. **Supabase só resolve em IPv6 no host direto** — a maioria das plataformas
   free tier (Render incluso) não tem saída IPv6, então a conexão falhava
   silenciosamente. Resolvido usando o *connection pooler* do Supabase
   (Supavisor), que tem host compatível com IPv4.
2. **`AUTO_INCREMENT` (sintaxe MySQL) nas migrations `V7`/`V9`** funcionava no H2
   de dev mas não existe no PostgreSQL — quebrava o Flyway em produção com
   "syntax error at or near AUTO_INCREMENT". Trocado por
   `GENERATED BY DEFAULT AS IDENTITY`, sintaxe já usada em `V1` e válida nos dois
   bancos.
3. **`DECIMAL(6,2)` nos campos de deslocamento da ficha** não batia com o tipo
   `Double` da entidade `Personagem` — o validador de schema do Hibernate aceitava
   a incompatibilidade no H2, mas falhava contra PostgreSQL real com
   "wrong column type". Trocado por `DOUBLE PRECISION`, o mesmo padrão já usado em
   `racas.deslocamento`.
4. **O pooler do Supabase roda em modo *transaction*** (porta 6543) e não guarda
   prepared statements entre requisições — sem `prepareThreshold=0` na `DB_URL`,
   o driver JDBC quebrava com `"prepared statement \"S_1\" already exists"` assim
   que o Hikari reutilizava uma conexão do pool.
5. **CORS bloqueava chamadas autenticadas com 401 no preflight**, mesmo com CORS
   configurado via `WebMvcConfigurer.addCorsMappings`. Causa raiz: esse tipo de
   configuração só se aplica depois que a requisição passa pelo filtro do Spring
   Security — como o `SecurityConfig` não tinha `http.cors(...)` habilitado, o
   preflight `OPTIONS` de qualquer rota `anyRequest().authenticated()` era
   rejeitado com 401 pelo Security antes de chegar no Spring MVC. Rotas
   `permitAll()` (raças, talentos, classes, alquimia) não sofriam disso — por
   isso o bug só apareceu ao mexer com personagens. Corrigido plugando um bean
   `CorsConfigurationSource` direto em `http.cors(...)` no `SecurityConfig`.
6. **`allowedOrigins` fazia comparação exata de string com `FRONTEND_URL`**, então
   só a URL fixa de produção passava — toda preview de PR/branch da Vercel usa um
   subdomínio aleatório (`*.vercel.app`) e era bloqueada. Trocado por
   `allowedOriginPatterns` com wildcard, mantendo a URL fixa e liberando também
   `https://*.vercel.app`.
7. **5 dos 6 services do frontend criavam sua própria instância do axios** com
   `baseURL` relativo fixo, ignorando `VITE_API_BASE_URL`. Em dev funcionava
   porque o proxy do Vite resolve `/api`; em produção na Vercel as chamadas iam
   pro próprio domínio da Vercel, caíam no fallback de rota do `vercel.json` e o
   axios recebia HTML no lugar de JSON — o `.filter()`/`.map()` do frontend
   quebrava silenciosamente. Corrigido unificando todos os services no `http.js`
   compartilhado.
8. **Log do Render mostrando a senha gerada automaticamente do Spring Boot**
   ("Using generated security password...") a cada start, mesmo a aplicação
   nunca usando `UserDetailsService`/`AuthenticationManager` (autenticação é 100%
   manual via `JwtAuthFilter`). `spring.autoconfigure.exclude` não resolvia,
   porque `SecurityAutoConfiguration` importa `UserDetailsServiceAutoConfiguration`
   direto via `@Import`, ignorando a lista de exclusão. Corrigido declarando o
   próprio bean `UserDetailsService` (nunca chamado de fato, só existe pra
   satisfazer o `@ConditionalOnMissingBean` que dispara a criação do usuário
   gerado).

### 2.3. Performance em produção: N+1 queries e a saga do revert

Com backend e banco em regiões diferentes (Render em Ohio, Supabase em São
Paulo), cada round-trip ao banco custa ~150-300ms — um custo que passa
despercebido localmente (mesma máquina) mas explode em produção quando o código
faz uma consulta por item numa lista.

O diagnóstico: `listarTodas()` de raças chamava
`raca.getHabilidadesEspeciais().size()` e `raca.getImagem()` dentro do `map()` do
DTO — duas associações lazy do Hibernate disparando 2 consultas extras por raça
(113 no total pra 56 raças), levando a listagem a **~50 segundos**. O mesmo
padrão existia em talentos (91×1), talentos raciais (N×2) e classes (13×1);
alquimia não sofria disso por não ter relacionamentos.

A correção definitiva (depois de duas tentativas revertidas — `ec01232`→revertido
e `83fed05`→revertido — antes de `f89f145` ficar de pé) veio em duas frentes:

1. `spring.jpa.properties.hibernate.default_batch_fetch_size=32` — configuração
   global que agrupa cargas lazy pendentes do mesmo tipo numa única consulta
   `WHERE id IN (...)`, resolvendo raças/talentos/talentos raciais/classes de uma
   vez.
2. A ficha de personagem carrega ~14 coleções distintas por natureza (não escala
   com a quantidade de personagens, então o batch acima não ajuda ali), mas a
   cadeia talento→atributos escalava com a quantidade de talentos equipados —
   resolvida com um `JOIN FETCH` dedicado (`findByIdComTalentos`).
3. `RacaResumoDto` carregava o `byte[]` inteiro da imagem só pra checar null;
   trocado por uma consulta de projeção (só os ids que têm imagem).

Depois disso, ainda restava o custo de renderizar até 56 `<img>` de uma vez no
compêndio de raças, cada uma batendo em `/api/racas/{id}/imagem` sem cache
(`b0f6616`): resolvido com ETag baseado em `atualizadoEm` + `Cache-Control` de 1
dia no backend (retornando 304 sem carregar o `byte[]` quando o `If-None-Match`
bate) e `loading="lazy"` nos retratos dos cards no frontend.

Por fim, `297d1dc` atacou o custo de navegação dentro do compêndio: sair de uma
listagem pra ver um detalhe e voltar refazia o fetch inteiro do zero, porque o
Vue Router destrói e remonta o componente a cada troca de rota. Resolvido com 5
stores Pinia (um por domínio do compêndio: raças, talentos, talentos raciais,
classes, alquimia), cada um com lista + cache de detalhe por id, invalidado só
manualmente (sem polling, já que o conteúdo do compêndio muda raramente). A ficha
de personagem foi resolvida de forma diferente — `<keep-alive>` dedicado em
`App.vue` (máx. 6 instâncias) em vez de store, porque é editada com frequência
pelo dono e manter a instância viva do jeito exato que a pessoa deixou é mais
direto do que replicar esse estado num store.

---

## Parte 3 — Estado atual e coisas a detalhar depois

- **Arquitetura de produção hoje**: frontend na Vercel, backend em Docker no
  Render (free tier), banco PostgreSQL no Supabase via pooler. Guia completo em
  [`DEPLOY.md`](../DEPLOY.md).
- **Checklist de verificação pós-deploy** (de `DEPLOY.md`, ainda vale conferir a
  cada mudança grande de infra): Swagger UI abrindo, `/api/racas` retornando
  lista, compêndio carregando com `VITE_API_BASE_URL` correto, cadastro/login
  funcionando (confirma `JWT_SECRET` + CORS/`FRONTEND_URL`), serviço aparecendo
  como `Live` no dashboard do Render.
- **Nem toda classe tem página dedicada ainda** — as que não têm caem no
  fallback genérico de `DetalheClasse.vue`, que lê os dados crus do backend e
  ainda mantém a seção "Tabelas originais" (texto bruto da fonte) só pra esse
  caso. Uma página dedicada nova segue o checklist completo no
  [`GUIA_PAGINA_DE_CLASSE.md`](../frontend/src/components/compendio/classes/GUIA_PAGINA_DE_CLASSE.md).
- **A política de "consolidar migrations em vez de empilhar"** (seção 1.6) foi
  decidida quando não havia banco persistente nenhum. Agora que existe um banco
  real no Supabase com histórico do Flyway aplicado, essa convenção precisa ser
  revisitada — editar uma migration já aplicada em produção quebra o checksum do
  Flyway; daqui pra frente, mudanças de schema em produção provavelmente exigem
  uma migration nova de verdade, não uma edição no arquivo existente.
- **O free tier do Render dorme após ~15 min de inatividade** — primeira
  requisição depois disso leva 30-50s. Ainda não avaliado se vale a pena migrar
  pra um plano pago ou manter algum "ping" externo pra manter o serviço acordado.
