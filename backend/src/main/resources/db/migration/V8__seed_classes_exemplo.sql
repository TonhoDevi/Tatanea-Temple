-- Dados reais migrados de CLASSES_DATA (js/compendium/data-classes.js)

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('ladino', 'Ladino', 'Versão Épico', '🗡️', '#4a7a8c', 'd6', 'Intermediário', 'Ladinos contam com perícia, furtividade e as vulnerabilidades dos inimigos para obter vantagem em qualquer situação. Mestres da astúcia, eles preferem um ataque preciso a uma barragem de força bruta.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Furtividade', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Suporte', 2);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Exploração', 3);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('ladino', 'Proficiências', 'Armadura: Armaduras leves
Armas: Armas simples, bestas de mão, espadas longas, rapieiras, espadas curtas
Ferramentas: Ferramentas de ladrão
Testes de Resistência: Destreza, Inteligência
Perícias: Escolha quatro: Acrobacia, Atletismo, Atuação, Enganação, Furtividade, Intimidação, Intuição, Investigação, Percepção, Persuasão e Prestidigitação', 'FUNDAMENTO', NULL, 0);
INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('ladino', 'Assassino', '💀', 'Arte da morte, veneno e disfarce', NULL, 0);
INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('ladino', 'Inquisidor', '🔍', 'Detecção de mentiras e combate intuitivo', NULL, 1);
INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('ladino', 'Ladrão', '🔑', 'Roubo, escalada e itens mágicos', NULL, 2);
INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('ladino', 'Saqueador', '🏹', 'Sobrevivência, emboscadas e mobilidade', NULL, 3);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('paladino', 'Paladino', 'Versão Épico', '⚜️', '#c9a24a', 'd10', 'Intermediário', 'Paladinos unem fé e aço, extraindo poder divino do juramento que fizeram para curar aliados, destruir o mal e proteger os inocentes. Onde a espada falha, a convicção prevalece.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('paladino', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('paladino', 'Tanque', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('paladino', 'Suporte', 2);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('paladino', 'Cura', 3);

-- Classes ainda sem página dedicada nem conteúdo revisado — cadastro
-- provisório (dados de exemplo) só pra elas aparecerem no compêndio.
-- Cada uma vira uma dedicada de verdade (ver GUIA_PAGINA_DE_CLASSE.md)
-- quando o material de origem for enviado.
INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('bárbaro', 'Bárbaro', 'Versão Épico', '🪓', '#8c4a3a', 'd12', 'Fácil', 'Guerreiros movidos pela fúria primal, capazes de ignorar a dor e esmagar tudo em seu caminho.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bárbaro', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bárbaro', 'Tanque', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bárbaro', 'Resistência', 2);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('bardo', 'Bardo', 'Versão Épico', '🎻', '#8c4a7a', 'd8', 'Difícil', 'Artistas que tecem magia através de música, palavras e performance.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bardo', 'Suporte', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bardo', 'Utilidade', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('clérigo', 'Clérigo', 'Versão Épico', '☀️', '#d4c05a', 'd8', 'Média', 'Canais da vontade divina, empunhando milagres e cura em nome de seus deuses.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('clérigo', 'Cura', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('clérigo', 'Suporte', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('guerreiro', 'Guerreiro', 'Versão Épico', '⚔️', '#6a6a6a', 'd10', 'Fácil', 'Mestres do combate marcial, versáteis com qualquer arma ou armadura.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('guerreiro', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('guerreiro', 'Tanque', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('monge', 'Monge', 'Versão Épico', '🥋', '#4a8c6a', 'd8', 'Difícil', 'Guerreiros que canalizam energia interior para golpes velozes e sobrenaturais.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('monge', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('monge', 'Mobilidade', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('mago', 'Mago', 'Versão Épico', '📖', '#4a5a8c', 'd6', 'Difícil', 'Estudiosos da magia arcana, moldando a realidade através do conhecimento e da disciplina.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('mago', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('mago', 'Controle', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('feiticeiro', 'Feiticeiro', 'Versão Épico', '✨', '#8c4a8c', 'd6', 'Difícil', 'Conjuradores cuja magia nasce de um dom inato, não de estudo.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('feiticeiro', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('feiticeiro', 'Controle', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('druida', 'Druida', 'Versão Épico', '🍃', '#2f7a3a', 'd6', 'Difícil', 'Guardiões da natureza, capazes de assumir formas selvagens e comandar os elementos.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('druida', 'Suporte', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('druida', 'Controle', 1);

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('bruxo', 'Bruxo', 'Versão Épico', '👁️', '#4a3a6a', 'd8', 'Média', 'Conjuradores que trocam serviço por poder em pactos com entidades além da compreensão mortal.', NULL);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bruxo', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('bruxo', 'Utilidade', 1);

-- Artífice fica de fora por enquanto — o material de origem ainda não
-- está pronto (será extraído de outro site depois). Sem linha em
-- `classes`, ela simplesmente não aparece no compêndio até ser cadastrada.

-- ================================================================
-- Caçador — classe completa (tabela de progressão, características
-- nomeadas por nível e as 3 subclasses com magias e características
-- próprias). Texto transcrito integralmente da referência enviada.
-- ================================================================

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, dificuldade, descricao_intro, tabelas_texto_bruto) VALUES ('caçador', 'Caçador', 'Versão Épico', '🏹', '#4a8a5a', 'd10', 'Média', 'Longe do burburinho das cidades e vilas, passadas as sebes que abrigam as fazendas mais distantes dos terrores da natureza selvagem, em meio as árvores densas de florestas sem trilhas e através de planícies vastas e desertas, os caçadores mantém sua vigília interminável.

Guerreiros da natureza, diversos e variados em seus talentos e especializações, todos os caçadores compartilham uma característica de ter uma conexão profunda com a natureza. Os caçadores dominam várias armas para atacar ameaças à sua terra natal de perto e de longe. Eles aprendem a rastrear suas presas como um predador faz, movendo-se furtivamente através da natureza e escondendo-se na selva ou na grama. Graças a sua familiaridade com a natureza, os caçadores também adquirem a capacidade de conjurar magias que aproveitam o poder da natureza, como fazem os druidas. Seus feitiços, como suas habilidades em combate, enfatizam velocidade, furtividade e a caçada. Os talentos e habilidades de um caçador são aprimorados com uma experiência de combate mortal lutando contra ameaças nas fronteiras da civilização.

Caçadores são guerreiros ágeis e hábeis que usam seu conhecimento das terras selvagens para rastrear e caçar seus inimigos. Seja espreitando através da floresta no rastro de intrusos malignos, se aliando com um companheiro animal, ou focando suas habilidades de combate em criaturas aberrantes, os caçadores podem ser letais em suas táticas.

Independente dos métodos que os caçadores empreguem, os adversários considerarem enfrentá-los o mais difícil desafio que eles provavelmente enfrentarão, desde que eles permaneçam no terreno natural de um caçador. Mas os caçadores também podem adaptar suas habilidades para lutar em cidades e masmorras, fazendo deles valiosas figuras em muitos partidos de aventureiros.

Embora um caçador possa fazer uma vida como um rastreador ou caçador, o verdadeiro chamado de um caçador é defender as partes exteriores da civilização das incursões de monstros e hordas humanoides que pressionam das terras selvagens. Em algumas regiões, os caçadores se reúnem em ordens secretas ou se juntam a círculos de druidas. Muitos caçadores, porém, são independentes quase ao ponto de serem reclusos, conhecendo apenas suas famílias ou mestres que os ensinaram suas formas.

Um caçador pode escolher aventurar-se por várias razões. Proteger as fronteiras muitas vezes significa encontrar e derrotar bandidos, orcs, trolls, gigantes e piores criaturas. Mas alguns caçadores encontram-se assistindo às rotas de comércio. Todos esses esforços caem dentro do domínio natural do caçador.', '— Tabela O Caçador (texto original, não reformatado) —

Level | Bônus de Proficiência
1st
2nd
3rd
4th
5th
6th
7th
8th
9th
10th
11th
12th
13th
14th
15th
16th
17th
18th
19th
20th
+2
+2
+2
+2
+3
+3
+3
+3
+4
+4
+4
+4
+5
+5
+5
+5
+6
+6
+6
+6

Características
Marca do Caçador, Território de Caça
Estilo de Luta, Conjuração, Incremento no valor de habilidade inferior
Conclave de Caçador
Incremento no valor de habilidade superior
Ataque Extra, Incremento no valor de habilidade inferior
Desaparecer, Incremento no valor de habilidade superior
Característica de Conclave
Pés Rápidos, Incremento no valor de habilidade superior, Incremento no valor de habilidade inferior
-
Augmentação Sombria, Incremento no valor de habilidade superior
Característica de Conclave, Incremento no valor de habilidade inferior
Incremento no valor de habilidade superior
-
Alma Endurecida, Incremento no valor de habilidade superior, Incremento no valor de habilidade inferior
Característica de Conclave
Incremento no valor de habilidade superior
Incremento no valor de habilidade inferior
Perspicácia na Caça, Característica de Conclave
Lendário, Incremento no valor de habilidade superior
Matador de Inimigos, Incremento no valor de habilidade inferior

— Espaços de Magia por Nível — (texto original, colunas 1st a 5th, não
recuperáveis com segurança na extração — mantido como veio na fonte)

1st
2nd
3rd 4th 5th
—
—
—
—
—
2
—
—
—
—
3
3
4
4
5
53
3
4
4
4
4—
—
2
2
3
3—
—
—
—
—
——
—
—
—
—
——
—
—
—
—
—
6
64
43
32
2—
——
—
7433——
7
8
84
4
43
3
33
3
3—
1
1—
—
—
9
9
10
10
11
114
4
4
4
4
43
3
3
3
3
33
3
3
3
3
32
2
3
3
3
3—
—
1
1
2
2

Magias Conhecidas — 2 —');
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Controle', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Exploração', 2);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Sobrevivência', 3);
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 1, '+2', 'Marca do Caçador, Território de Caça');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 2, '+2', 'Estilo de Luta, Conjuração, Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 3, '+2', 'Conclave de Caçador');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 4, '+2', 'Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 5, '+3', 'Ataque Extra, Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 6, '+3', 'Desaparecer, Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 7, '+3', 'Característica de Conclave');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 8, '+3', 'Pés Rápidos, Incremento no valor de habilidade superior, Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 9, '+4', '-');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 10, '+4', 'Augmentação Sombria, Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 11, '+4', 'Característica de Conclave, Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 12, '+4', 'Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 13, '+5', '-');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 14, '+5', 'Alma Endurecida, Incremento no valor de habilidade superior, Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 15, '+5', 'Característica de Conclave');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 16, '+5', 'Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 17, '+6', 'Incremento no valor de habilidade inferior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 18, '+6', 'Perspicácia na Caça, Característica de Conclave');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 19, '+6', 'Lendário, Incremento no valor de habilidade superior');
INSERT INTO classe_niveis (classe_id, nivel, bonus_proficiencia, caracteristicas) VALUES ('caçador', 20, '+6', 'Matador de Inimigos, Incremento no valor de habilidade inferior');
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Pontos de Vida', 'Dado de Vida: 1d10 por nível de Caçador
Pontos de vida no 1° nível: 10 + seu modificador de Constituição + 1
Pontos de vida em níveis superiores: 10 + seu modificador de Constituição por nível de caçador após o 1° + metade do seu nível arredondado para baixo', 'FUNDAMENTO', NULL, 0);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Proficiências', 'Armadura: Armaduras leves, armaduras médias, escudos
Armas: Armas simples, armas marciais
Ferramentas: Nenhuma
Testes de Resistência: Inteligência, Sabedoria
Perícias: Escolha três entre Acrobacia, Arcana, Atletismo, Furtividade, História, Percepção, Investigação, Religião e Sobrevivência', 'FUNDAMENTO', NULL, 1);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Equipamento', 'Você começa com o seguinte equipamento, além do equipamento concedido pelo seu antecedente:
• (a) brunea ou (b) armadura de couro
• (a) duas espadas curtas ou (b) duas armas simples corpo-a-corpo
• (a) um pacote de explorador ou (b) um pacote de aventureiro
• Um arco longo e uma aljava com 20 flechas', 'FUNDAMENTO', NULL, 2);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Incremento no Valor de Habilidade Inferior', 'Quando você atinge o 2° nível e novamente no 5°, 8°, 11°, 14°, 17° e 20° nível, você pode aumentar dois valores de habilidade, à sua escolha em 1. Como padrão, você não pode elevar um valor de habilidade acima de 20 com essa característica.', 'FUNDAMENTO', NULL, 3);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Incremento no Valor de Habilidade Superior', 'Quando você atinge o 4° nível e novamente no 6°, 8°, 10°, 12°, 14°, 16° e 19° nível, você pode aumentar um valor de habilidade, à sua escolha, em 2 ou você pode aumentar dois valores de habilidade, à sua escolha, em 1. Como padrão, você não pode elevar um valor de habilidade acima de 26 com essa característica. Além disso, você recebe um talento.', 'FUNDAMENTO', NULL, 4);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Marca do Caçador', 'Começando no 1º nível, você pode focar seus sentidos em uma criatura, marcando-a misticamente como sua presa. Como uma ação bônus, você pode marcar uma criatura que você possa ver em um raio de 27 metros de você. Alternativamente, você pode marcar uma criatura estudando seus rastros por pelo menos 1 minuto. O alvo é marcado enquanto está no mesmo plano de existência que você e não está protegido de magias de adivinhação. A marca também desaparece se você terminar um descanso curto ou longo, ficar inconsciente ou usar este recurso novamente para atingir outra criatura.
Enquanto uma criatura estiver marcada, você ganha os seguintes benefícios:
• Você tem vantagem em qualquer teste de Sabedoria (Percepção) ou Sabedoria (Sobrevivência) para encontrar o alvo.
• Uma vez por turno, quando você acerta o alvo com um ataque com arma, você causa dano adicional conforme mostrado na coluna Dano de Marca do Caçador na tabela O Caçador.
Você pode usar esse recurso um número de vezes igual ao seu modificador de Sabedoria (no mínimo uma vez) e você recupera todos usos gastos quando você termina um descanso curto ou longo.', 'HABILIDADE', 1, 5);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Território de Caça', 'Você tem um talento natural para percorrer o mundo. Você ganha proficiência na perícia de Natureza ou Sobrevivência. Se você já está proficiente em Natureza ou Sobrevivência, seu bônus de proficiência é dobrado para qualquer teste de habilidade que você fizer e que o utilize.
Quando você for procurar por comida e tiver sucesso no teste de Sabedoria (Sobrevivência), você descobre duas vezes mais comida e água do que normalmente faria. Se você falhar, você ainda encontrará metade da quantidade de comida e água que normalmente seria. Ao rastrear outras criaturas, você também aprende o número exato de indivíduos, seus tamanhos e há quanto tempo eles passaram pela área.
Além disso, você está particularmente familiarizado com um tipo de ambiente e são adeptos das habilidades exclusivas da região. Escolha um tipo de terreno preferido:
Costa. Nadar não custa mais movimento extra. Você também pode prender a respiração três vezes mais do que normalmente pode.
Deserto. Você está naturalmente adaptado a climas quentes. Você também ganha resistência contra danos de fogo.
Floresta. Você possui vantagem em todos os testes de percepção.
Pastagem. Sua velocidade aumenta em 3 metros.
Montanha. Escalar não custa mais movimento extra. Além disso, você está naturalmente adaptado a grandes altitudes.
Pântano. Você ganha resistência a dano venenoso e tem vantagem em testes de resistência contra doenças.
Tundra. Você está naturalmente adaptado a climas frios. Você também ganha resistência contra danos de frio.
Subterrâneo. Você aprende Sub-comum. Se você não tem visão no escuro, você a ganha com um alcance de 9 metros. Se você tem visão no escuro, você ganha visão às cegas com um alcance de 1,5 metro.
Urbano. Você ganha proficiência em Investigação e seu bônus de proficiência é duplicado para qualquer teste de habilidade que você fizer com essa habilidade. Você também aprende a falar, ler e escrever uma linguagem humanoide de sua escolha.
Você escolhe um tipo de terreno favorito adicional no 6º nível, no 10º nível e 14º nível.', 'HABILIDADE', 1, 6);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Estilo de Luta', 'No 2° nível, você adota um estilo de combate particular que será sua especialidade. Escolha uma das opções a seguir. Você não pode escolher o mesmo Estilo de Combate mais de uma vez, mesmo se puder escolher de novo.
Arquearia. Você ganha +2 de bônus nas jogadas de ataque realizadas com uma arma de ataque à distância.
Combate com Duas Armas. Quando você estiver engajado em uma luta com duas armas, você pode adicionar o seu modificador de habilidade na jogada de dano do seu segundo ataque.
Defesa. Enquanto estiver usando armadura, você ganha +1 de bônus em sua CA.
Duelista. Quando você empunhar uma arma de ataque corpo-a-corpo em uma mão e nenhuma outra arma, você ganha +2 de bônus nas jogadas de dano com essa arma.', 'HABILIDADE', 2, 7);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Conjuração', 'Quando você alcança o 2° nível, você aprende a usar a essência mágica da feitiçaria de sangue para conjurar feitiços arcanos.
Espaços de Magia
O Caçador é um meio conjurador.
Magias Conhecidas de 1° Nível e Superiores
Você conhece duas magias de 1° nível, à sua escolha, da lista de magias de caçador.
A coluna Magias Conhecidas na tabela O Caçador mostra quando você aprende mais magias de caçador, à sua escolha. Cada uma dessas magias deve ser de um nível a que você tenha acesso, como mostrado na tabela. Por exemplo, quando você alcança o 5° nível da classe, você pode aprender uma nova magia de 1° ou 2° nível.
Além disso, quando você adquire um nível nessa classe, você pode escolher uma magia de caçador que você conhece e substituí-la por outra magia da lista de magias de caçador, que também deve ser de um nível ao qual você tenha espaços de magia.', 'CONJURACAO', 2, 8);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Habilidade de Conjuração', 'CD do Teste de Resistência de Magia = 8 + seu bônus de proficiência + seu modificador de Sabedoria
Modificador de Ataque Mágico = seu bônus de proficiência + seu modificador de Sabedoria', 'CONJURACAO', 2, 9);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Habilidade de Conjuração', 'Sabedoria é a sua habilidade para conjurar suas magias de caçador, já que sua magia vem da sua sintonia com a natureza. Você usa sua Sabedoria sempre que alguma magia se referir a sua habilidade de conjurar magias. Além disso, você usa o seu modificador de Sabedoria para definir a CD dos testes de resistência para as magias de caçador que você conjura e quando você realiza uma jogada de ataque com uma magia.', 'CONJURACAO', 2, 10);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Conclave de Caçador', 'No 3° nível, você escolhe emular os ideais de treinamento de um conclave de caçador. Escolha uma das subclasses de caçador detalhada na sessão de subclasses. Sua escolha lhe concede características no 3° nível e novamente no 7°, 11°, 15° e 18° nível.', 'HABILIDADE', 3, 11);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Ataque Extra', 'A partir do 5° nível, você pode atacar duas vezes, ao invés de uma, sempre que você realizar a ação de Ataque no seu turno.', 'HABILIDADE', 5, 12);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Desaparecer', 'A partir do 6º nível, sua velocidade e furtividade em combate tornam difícil de definir. Você pode realizar a ação Ocultar como uma ação bônus e você não pode ser rastreado por meios não mágicos, a menos que você decida deixar um rastro. Além disso, se você estiver escondido ao rolar a iniciativa, fazer um ataque durante a primeira rodada de combate não revele sua localização se você cumprir as condições necessárias para se esconder.', 'HABILIDADE', 6, 13);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Pés Rápidos', 'Começando no 8° nível, você pode usar a ação de Disparada como uma ação bônus no seu turno.', 'HABILIDADE', 8, 14);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Augmentação Sombria', 'Começando no 10º nível, a magia infunde seu corpo para reforçar permanentemente sua resiliência. Sua velocidade aumenta em 5 pés, e você tem um bônus em testes de resistência de Força, Destreza e Constituição igual ao seu dado de dano de marca do caçador.', 'HABILIDADE', 10, 15);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Alma Endurecida', 'Começando no 14° nível, você se torna imune a condições amedrontado e tem vantagem em testes de resistência contra magias de encantamento.', 'HABILIDADE', 14, 16);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Perspicácia na Caça', 'No 18° nível, você desenvolve uma mentalidade predatória intranspassável, permitindo-lhe canalizar o poder da magia para sua proteção contra suas presas. Você recebe resistência a todos os danos causados pelo seu alvo da Marca do Caçador.', 'HABILIDADE', 18, 17);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Lendário', 'Ao atingir o 19°, você pode escolher um talento épico.', 'HABILIDADE', 19, 18);
INSERT INTO classe_caracteristicas (classe_id, titulo, corpo, tipo, nivel, ordem) VALUES ('caçador', 'Matador de Inimigos', 'No 20° nível, você se torna um caçador incomparável. Uma vez em cada um dos seus turnos, você pode adicionar seu modificador de Sabedoria na jogada de ataque e jogada de dano de um ataque que você fizer. Você pode escolher usar essa característica antes ou depois da rolagem, mas antes de qualquer efeito da jogada ser aplicado.', 'HABILIDADE', 20, 19);

INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('caçador', 'Exterminador Profano', '☠️', 'Os Exterminadores Profanos são uma irmandade enigmática dedicada a erradicar o mal através do uso da magia negra. Estes caçadores sombrios empregam conhecimentos proibidos para rastrear e extinguir criaturas profanas, desfazendo suas existências corrompidas em uma busca implacável pela purificação do mundo. No entanto, seu compromisso com a erradicação do mal não vem sem custos, e cada Exterminador carrega o peso sombrio do sacrifício pessoal enquanto se aventuram nas profundezas das trevas para proteger a existência de todos.', 'Nível do Caçador: 3º, 5º, 9º, 13º, 17º
Magias: Bruxaria, Raio do Enfraquecimento, Rogar Maldição, Sombra de Trastorno, Praga', 0);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Magia do Exterminador Profano', 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Exterminador Profano. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.', 3, 0);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Guerreiro Profano', 'No 3º nível, você ganha a habilidade de canalizar essência vital para amaldiçoar e manipular criaturas por meio de magia negra. Quando você estiver com uma criatura marcada com sua Marca do Caçador você pode nos turnos subsequentes infligir uma maldição no alvo. Se uma maldição pedir por uma jogada de ataque ou teste de resistência, o seu bônus e CD serão iguais ao de sua habilidade de conjuração.
Você pode utilizar uma maldição um número de vezes igual ao seu bônus de proficiência e recupera todos os usos após um descanso curto ou longo.', 3, 1);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Artes Obscuras', 'No 3° nível, suas pesquisas e esforços fizeram você aprender três maldições diferentes que permitem enfraquecer suas presas.
Maldição de Ansiedade. Com uma ação bônus, você intensifica o medo no corpo da criatura, tornando-a suscetível a influências fortes. Até o começo do seu próximo turno, todas as criaturas têm vantagem em testes de Carisma (Intimidação) direcionados à criatura alvo.
Maldição de Prisão. Com uma ação bônus, você tenta infligir uma onda letárgica que fraqueja as pernas do alvo. O alvo deve ter sucesso em um teste de resistência de Força ou terá sua velocidade reduzida a 0 e não pode usar reações até o começo do seu próximo turno.
Maldição de Escuridão. Com uma ação bônus, você obscurece a visão da criatura com sombras de morte. O alvo deve ser bem sucedido em um teste de resistência de Constituição ou ficar cego até o início do seu próximo turno.', 3, 2);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Assombração Impiedosa', 'No 7º nível, seu desenvolvimento e descobertas lhe garantiram mais três maldições em seu repertório de artes negras.
Maldição de Agonia. Com uma ação bônus, você amaldiçoa a criatura com uma doença profunda que sensibiliza suas defesas. A criatura tem desvantagem em testes de habilidade de Força e Destreza e sofre 1d8 de dano necrótico sempre que for atingida por um ataque até o começo do seu próximo turno.
Maldição de Feridas. Com uma ação bônus, você pode tentar infligir uma praga na carne da sua presa. O alvo deve ser bem sucedido em um teste de resistência de Constituição ou não poderá se curar até o início do seu próximo turno.
Maldição de Estalo. Com uma reação, você lança um som terrível em forma de gritos diretamente para a mente da criatura. Quando a criatura tentar realizar uma jogada de d20 você pode utilizar essa maldição para diminuir o resultado em um valor igual ao seu dado de dano de caçador.
Além disso, você se torna mais acostumado com as armas que criaturas horrendas usam. Você recebe resistência a dano de veneno e vantagem em teste de resistência contra ser envenenado.', 7, 3);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Caçador de Horrores', 'No 11º nível, suas experiências com os horrores desse mundo garantiram a você a potência e as habilidades necessárias para sobreviver a elas, fazendo com que você aprenda mais 3 maldições.
Maldição de Fraqueza. Com uma reação, você aflige a criatura com uma paralisia a deixando vulnerável brevemente. Quando a criatura sofrer um ataque ou magia, você pode usar sua reação para tentar paralisar. A criatura deve ser bem sucedida em um teste de resistência de Sabedoria ou irá ficar sobre a condição paralisada durante a realização do ataque ou magia que desencadeou a maldição.
Maldição da Transfusão. Com uma ação bônus, você pode rasgar a vitalidade da criatura e utilizar essa fagulha de energia a seu favor. A criatura deve ser bem sucedida em um teste de resistência de Constituição ou sofrerá uma quantidade de dano de Force igual ao seu dado de dano de caçador mais o seu nível. Ou metade em um sucesso. Você pode curar uma criatura a até 9m de você em uma quantidade de pontos de vida igual ao dano causado.
Maldição de Dilacerar Magia. Com uma reação, você pode tentar perturbar a mente da criatura derrubando sua concentração. Se a criatura estiver conjurando ou mantendo uma magia, você pode obrigar ela a realizar um teste de resistência de Inteligência. Em uma falha a magia conjurada ou mantida é perdida.
Além disso, você se torna mais próximo ao profano se tornando mais resistente às artes negras. Você recebe resistência a dano Necrótico e seu máximo de pontos de vida não pode ser diminuído de nenhuma forma.', 11, 4);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Exterminador Profano'), 'Senhor das Maldições', 'No 15º nível, suas maldições atingiram o máximo de seu crescimento fazendo com que você tenha acesso as mais poderosas das maldições.
Maldição do Reflexo Frágil. Com uma ação bônus, você aflige a criatura com uma sensação de prisão e agonia. A criatura amaldiçoada vê seu corpo amarrado por magia negra diminuindo seus reflexos. Até o início do seu próximo turno, seus testes de resistência de Força, Destreza e a sua CA são diminuídos em um valor igual a uma rolagem de seu dado de dano de caçador.
Maldição da Atração Desenfreada. Com uma ação bônus, você pode amaldiçoar a criatura com uma compulsão por destruição. Ela deve ser bem sucedida em um teste de resistência de Sabedoria ou será atraída por alvos aliados, atacando-os no seu próximo turno.
Maldição do Tormento Desenfreado. Com uma ação bônus, você inflige dor na pele da criatura que a faz agonizar em destruição. A criatura deve ser bem sucedida em um teste de resistência de Sabedoria ou sofrerá um dano Psíquico igual a três vezes o seu dado de dano de caçador mais o seu nível e ficará amedrontada por você até o final do seu próximo turno. Uma criatura sofre metade em um sucesso e nenhum efeito.
Além disso, você tem vantagem em qualquer teste de resistência que envolva magia de necromancia.', 15, 5);

INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('caçador', 'Perseguidor do Horizonte', '🌀', 'Os Perseguidores do Horizonte protegem o mundo contra ameaças que se originam de outros planos ou que buscam devastar o reino mortal com magia de outros mundos. Eles procuram por portais planares e os vigiam, aventurando-se nos Planos Interiores e nos Planos Exteriores conforme necessário para enfrentar seus inimigos. Esses rangers também são aliados a qualquer força no multiverso — especialmente dragões benevolentes, seres feéricos e elementais — que trabalhem para preservar a vida e a ordem dos planos.', 'Nível do Caçador: 3º, 5º, 9º, 13º, 17º
Magias: Proteção contra o Bem e o Mal, Passo Nebuloso, Clarividência, Banimento, Vidência', 1);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Magia do Andarilho do Horizonte', 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Andarilho do Horizonte. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.', 3, 0);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Viajante Espectral', 'No 3º nível, você acumulou conhecimento dos muitos planos no multiverso, sempre contribuindo com orientações de lugares distantes. Você ganha proficiência em sua escolha entre História, Arcana ou Natureza. Se você já possui proficiência, você ganha especialização na habilidade escolhida. Além disso, sempre que fizer um teste de resistência de Inteligência, você pode adicionar seu modificador de Sabedoria ao resultado (mínimo de +1).', 3, 1);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Caçador Extraplanar', 'No 3º nível, você ganha a habilidade de detectar magicamente a presença de portais planares e criaturas extraplanares. Como ação, você detecta a distância e direção para o portal planar mais próximo dentro de 1,6 km de você. Além disso, você detecta a distância e direção para a criatura fey, celestial, abissal, elemental ou aberrante mais próxima dentro de 1,6 km de você que tenha sido convocada por um feitiço de 3º nível ou superior. Você pode usar essa habilidade um número de vezes igual ao bônus de proficiência, recuperando todos os usos em um descanso longo.', 3, 2);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Destruição Planar', 'No 3º nível, você aprende a canalizar a energia do multiverso para aprimorar seus ataques contra sua presa. Contra o alvo de sua marca do caçador, você pode escolher aprimorar seu golpe causando 1d8 de dano extra e transformar todo o dano causado em dano de Force. Você pode utilizar essa habilidade uma quantidade de vezes igual ao seu bônus de proficiência a cada descanso longo. Quando atinge o 11º nível nesta classe, o dano extra aumenta para 2d8.', 3, 3);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Foco Infinito', 'No 7º nível, você consegue ver as pequenas fissuras do espaço que nascem graças a magia que existe dentro de qualquer indivíduo. No começo do seu turno uma criatura inimiga aleatória se torna fragilizada em um ponto à sua volta. Role 1d8 para saber qual diagonal ou lateral o indivíduo está fragilizado. Se você atacar uma criatura em seu ponto fragilizado ela sofre automaticamente os efeitos de sua Destruição Planar.', 7, 4);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Caçada Dimensional', 'No 11º nível, sua determinação para perseguir sua presa se torna imparável não importa onde estejam. Você pode marcar criaturas independente da distância com sua Marca do Caçador desde que ela esteja no mesmo plano que você e você a tenha conhecido pessoalmente pelo menos uma vez. Você pode com uma ação bônus teletransportar a até 9m de distância do seu alvo marcado pela sua Marca do Caçador desde que ele esteja no mesmo plano que você.
Além disso, após você teletransportar dessa forma, você recebe vantagem em suas jogadas de ataque contra o seu alvo marcado neste turno.', 11, 5);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Perseguidor do Horizonte'), 'Conhecimento Planar', 'No 15º nível, sua habilidade de perseguir suas presas se tornam infinitas quebrando até barreiras interdimensionais. Você ganha os seguintes benefícios:
• Com seu Foco infinito você pode marcar uma criatura com sua Marca do Caçador mesmo que ela esteja em qualquer lugar do multiverso, desde que você a conheça. Você sempre sabe em que plano ela está.
• Com sua Caçada Dimensional você pode teletransportar para o seu alvo independente de seu plano atual. Você ganha uma visão do local antes de teletransportar, podendo agora escolher qualquer lugar até 500 pés do alvo.
• Quando uma criatura marcada por sua Marca do Caçador que esteja a até 9m de você tentar ir para mais de 9m de distância de você, você pode com uma reação forçar a criatura a realizar um teste de resistência de Sabedoria ou será teletransportada para um local a até 9m de você. O local deve ser uma superfície desocupada.
• Quando uma criatura marcada por sua Marca do Caçador acertar um ataque contra você, você pode com uma reação teletransportar para um local a até 9m delas fazendo com que o ataque erre automaticamente.', 15, 6);

