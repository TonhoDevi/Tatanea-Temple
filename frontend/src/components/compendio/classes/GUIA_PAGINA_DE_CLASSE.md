# Guia — Como fazer a página de uma classe

Este documento existe porque `CacadorPagina.vue` foi a primeira página de classe do
compêndio a ser lapidada de verdade, e virou o molde pras outras 12 classes. Quando
for construir a próxima página de classe, siga este guia — ele é a referência, não
`CacadorPagina.vue` diretamente (ela é só o primeiro exemplo aplicado).

## Antes de começar

- **Cada classe tem sua própria página, escrita à mão.** Não existe um formato
  genérico o suficiente pra representar tabelas de D&D (espaços de magia, maneuvers
  conhecidas, características por nível) sem perder fidelidade. O compêndio e a
  ficha de personagem **não têm relação entre si**: a ficha usa a API do backend
  (habilidades com nível, tipo `HABILIDADE`/`FUNDAMENTO`) pra saber o que o
  personagem ganha; esta página é só leitura, pro jogador consultar a classe.
  Texto duplicado entre os dois é uma troca aceita.
- Toda página de classe dedicada:
  1. Cria um arquivo novo em `frontend/src/components/compendio/classes/`
     (ex.: `BardoPagina.vue`), seguindo a estrutura deste guia.
  2. É registrada em `DetalheClasse.vue`, no objeto `PAGINAS_DEDICADAS`, com a
     chave sendo o `id` da classe no backend (o nome em minúsculas, com acento —
     ex.: `'caçador'`).
  3. Até ser registrada lá, essa classe continua caindo no fallback genérico do
     próprio `DetalheClasse.vue`, que lê os dados crus do backend. O fallback
     nunca deve ser apagado — ele é o que sustenta as classes que ainda não têm
     página própria.
- **Todo o CSS de layout é global e compartilhado**, em
  `frontend/src/assets/styles/classe-pagina.css` — não é scoped, de propósito
  (Regra de Ouro nº4 do `theme.css`: nenhuma página deve duplicar essas regras).
  Ao criar uma classe nova, você quase nunca vai precisar adicionar CSS — as
  classes `.dc-*` já existem pra cada padrão descrito abaixo. Só crie CSS novo se
  o padrão visual for genuinamente novo (e, nesse caso, ele deve nascer genérico
  o bastante pra outra classe reaproveitar depois).

## Ordem das seções da página

Essa ordem é fixa, sempre, pra qualquer classe (dedicada ou fallback genérico):

1. **Cabeçalho** (retrato, nome, dado de vida, dificuldade, papéis) — vem de graça
   via `<ClassePaginaLayout :classe="classe">`, você só passa os dados.
2. **Descrição** — texto de flavor da classe, em colunas quando a tela é larga
   (`.dc-descricao-colunas`).
3. **Progressão** — a tabela de níveis. Vem **imediatamente depois da Descrição**,
   antes de qualquer outra coisa.
4. **Fundamentos da Classe** — os pontos fixos, comuns a toda classe (ver seção
   própria abaixo).
5. **Conjuração** — só se a classe conjura magias.
6. **Características da Classe** — a lista expansível de habilidades por nível.
7. **Subclasses**.

Não existe mais uma seção "Tabelas originais" com o texto bruto da fonte — isso
era andaime temporário enquanto o conteúdo ainda estava sendo formatado. Uma vez
que toda tabela/lista da página está devidamente estruturada, essa seção é
removida (ela permanece só no fallback genérico do `DetalheClasse.vue`, pras
classes que ainda não passaram por esse processo).

## 1. Progressão (tabela de níveis)

- Colunas fixas, nessa ordem: `Nível`, `Características`, ...colunas específicas
  da classe (dado de dano, recurso, etc.)..., e por último, **se a classe conjura
  magias**, o grupo `Espaços de Magia por Nível` com uma subcoluna por nível de
  magia. Esse grupo nunca vai no meio.
- **Toda coluna que não seja `Nível` ou `Características` é centralizada — isso
  vale tanto pro nome da coluna (cabeçalho) quanto pros valores (células).**
  Célula de dado usa `.dc-tabela-bonus` (já centralizado); cabeçalho usa a
  classe `.dc-th-centro` adicionada manualmente em cada `<th>` que não seja
  Nível/Características (um `<th>` sozinho é alinhado à esquerda por padrão,
  então isso nunca vem de graça — não esqueça de adicionar).
- `Características` é só um resumo curto (ex.: `'Ataque Extra, Talento'`) — o
  texto completo de cada uma vive na seção "Características da Classe" mais
  abaixo. Mecânicas universais (Incremento no Valor de Habilidade) **não** entram
  nessa coluna, porque acontecem todo nível — só entram eventos pontuais/notáveis
  (ex.: `Talento` nos níveis em que ele é concedido).
- **Nem toda classe conjuradora usa espaços de magia.** O Feiticeiro, por
  exemplo, usa um sistema de "Pontos de Magia" (uma reserva única de pontos,
  com uma tabela separada de custo-por-nível-de-magia) em vez de espaços por
  nível — nesse caso a Progressão troca o grupo `Espaços de Magia por Nível`
  por colunas próprias do sistema (`Truques Conhecidos`, `Magias Conhecidas`,
  `Nível de Magia`, `Pontos de Magia`), e a tabela de custo-por-ponto vira uma
  `tabela` dentro da própria característica "Conjurando com Pontos de Magia"
  em Características da Classe, não uma seção separada. Siga o formato de
  recurso que a fonte realmente usa, em vez de forçar o padrão de espaços de
  magia numa classe que não o usa.
- **Uma tabela de subclasse com mais de duas colunas de verdade** (ex.: o
  Feiticeiro Draconiano escolhe uma linhagem com colunas Dragão/Dano/
  Deslocamento/Magia, ou o Feiticeiro do Gênio tem magias por nível divididas
  em 4 tipos de gênio) não exige estender o componente de tabela — combine as
  colunas extras em uma única `colunaB` de texto corrido (ex.: `'Dano Ácido ·
  Deslocamento de natação · Magia: Flecha Ácida de Melf'`), mantendo o padrão
  `colunaA`/`colunaB` que todas as outras tabelas da página já usam.

## 2. Fundamentos da Classe

Regras fixas, iguais pra qualquer personagem daquela classe — não são
características "ganhas" a um nível específico. Cada uma vira um card dentro de
`.dc-fundamentos-grid`/`.dc-prof-lista`, sempre com um ícone SVG dedicado na
lateral direita (ver seção de ícones). Nessa ordem:

1. **Pontos de Vida** (`.dc-vida-card`) — uma caixa quadrada completa (sem corte
   de canto) com o dado de vida em destaque (`.dc-vida-dado`, ornamentada com os
   cantos de `dc-categoria-corner`/`dc-categoria-bracket`), e as fórmulas de PV
   como pares label/valor (`.dc-vida-stats`/`.dc-vida-stat`). O número do dado
   (`.dc-vida-dado-numero`) usa fonte monospace — simples e quadrada, não uma
   fonte decorativa — o "d" continua em Cinzel Decorative. **A fórmula em si
   segue um padrão fixo, mesmo que o material fonte venha diferente**: `nivel1`
   é `"{dado} + seu bônus de Salvaguarda de Constituição + 1"`, `niveisSuperiores`
   é `"{dado} + seu bônus de Salvaguarda de Constituição por nível de {classe}
   após o 1°"` — **nunca** "modificador de Constituição" (é sempre "bônus de
   Salvaguarda de Constituição") e **nunca** inclua a cláusula "+ metade do seu
   nível arredondado para baixo" no final, mesmo que o texto original da classe
   trouxer isso — essa parte foi removida do sistema pra todas as classes.
2. **Testes de Resistência e Perícias** (`.dc-prof-lista`, linhas com
   `.dc-prof-linha-com-icone`) — Testes de Resistência mostra os atributos como
   selos ornamentados que esticam pra preencher o bloco (`.dc-atributo-selos`/
   `.dc-atributo-selo`, com `estilo: 'selos'` no dado); Perícias usa chips
   simples (`.dc-chip-row`).
3. **Proficiências de Equipamento** — Armadura, Armas e Ferramentas agrupados
   num único bloco (`.dc-prof-subgrupos`/`.dc-prof-subgrupo`), não três blocos
   separados.
4. **Equipamento** (`.dc-equip-card`) — os itens iniciais, com escolhas (a)/(b)
   como chips ligados pela palavra "ou" (`.dc-equip-item`/`.dc-equip-ou`).
5. **Incremento no Valor de Habilidade** — uma frase descrevendo a regra (ex.:
   "a cada nível, +1 em um atributo; teto 20 até o nível 9, 26 depois") — **sem
   tabela e sem separar em "inferior/superior"**, isso foi simplificado.
6. **Talento** — texto seguido dos níveis em que é concedido, como uma corrente
   de nós circulares ligados por um cordão (`.dc-niveis-corrente`), não chips
   soltos.
7. **Escolha de Subclasse** (ex.: "Conclave de Caçador") — **é universal a toda
   classe, nunca fica dentro de "Características da Classe"**. As opções de
   subclasse aparecem como selos com ícone + nome (`.dc-subclasse-opcoes`/
   `.dc-subclasse-opcao`), derivados do próprio array `subclasses` da página
   (`subclasses.map(s => ({ nome: s.nome, icone: s.icone }))`) — nunca duplique
   nome/ícone em dois lugares. Como esse `const` lê `subclasses`, declare-o
   **depois** do array `subclasses` no script (`<script setup>` executa
   top-to-bottom; um `const` não pode referenciar outro ainda não inicializado).

## 3. Conjuração (só se a classe conjurar magias)

Dois cards lado a lado dentro de `.dc-conjuracao-par` (retângulos completos, com
anel em cada canto via `.dc-fundamento-retangular`/`.dc-fundamento-corner`, e um
pequeno conector — traço + losango dourado — ligando os dois cards no meio do
espaço entre eles; o conector some em telas estreitas, quando os cards empilham):

1. **Card 1** — declara o tipo de conjurador como selo de destaque (ex.: "O
   Caçador é [MEIO CONJURADOR]", via `.dc-conjuracao-tipo`), seguido de um texto
   curto explicando como aprender e trocar magias.
2. **Card 2** — a fonte da magia (qual dos três tipos — Natural, Divina ou
   Arcana — a classe usa; os três aparecem como chips, o aplicável em destaque
   dourado, os outros dois esmaecidos via `.dc-chip-tipo-magia-ativo`/
   `-inativo`), depois o nome do atributo de conjuração como título grande
   ladeado por linhas (`.dc-atributo-magia-linha`, reaproveitando `.dc-hr-line`
   do cabeçalho), e por fim as fórmulas de Bônus com Magia / CD de Magia como
   pares label/valor (reaproveitando `.dc-vida-stats`), com os termos da fórmula
   em `<strong>` (fica dourado automaticamente) e uma nota final em itálico
   pequeno e semitransparente (`.dc-formula-nota`).

## 4. Características da Classe

Lista expansível (`.dc-hab-lista`/`.dc-hab-item`), uma entrada por característica
ganha em algum nível.

- **Todo item nasce aberto.** A ausência de chave no objeto de estado
  (`caracteristicasAbertas`/`subclasseAbertas`) já significa "aberto" — o usuário
  fecha só o que não quer ver. Não inicialize os objetos com todas as chaves;
  use o padrão `estado[chave] !== false` pra "aberto por padrão".
- **Múltipla escolha é sempre tabela**, nunca texto corrido com
  `<strong>Nome.</strong>` nem uma grade de cards. Use o campo `tabela: { colunaA,
  colunaB, linhas: [{ a, b }] }` no objeto da característica, reaproveitando
  `.dc-tabela-wrap`/`.dc-tabela-niveis` (mesma classe da Progressão). A célula de
  efeito (`linha.b`) é renderizada com `v-html`, não `{{ }}`, porque também pode
  conter termos grifados (ver abaixo). **A distinção que importa é "escolha um" vs.
  "você ganha todos estes"**: uma característica do tipo "escolha uma das opções a
  seguir" (Estilo de Luta, opções de Canalizar Divindade, etc.) é tabela; uma
  característica do tipo "você ganha os seguintes benefícios" (todos ao mesmo
  tempo, ex. Marca do Caçador, a forma final de um juramento) é lista `<ul><li>`
  (ver o próximo item), não tabela — não confunda os dois padrões.
- **Ordem de leitura dentro do corpo importa**: texto de introdução (`corpo`)
  primeiro, depois a tabela/lista de opções, e só depois qualquer frase que só
  faz sentido tendo visto as opções (ex.: "você escolhe uma opção adicional nos
  níveis X e Y") — essa frase é um campo `notaFinal` separado, renderizado
  **depois** da tabela. Nunca funda essa frase na introdução.
- **Listas de bullet (•) embutidas na prosa viram `<ul><li>` de verdade**, não
  texto com "•" solto. Como `corpo` é renderizado com `v-html`, é só escrever a
  tag HTML direto dentro do template literal. Cada `<li>` ganha um bloco
  próprio, tingido, com borda dourada à esquerda e marcador em losango
  (`.dc-hab-descricao ul`/`li`).
- **Termos de jogo grifados**: sempre que um dos termos abaixo aparecer no texto
  de uma habilidade, envolva-o em `<span class="dc-termo">texto original</span>`
  — **nunca digite o termo em maiúsculas na string**; a classe `.dc-termo` já faz
  `text-transform: uppercase` + negrito + dourado, então a string continua
  português normal e só a página renderizada mostra caixa alta. A lista fixa
  (sentido mecânico do jogo, não o flavor — ex. não marcar "reação" nem
  "conjuração" como palavra solta):
  - AÇÃO (isolada, "como ação")
  - AÇÃO DE ATAQUE / AÇÃO DE ATAQUE CORPO A CORPO / ...CORPO A CORPO COM MAGIA /
    ...CORPO A DISTÂNCIA / ...CORPO A DISTÂNCIA COM MAGIA
  - AÇÃO BÔNUS
  - AÇÃO DE OCULTAR (também cobre "ação Ocultar", sem o "de")
  - AÇÃO DE DISPARADA (a frase toda — não marque só "Disparada")
  - CONJURAR (só o verbo "conjurar uma magia")
  - DESENGAJAR
  - INICIATIVA
  - DESLOCAMENTO
  - DESCANSO CURTO / DESCANSO LONGO — se o texto original elide o segundo
    "descanso" (ex.: "um descanso curto ou longo"), **expanda a frase** pra
    repetir a palavra, senão não dá pra marcar as duas metades
    (`um descanso curto ou descanso longo`)
  - VANTAGEM / DESVANTAGEM
  - TALENTO (só no sentido de escolha de talento)
  - Os seis atributos: Força, Destreza, Constituição, Inteligência, Sabedoria,
    Carisma
  - O nome de qualquer outra habilidade citada no texto (própria ou de outra
    característica/subclasse) — ex. "Marca do Caçador", "Destruição Planar"

## 5. Subclasses

Um card por subclasse (`.dc-subclasse`), nessa ordem interna:

1. **Cabeçalho** — o ícone (emoji) da subclasse dentro de uma moldura
   ornamentada (`.dc-subclasse-icone-moldura`, com os anéis de canto de
   `.dc-atributo-selo-corner`), ao lado do nome.
2. **Texto de introdução** da subclasse.
3. **Princípios** (opcional — só quando a subclasse tiver algo do tipo "tenets"/
   credo, como os juramentos do Paladino) — uma lista `principios: [string, ...]`
   no dado, renderizada como `<ul class="dc-principios">` (mesmo visual das
   listas de benefício, mas fora de uma característica expansível). Como são só
   texto plano, renderiza via `v-for`/`{{ }}` normal, não precisa de `v-html`
   a menos que algum princípio contenha um termo a grifar.
4. **Magias do Juramento / Magias por Nível** — sempre tabela (`Nível do
   {Classe}` / `Magia`, reaproveitando `.dc-tabela-wrap`/`.dc-tabela-niveis`),
   nunca um parágrafo com "Nível: 3º, 5º.../ Magias: X, Y...". No dado, isso é
   um array `magias: [{ nivel, magia }]`, não uma string `magiasTexto`. Se mais
   de uma magia for concedida no mesmo nível, junte-as em uma string só
   separada por vírgula (`magia: 'Escudo da Fé, Onda Trovejante'`) — não crie
   uma linha por magia. Se a classe não conjura magias, omita essa tabela
   inteira (nem toda classe/subclasse tem uma). Numa classe marcial cujas
   subclasses são majoritariamente não-conjuradoras mas uma delas concede
   magias (ex.: o Caminho do Kensei do Monge), coloque essa tabela dentro de
   um `v-if="s.magias && s.magias.length"` no template — só a subclasse que
   tem o campo `magias` no dado renderiza a tabela, as outras não têm o campo
   e o bloco inteiro some para elas.
5. **Características da subclasse** — mesma lista expansível de
   "Características da Classe" (item aberto por padrão, termos grifados,
   tabela pra múltipla escolha, `<ul><li>` pra "você ganha todos estes
   benefícios").

## Convenções visuais transversais

- **Zoom de 133% em desktop** é global, em `.dc-page` dentro de
  `@media (min-width: 901px)` — nunca por página/componente. Usa `zoom`, não
  `transform: scale`, porque `zoom` recalcula layout de verdade.
- **Caixa cortada vs. caixa completa**: a maioria dos cards usa o corte de canto
  padrão (`clip-path: polygon(14px 0, 100% 0, 100% calc(100% - 14px), calc(100%
  - 14px) 100%, 0 100%, 0 14px)`, já embutido em `.dc-fundamento`,
  `.dc-equip-card`, `.dc-vida-card` etc.). Elementos que precisam de **mais
  destaque** (Dado de Vida, os dois cards de Conjuração) usam caixa completa
  (sem `clip-path`) com anéis/diamantes nos quatro cantos — é a linguagem
  "isso é importante" da página. Use com moderação, não em todo card.
- **Fontes**: `Cinzel Decorative` pra títulos grandes e valores de destaque
  (nome da classe, nome do atributo de conjuração), `Cinzel` pra rótulos em
  caixa alta e pequenos (labels, chips), `Crimson Text` pro corpo de texto,
  monospace (`ui-monospace, Menlo, monospace`) só quando o objetivo é parecer
  "simples e quadrado" (ex.: o número do dado de vida), nunca uma fonte
  cursiva/blackletter (como Pirata One) em números — já tentamos e não ficou
  bom.
- **Cores**: sempre pelas variáveis do tema (`var(--tribal-gold)`,
  `var(--tribal-yellow)`, `var(--tribal-red)`, `var(--jungle-green)`,
  `var(--pale-green)`, `var(--bone)`, `var(--jungle-dark)`,
  `var(--jungle-moss)`, `var(--jungle-void)`), nunca cor fixa em hexadecimal
  solta no meio do CSS.

## Ícones (`classes/icones/`)

Os oito ícones abaixo representam conceitos **universais de Fundamentos da
Classe** (não são específicos do Caçador) — reaproveite-os tal como estão em
qualquer classe nova, sem redesenhar:

| Ícone | Arquivo | Representa |
|---|---|---|
| Coração com pulso | `IconeVida.vue` | Pontos de Vida |
| Livro aberto | `IconePericias.vue` | Perícias |
| Escudo com gema | `IconeResistencia.vue` | Testes de Resistência |
| Mochila de aventureiro | `IconeEquipamento.vue` | Equipamento |
| Espada e machado cruzados | `IconeProficienciaEquipamento.vue` | Proficiências de Equipamento |
| Escadaria de templo com gema | `IconeIncremento.vue` | Incremento no Valor de Habilidade |
| Medalha com fitas | `IconeTalento.vue` | Talento |
| Três caminhos se bifurcando | `IconeSubclasse.vue` | Escolha de Subclasse |

Só crie um ícone novo se a classe tiver um conceito de Fundamentos que nenhuma
classe anterior teve. Nesse caso, siga o mesmo estilo: SVG inline (`viewBox="0
0 64 64"`), cores via `var(--tribal-gold)`/`var(--tribal-yellow)`/
`var(--tribal-red)`/`var(--jungle-green)` (nunca cor fixa), formas geométricas
simples (círculos, diamantes, linhas retas) em vez de curvas complexas
desenhadas à mão — curvas livres (como uma coroa de louros) são difíceis de
acertar sem visualizar, e já tivemos que trocar uma por não ter ficado boa.

## Checklist pra uma classe nova

1. Copiar a estrutura de `CacadorPagina.vue` como ponto de partida.
2. Preencher `classe` (nome, ícone, cor, dado de vida, dificuldade, papéis) e
   `descricaoBlocos`.
3. Montar a tabela de `niveis` (Progressão), com a coluna `caracteristicas`
   contendo só eventos pontuais (nunca "Incremento no Valor de Habilidade").
4. Preencher Fundamentos da Classe, nessa ordem: Vida → Testes de
   Resistência/Perícias → Proficiências de Equipamento → Equipamento →
   Incremento → Talento → Escolha de Subclasse. Reaproveitar os ícones
   existentes.
5. Se a classe conjura: preencher os dois cards de Conjuração.
6. Preencher `caracteristicas` (Características da Classe): tabela pra
   múltipla escolha, `<ul><li>` pra listas de benefício, termos grifados,
   `notaFinal` quando precisar.
7. Preencher `subclasses`: cabeçalho ornamentado, `magias` como array
   estruturado, características de cada subclasse com as mesmas regras do
   passo 6.
8. Registrar a página em `DetalheClasse.vue` → `PAGINAS_DEDICADAS`.
9. Rodar o dev server e conferir que compila sem erro antes de considerar
   pronto (sem tirar screenshot — ver preferência salva na memória).