INSERT INTO classe_subclasses (classe_id, nome, icone, intro_texto, magias_texto, ordem) VALUES ('caçador', 'Predador Primal', '🐾', 'Os Predadores Primais mantém viva uma tradição ancestral há muito esquecida pela história escrita. Vivendo distantes da sociedade moderna, esses caçadores preservam um código de honra enraizado na natureza, sentindo-se deslocados em um mundo que valoriza a inovação sobre a sabedoria antiga. Desconfiados da tecnologia, eles formam vilas junto a bárbaros e druidas, onde a conexão com a natureza é venerada. Seu dogma de vida reside na busca e no deleite da caça, uma essência fundamental que permeia suas existências, moldando cada passo e decisão.', 'Nível do Caçador: 3º, 5º, 9º, 13º, 17º
Magias: Golpe de Zephyr, Aprimorar Habilidade, Velocidade, Movimentação Livre, Fortalecimento de Perícia', 2);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Predador Primal'), 'Magia do Predador Primal', 'Ao atingir o 3º nível, você aprende uma magia adicional ao alcançar determinados níveis nesta classe, como indicado na tabela de Magias do Predador Primal. A magia conta como uma magia de caçador para você, mas não conta no número de magias de caçador que você conhece.', 3, 0);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Predador Primal'), 'Caça Bruta', 'Começando no 3º nível, você possui a experiência de combate e tenacidade de perseguir suas presas até que seus espíritos quebrem. Enquanto você marcar uma criatura com sua Marca do Caçador você recebe os seguintes benefícios enquanto estiver em sua perseguição:
• Sua velocidade de caminhada aumenta em 10 pés.
• Você tem vantagem em testes de resistência de Destreza e teste de habilidade de Atletismo e Acrobacia, contra efeitos que possa ver, como armadilhas, obstáculos e magias. Para obter esse benefício, você não pode estar cego, surdo ou incapacitado.
• Você recebe deslocamento de escalada e natação igual ao seu deslocamento de caminhada.
• Você ganha um bônus em sua Classe de Armadura igual ao seu bônus de proficiência contra sua criatura marcada.', 3, 1);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Predador Primal'), 'Caçador Incessável', 'No 7º nível, seus instintos e condicionamento para a caçada se tornam potentes o alertando do perigo e garantindo que você possa reagir a qualquer situação. Enquanto você marcar uma criatura com sua Marca do Caçador você recebe os seguintes benefícios enquanto estiver em sua perseguição:
• Sua velocidade de caminhada aumenta em 10 pés.
• Quando você acertar um ataque contra a criatura marcada a velocidade de movimento dela diminui em 5 pés.
• Você se torna imune a condição exausto.
• A margem de críticos contra a criatura marcada se torna 19-20.
Além disso, seus instintos estão tão afiados que você tem vantagem em testes de iniciativa e se você estiver surpreendido no início do combate e não estiver incapacitado, você pode agir normalmente em seu primeiro turno.', 7, 2);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Predador Primal'), 'Enfraquecer Presa', 'Começando no 11º nível, você aprende a expor e explorar as fraquezas de suas presas que estrangulam para tentar fugir de sua frenesi sanguinária. Sempre que você acertar uma criatura marcada com um acerto crítico a criatura também sofre 1 ponto de exaustão.', 11, 3);
INSERT INTO classe_subclasse_caracteristicas (subclasse_id, titulo, corpo, nivel, ordem) VALUES ((SELECT id FROM classe_subclasses WHERE classe_id = 'caçador' AND nome = 'Predador Primal'), 'Superioridade Tática', 'A partir do 15º nível, suas técnicas de cerco e de execução estão lapidadas garantindo sua superioridade a qualquer criatura que você deseja predar. Você possui vantagem em qualquer jogada de d20 contra a criatura marcada por sua Marca do Caçador. Além disso, sua margem de crítico contra a criatura marcada se torna 18-20.', 15, 4);

