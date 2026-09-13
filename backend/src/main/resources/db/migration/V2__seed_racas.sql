-- Seed real do compêndio de Raças.
-- O schema não modela sub-raças como uma hierarquia (racas é uma lista
-- plana) — por isso cada variante nomeada (ex.: "Aasimar Caído", "Elfo
-- Drow", "Warforged Colosso") vira sua própria linha em `racas`, com os
-- traços da raça-base já combinados aos da variante (inclusive o Aumento
-- no Valor de Habilidade somado num único total por atributo).

-- ===== AARAKOCRA =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'aarakocra', 'Aarakocra', 'tribal', 4.5, 'medio', NULL,
    'Comum e Auran',
    NULL,
    'Os aarakocras são uma raça aviária nobre e aérea, com a majestade das aves e a liberdade dos ventos. Com corpos esbeltos e plumagem exuberante, eles possuem asas que lhes permitem voar pelos céus com destreza. Vivendo nas alturas, em comunidades construídas em penhascos ou árvores altas, os aarakocras valorizam a liberdade, a honra e a cooperação. Conhecidos por sua agilidade e destreza, são habilidosos caçadores e guardiões dos céus, sempre prontos para defender suas terras dos perigos que ameaçam a harmonia do ar e do mundo natural.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'Voo', 'Você tem deslocamento de voo de 15 metros. Para usar esse deslocamento, você não pode estar vestindo armadura média ou pesada.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'Treinamento Aarakocra com Armas', 'Proficiência com arcos longos e arcos curtos.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'Olhos de Águia', 'Você possui proficiência na perícia de Percepção e adiciona o dobro do seu bônus de proficiência ao teste, em vez do seu bônus de proficiência normal. Você vê normalmente até 4 km de distância.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'Viajante', 'Quando estiver voando a grandes altitudes e sem carregar objetos acima do seu limite de peso, pode utilizar uma magia secreta aarakocra que permite que você alcance grande velocidade cobrindo grandes distâncias sem se cansar enquanto voa. Você pode cobrir 3000 km em um único dia.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'aarakocra'), 'Esquiva', 'Quando for alvejado por um ataque, e você não estiver impedido de se movimentar, você pode utilizar sua reação para levantar voo e se mover até 4,5 m em uma direção à sua escolha sem provocar ataques de oportunidade. Você recebe um bônus de +5 na sua CA contra esse ataque, potencialmente fazendo o ataque errar.', 'passiva', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aarakocra'), 1.5, 1.5, 1.5);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aarakocra'), 40, 45, 50);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'aarakocra'), 3, 30);


-- ===== AASIMAR (base compartilhada: Visão no Escuro Incomum, Resistência Celestial, Portador da Luz — Carisma +2) =====

-- Aasimar Caído
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'aasimar-caido', 'Aasimar Caído', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Celestial',
    NULL,
    'Os aasimares são descendentes de seres divinos, carregando em si uma herança celestial que se manifesta em sua aparência e poderes. Dotados de uma aura etérea e uma beleza transcendente, os aasimares são seres iluminados por sua linhagem divina. São frequentemente guiados por um senso de justiça e virtude, buscando fazer o bem e proteger os vulneráveis. Um Aasimar Caído carrega essa herança de forma sombria, manifestando um manto de energia necrótica em momentos de necessidade.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'Visão no Escuro Incomum', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'Resistência Celestial', 'Você tem resistência a dano Radiante e Trovejante. Mas tem vulnerabilidade a dano Necrótico.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'Portador da Luz', 'Você conhece o truque Luz. Carisma é a habilidade usada para conjurar este truque.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'Resistência do Caído', 'Você possui vantagem em testes para resistir a ser amedrontado.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 'Manto Necrótico', 'Começando no 3° nível, você pode usar sua ação bônus para liberar sua energia divina interior, fazendo com que seus olhos se tornem poços de trevas, e duas asas esqueléticas e fantasmagóricas brotam de suas costas. No instante em que você se transforma, outras criaturas num raio de 9 m que podem ver você precisam passar num teste de resistência de Carisma (CD 8 + seu bônus de proficiência + seu modificador de Carisma) ou ficar amedrontadas até o final de seu próximo turno. Sua transformação dura por 1 minuto ou até você terminá-la com uma ação bônus. Enquanto durar, uma vez por turno, você causa dano necrótico extra igual ao seu nível com um ataque ou magia, e você recebe um bônus em sua CA igual ao seu bônus de proficiência. Uma vez que você use esse traço, você não pode usá-lo novamente até terminar um descanso longo.', 'uso_unico', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-caido'), 18, 160);

-- Aasimar Arcanjo
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'aasimar-arcanjo', 'Aasimar Arcanjo', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Celestial',
    NULL,
    'Os aasimares são descendentes de seres divinos, carregando em si uma herança celestial que se manifesta em sua aparência e poderes. Dotados de uma aura etérea e uma beleza transcendente, são frequentemente guiados por um senso de justiça e virtude, buscando fazer o bem e proteger os vulneráveis. Um Aasimar Arcanjo manifesta essa herança como uma luz reconfortante, capaz de curar e proteger aqueles ao seu redor.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'Visão no Escuro Incomum', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'Resistência Celestial', 'Você tem resistência a dano Radiante e Trovejante. Mas tem vulnerabilidade a dano Necrótico.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'Portador da Luz', 'Você conhece o truque Luz. Carisma é a habilidade usada para conjurar este truque.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'Iluminado', 'Você conhece a magia Orientação.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 'Bênção Radiante', 'A partir do 3° nível, você pode usar sua ação para liberar sua energia divina interior, irradiando uma luz reconfortante que se derrama de seus olhos e boca, trazendo a imagem de proteção. Sua transformação dura por 1 minuto ou até você encerrá-la com uma ação bônus. Enquanto durar, você irradia luz intensa em um raio de 3 m e penumbra por 3 m adicionais, e no final de cada um dos seus turnos, você e cada criatura dentro de um raio de 3 metros recuperam pontos de vida iguais ao seu nível. Além disso, uma vez por turno, você causa dano extra radiante igual ao seu nível a um alvo quando causar dano a ele com um ataque ou magia. Após o uso, você não pode usá-lo novamente até terminar um descanso longo.', 'uso_unico', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-arcanjo'), 18, 160);

-- Aasimar Protetor
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'aasimar-protetor', 'Aasimar Protetor', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Celestial',
    NULL,
    'Os aasimares são descendentes de seres divinos, carregando em si uma herança celestial que se manifesta em sua aparência e poderes. Dotados de uma aura etérea e uma beleza transcendente, são frequentemente guiados por um senso de justiça e virtude, buscando fazer o bem e proteger os vulneráveis. Um Aasimar Protetor manifesta essa herança como asas angelicais e uma alma radiante, sempre pronto para guardar aqueles que precisam.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'Visão no Escuro Incomum', 'Você enxerga na penumbra a até 18 metros como se fosse luz plena, e no escuro como se fosse na penumbra. Você não pode discernir cores no escuro, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'Resistência Celestial', 'Você tem resistência a dano Radiante e Trovejante. Mas tem vulnerabilidade a dano Necrótico.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'Portador da Luz', 'Você conhece o truque Luz. Carisma é a habilidade usada para conjurar este truque.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'Asas de Anjo', 'Você recebe deslocamento de voo de 9 metros.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 'Alma Radiante', 'Começando no 3° nível, você pode usar uma ação para liberar sua energia divina interior, fazendo seus olhos reluzirem e duas asas incorpóreas e luminosas brotarem de suas costas. Sua transformação dura por 1 minuto ou até você finalizá-la com uma ação bônus. Enquanto durar, uma vez por turno, você pode causar dano extra radiante igual ao seu nível a um alvo que você atingir com um ataque ou magia. Após usar essa característica, você não pode usá-la novamente até completar um descanso longo.', 'uso_unico', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'aasimar-protetor'), 18, 160);


-- ===== ANÃO (base compartilhada: Constituição +2, Treinamento em Combate, Proficiência com Ferramentas, Resiliência Anã) =====

-- Anão de Obsídea
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'anao-obsidea', 'Anão de Obsídea', 'global', 7.5, 'medio', NULL,
    'Comum e Anão',
    NULL,
    'Os anões, conhecidos por sua resistência inigualável e habilidades de artesanato impecáveis, são um povo robusto e orgulhoso, que valoriza a tradição, a honra e a lealdade à família e ao clã. No coração das montanhas vulcânicas mais perigosas do mundo, os Anões de Obsídea erguem fortalezas que brilham com o calor do magma. Sua pele negra como carvão e seus olhos alaranjados lembram brasas vivas, um reflexo da forja eterna em que vivem. Famosos como os melhores ferreiros e armeiros que já caminharam sobre Calen, estes anões consideram o ato de forjar uma forma de oração, e cada arma criada é uma obra-prima carregada de orgulho e fúria.',
    NULL,
    'A vida no interior de um vulcão moldou-os tanto física quanto espiritualmente. O calor abrasador não os incomoda; pelo contrário, é sua fonte de energia e inspiração. Sua natureza esquentada, tanto no temperamento quanto na batalha, faz deles guerreiros temíveis, capazes de transformar a raiva em força ardente.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Treinamento Anão em Combate', 'Proficiência com machados de batalha, machadinhas, martelos leves e martelos de guerra.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Proficiência com Ferramentas', 'Proficiência em uma ferramenta de artesão à escolha: ferramentas de ferreiro, suprimentos de cervejeiro ou ferramentas de pedreiro.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Especialização em Rochas', 'Você recebe proficiência em testes de Inteligência (História). Você utiliza o dobro do seu bônus de proficiência para testes relacionados a trabalho com pedra.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Resiliência Anã', 'Você possui vantagem em testes de resistência contra venenos e dano de veneno.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Resistência Vulcânica', 'Você tem resistência a dano de fogo.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Teimosia de Pedra', 'Você é notoriamente difícil de matar. Você só morre após falhar em 4 testes de resistência contra a morte, em vez do padrão de 3.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 'Forjador-Mestre', 'Você tem proficiência com ferramentas de ferreiro. Quando usa essas ferramentas para criar ou reparar uma arma ou armadura de metal, o tempo necessário é reduzido à metade. Além disso, armas ou armaduras de metal criadas por você recebem um bônus nas jogadas de ataque ou CA igual à metade do seu bônus de proficiência (arredondado para baixo). Você só pode aplicar este bônus a um número limitado de itens — no 1º nível, 1 item; no 2º nível, 3 itens; no 3º nível, 6 itens, e assim por diante. Novos itens podem ser criados com esse bônus à medida que você sobe de nível, respeitando o limite.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 1.20, 1.35, 1.50);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 175, 175, 175);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'anao-obsidea'), 50, 350);

-- Anão Rochoso
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'anao-rochoso', 'Anão Rochoso', 'global', 7.5, 'medio', NULL,
    'Comum e Anão',
    NULL,
    'Os anões, conhecidos por sua resistência inigualável e habilidades de artesanato impecáveis, são um povo robusto e orgulhoso, que valoriza a tradição, a honra e a lealdade à família e ao clã. Os Anões Rochosos levam essa resiliência ao extremo: sua pele parece esculpida na própria montanha, e seu corpo carrega o peso e a firmeza da pedra ancestral.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'constituicao', 3, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Treinamento Anão em Combate', 'Proficiência com machados de batalha, machadinhas, martelos leves e martelos de guerra.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Proficiência com Ferramentas', 'Proficiência em uma ferramenta de artesão à escolha: ferramentas de ferreiro, suprimentos de cervejeiro ou ferramentas de pedreiro.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Resiliência Anã', 'Você possui vantagem em testes de resistência contra venenos e dano de veneno.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Visão Sísmica', 'Você possui visão sísmica de até 9 metros.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Corpo de Colosso', 'Seu máximo de pontos de vida aumenta em 1. A cada novo nível, você recebe uma quantidade de vida adicional igual à metade do seu bônus de proficiência arredondado para baixo (mínimo 1).', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Bastião Ancestral', '+1 de CA enquanto estiver usando armadura.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Proteção Rúnica', 'Você tem vantagem em testes de resistência contra magias de nível igual ou inferior ao seu modificador de Carisma; no entanto, você tem desvantagem em jogadas de ataque ao conjurar uma magia de nível superior ao seu modificador de Carisma.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 'Especialização em Artesanato', 'Você possui especialização na sua perícia com ferramenta recebida a partir da característica de raça Proficiência com Ferramentas.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 1.20, 1.35, 1.50);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 175, 175, 175);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'anao-rochoso'), 50, 350);

-- Anão Barbas de Cobre
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'anao-barbas-de-cobre', 'Anão Barbas de Cobre', 'global', 9, 'medio', NULL,
    'Comum e Anão',
    NULL,
    'Os anões, conhecidos por sua resistência inigualável e habilidades de artesanato impecáveis, são um povo robusto e orgulhoso, que valoriza a tradição, a honra e a lealdade à família e ao clã. Os Anões Barbas de Cobre carregam uma centelha elétrica no próprio sangue, e suas barbas metálicas crepitam sutilmente quando estão agitados ou em combate.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Treinamento Anão em Combate', 'Proficiência com machados de batalha, machadinhas, martelos leves e martelos de guerra.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Proficiência com Ferramentas', 'Proficiência em uma ferramenta de artesão à escolha: ferramentas de ferreiro, suprimentos de cervejeiro ou ferramentas de pedreiro.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Resiliência Anã', 'Você possui vantagem em testes de resistência contra venenos e dano de veneno.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Resistência Elétrica', 'Você tem resistência a dano elétrico.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Energético por Natureza', 'Você tem vantagem em testes para resistir à condição de Exaustão. Sempre que você passar por um descanso curto ou longo, você recupera um nível de Exaustão adicional.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Corpo Eletromagnético', 'Você tem vantagem em suas jogadas de ataque corpo-a-corpo contra criaturas que sejam feitas de metal ou estejam usando armaduras de metal. Além disso, você tem vantagem em testes de Força em qualquer interação com metal.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 'Velocidade Energizada', 'Seu deslocamento base de caminhada é de 9 metros.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 1.20, 1.35, 1.50);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 175, 175, 175);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'anao-barbas-de-cobre'), 50, 350);


-- ===== BAGAJIIN =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'bagajiin', 'Bagajiin', 'mistica', 9, 'medio', NULL,
    'Comum e um idioma adicional à escolha',
    NULL,
    'Os Bagajiins são criaturas alegres por natureza, profundamente conectadas à música, o que lhes concede habilidades especiais. Seu corpo é formado a partir de um instrumento musical, e o tamanho de cada Bagajiin varia conforme o instrumento ao qual estão ligados.',
    NULL,
    'Naturalmente alegres e inclinados à música, os Bagajiins tendem à bondade e à neutralidade, detestando ser tratados como objetos.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'Forma Imutável', 'Você tem vantagem em testes de resistência contra efeitos que alterem sua forma.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'Natureza Musical', 'Você é proficiente em um tipo de instrumento que constitui a base do seu corpo. Em testes de Atuação com esse instrumento, você possui vantagem.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'Conjuração Inata', 'Você conhece o truque Taumaturgia. No 3º nível, pode lançar Sussurros Dissonantes como feitiço de 2º nível uma vez por descanso longo. No 5º nível, pode lançar Acalmar Emoções uma vez por descanso longo. Carisma é sua habilidade de conjuração e não requer componentes.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'Pele de Madeira', 'Sua pele de madeira lhe dá vulnerabilidade a dano de fogo, mas sua CA é 12 + seu modificador de Destreza, caso não esteja usando armadura.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'bagajiin'), 'Corpo Vivido', 'Quando for alvo de magias ou efeitos mágicos de cura, adicione seu modificador de Carisma à rolagem de cura.', 'passiva', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'bagajiin'), 1.20, 1.65, 2.10);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'bagajiin'), 40, 95, 150);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'bagajiin'), 1, 30);


-- ===== DRACODILE =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'dracodile', 'Dracodile', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Dracônico',
    NULL,
    'Descendentes de Dracos e outros membros da família Dracônica, os Dracodiles são predadores insaciáveis e ambiciosos. Predadores naturais, normalmente não possuem empatia; a maioria das criaturas é vista apenas como comida.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'forca', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'Segurar Fôlego', 'Você pode ficar sem respirar por até 15 minutos de cada vez.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'Conhecimento de Caçador', 'Você ganha proficiência em duas perícias escolhidas da seguinte lista: Adestrar Animais, Natureza, Percepção, Furtividade e Sobrevivência.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'Armadura Natural', 'Você possui uma pele dura e escamosa. Quando você não estiver usando armadura, sua CA será 13 + modificador de Constituição. Você pode usar sua armadura natural para determinar sua CA se a armadura que você estiver usando deixar você com uma CA menor. O bônus de escudo se aplica normalmente quando você usar sua armadura natural.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'Devorador Compulsivo', 'Dracodiles possuem uma vontade compulsória de comer criaturas, sejam elas quais forem, e frequentemente comem suas presas ainda vivas. Quando uma criatura estiver caída ou tiver morrido nos últimos 1 minuto, você pode com uma ação devorar a criatura, desde que ela seja até uma categoria de tamanho menor que você, e recuperar uma quantidade de pontos de vida igual ao nível de desafio da criatura + o seu nível de personagem.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'dracodile'), 'Mandíbulas Famintas', 'Com uma ação bônus, você pode realizar um único ataque especial com sua mordida, causando 1d6 + seu modificador de Força de dano de perfuração, podendo agarrar o alvo. O dano aumenta para 2d6 no 6° nível, 4d6 no 11° nível e 6d6 no 16° nível, e você ganha pontos de vida temporários igual ao seu nível. Se esse ataque levar uma criatura a 0 pontos de vida, você pode automaticamente utilizar sua habilidade Devorador Compulsivo. Você pode utilizar essa habilidade uma quantidade de vezes igual ao seu bônus de proficiência. Você recupera todos os usos dessa habilidade após um descanso longo.', 'multiplos_usos', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'dracodile'), 2.20, 2.20, 2.20);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'dracodile'), 335, 335, 335);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'dracodile'), 10, 60);


-- ===== DRACONATO =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'draconato', 'Draconato', 'sobrenatural', 9, 'medio', NULL,
    'Falam, leem e escrevem Comum e Dracônico. O Dracônico é uma das línguas mais antigas e é usado no estudo da magia.',
    NULL,
    'Os draconatos, descendentes diretos dos dragões, são criaturas imponentes e carregam consigo as marcas distintas de suas origens místicas. Cada draconato possui uma escama de cor única, refletindo a linhagem do dragão que os originou. Sua personalidade muitas vezes reflete a natureza desses dragões ancestrais, abraçando traços como coragem, sabedoria, orgulho ou até mesmo ferocidade.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'draconato'), 'forca', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'draconato'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'draconato'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'draconato'), 'Arma de Sopro', 'Você pode usar uma ação para exalar energia destrutiva. Seu ancestral dracônico determina o tamanho, formato e tipo de dano que você expele: Azul, Bronze e Cobre (Elétrico ou Ácido, linha de 1,5 m de largura e 9 m de comprimento, teste de Destreza); Branco, Prata e Verde (Frio, Frio ou Veneno, cone de 4,5 m, teste de Constituição); Latão, Negro, Ouro e Vermelho (Fogo ou Ácido, linha ou cone conforme a cor). Cada criatura na área exalada deve realizar o teste de resistência indicado, com CD igual a 8 + seu modificador de Constituição ou Carisma + seu bônus de proficiência. Uma criatura sofre 3d6 de dano em um fracasso e metade desse dano num sucesso. O dano aumenta para 7d6 no 6° nível, 12d6 no 11° nível, 18d6 no 16° nível e 25d6 no 20° nível. Você pode utilizar essa habilidade um número de vezes igual ao seu bônus de proficiência e recupera todos os usos após completar um descanso curto ou longo.', 'multiplos_usos', 1),
    ((SELECT id FROM racas WHERE slug = 'draconato'), 'Resistência a Dano', 'Você possui resistência ao tipo de dano associado ao seu ancestral dracônico.', 'passiva', 2);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'draconato'), 1.90, 1.90, 1.90);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'draconato'), 125, 125, 125);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'draconato'), 15, 80);


-- ===== OZZUS =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'ozzus', 'Ozzus', 'mistica', 9, 'medio', NULL,
    'Comum',
    NULL,
    'Os Ozzus são humanoides extraordinários, uma raça de slimes humanoides adaptáveis, sorrateiros e com corpos amorfos capazes de se esticar e resistir aos danos físicos do mundo. Com uma pele lisa e reluzente, de cores que variam entre tons metálicos de prateado, dourado ou cobre, seus corpos possuem uma estrutura similar a polímeros orgânicos, tornando-os incrivelmente elásticos e resistentes. Nasceram a partir de metamorfoses e acidentes mágicos envolvendo slimes muito antigos.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'constituicao', 2, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Adesivo', 'Sendo uma criatura de limo gelatinoso, você é naturalmente pegajoso. Você tem vantagem em testes de Força (Atletismo) feitos para agarrar um alvo. Além disso, você pode escalar superfícies difíceis, inclusive de cabeça para baixo em tetos, sem precisar fazer um teste de habilidade.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Corpo Gosmento', 'Você pode estender seus membros ou corpo até 3 vezes sua altura natural. Essa habilidade permite que você alcance objetos ou acerte alvos que estejam até 4,5 metros de distância sem se mover. Além disso, você tem vantagem em testes de resistência contra a condição de Impedido, e é imune à condição de Agarrado.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Deslizar Escorregadio', 'Você pode comprimir seu corpo para passar por espaços tão pequenos quanto 15 cm de largura, contanto que não esteja usando armadura média ou pesada.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Forma Adaptável', 'Como uma ação bônus, você pode moldar partes do seu corpo para criar ferramentas simples (como cordas, ganchos ou chaves de fechadura improvisadas). Essas ferramentas duram enquanto você as mantiver formadas.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Resistência à Queda', 'Devido à elasticidade de seu corpo, você reduz qualquer dano por queda pela metade, desde que esteja consciente.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'ozzus'), 'Rebote Flexível', 'Quando você for atingido por um ataque corpo-a-corpo, você pode usar sua reação para absorver parte do impacto e lançar seu corpo para trás. Você reduz o dano recebido em 1d6 + seu modificador de Constituição e pode se mover até 3 metros sem provocar ataques de oportunidade.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'ozzus'), 1.8, 1.8, 1.8);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'ozzus'), 60, 60, 60);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'ozzus'), 18, 1000);


-- ===== ELFO (base compartilhada: Destreza +2, Sentidos Aguçados, Ancestral Feérico, Transe) =====

-- Elfo Altivo
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'elfo-altivo', 'Elfo Altivo', 'global', 9, 'medio', NULL,
    'Comum e Élfico',
    NULL,
    'Os elfos, seres de graça inigualável e longevidade invejável, são intrinsecamente ligados à natureza e conhecidos por sua habilidade em artes mágicas. Os elfos altivos são herdeiros de tradições arcanas milenares, eruditos que veem a magia como extensão natural de sua mente disciplinada. Orgulhosos, cultivam a diplomacia como arma tão afiada quanto a lâmina, mantendo sempre a postura elegante, mesmo diante da adversidade.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'inteligencia', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Sentidos Aguçados', 'Proficiência na perícia Percepção.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Ancestral Feérico', 'Vantagem nos testes de resistência para resistir a ser enfeitiçado e imunidade a magias que induzem sono.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Transe', 'Não precisam dormir; meditam profundamente durante 4 horas por dia. Após esse descanso, obtêm os mesmos benefícios que um humano após 8 horas de sono.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Treinamento Élfico com Armas', 'Proficiência com espadas longas, espadas curtas, arcos longos e arcos curtos.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Magia Altiva', 'Você aprende dois truques da lista de magias de Mago à sua escolha. Ao alcançar o 3º nível, escolha uma magia de 1º nível da lista de magias de Mago; ao alcançar o 5º nível, escolha uma magia de 2º nível da lista de magias de Mago. Você pode conjurar cada magia de nível 1 ou superior uma vez por descanso longo sem gastar espaços de magia.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Mente Diplomática', 'Você possui vantagem no primeiro teste de Carisma que fizer ao interagir com uma criatura. Após o primeiro teste, essa criatura só é afetada novamente após 24 horas.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 'Idioma Adicional', 'Capacidade de falar, ler e escrever em um idioma adicional de escolha própria.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-altivo'), 100, 750);

-- Elfo Floral
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'elfo-floral', 'Elfo Floral', 'global', 12, 'medio', NULL,
    'Comum e Élfico',
    NULL,
    'Os elfos, seres de graça inigualável e longevidade invejável, são intrinsecamente ligados à natureza. Vivendo entre ramos e raízes, os elfos florais respiram o pulso da natureza. Sua ligação com a vida selvagem os torna ágeis como o vento e perigosos como um felino caçador. Unidos por laços de comunidade, combatem em perfeita harmonia com seus aliados, aproveitando cada brecha deixada pelo inimigo.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Sentidos Aguçados', 'Proficiência na perícia Percepção.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Ancestral Feérico', 'Vantagem nos testes de resistência para resistir a ser enfeitiçado e imunidade a magias que induzem sono.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Transe', 'Não precisam dormir; meditam profundamente durante 4 horas por dia. Após esse descanso, obtêm os mesmos benefícios que um humano após 8 horas de sono.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Treinamento Élfico com Armas', 'Proficiência com espadas longas, espadas curtas, arcos longos e arcos curtos.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Pés Ligeiros', 'Seu deslocamento base de caminhada aumenta para 12 metros.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Ataque de Primavera', 'Ao realizar um ataque corpo a corpo contra uma criatura, você não provoca ataques de oportunidade daquela criatura pelo resto do seu turno, independentemente de acertar ou não.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Instinto de Matilha', 'Quando você realizar um ataque contra uma criatura, você recebe +1 na jogada de ataque para cada aliado que esteja a até 3 metros do seu alvo, até um máximo igual ao seu bônus de proficiência. Um aliado inconsciente ou incapacitado não conta para este bônus.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 'Máscara da Natureza', 'Você recebe +5 de bônus em seus testes de furtividade quando possui leve obscuridade por folhagem, chuva, neve, névoa ou outros fenômenos naturais.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-floral'), 100, 750);

-- Elfo Drow
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'elfo-drow', 'Elfo Drow', 'global', 9, 'medio', NULL,
    'Comum e Élfico',
    NULL,
    'Os elfos, seres de graça inigualável e longevidade invejável, são intrinsecamente ligados à natureza. Forjados nas profundezas do Subterrâneo, os drow caminham na tênue linha entre luz e trevas. Adaptados à escuridão, movem-se como sombras vivas, mesclando astúcia e letalidade. Sua existência é marcada pela desconfiança e pelo instinto de sobrevivência, e poucos conseguem decifrar se um drow está prestes a oferecer a mão… ou a lâmina.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Ancestral Feérico', 'Vantagem nos testes de resistência para resistir a ser enfeitiçado e imunidade a magias que induzem sono.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Transe', 'Não precisam dormir; meditam profundamente durante 4 horas por dia. Após esse descanso, obtêm os mesmos benefícios que um humano após 8 horas de sono.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Treinamento Drow com Armas', 'Proficiência com rapieiras, espadas curtas e bestas de mão.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Resistência Necrótica', 'Possuem resistência a danos necróticos.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Fraqueza ao Divino', 'Você tem vulnerabilidade a dano Radiante.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Teleporte Sombrio', 'Se você não estiver diretamente sobre uma fonte de luz, você pode com uma ação bônus teleportar para um ponto que você possa ver que esteja pelo menos levemente obscurecido, até 9 metros. Você recebe resistência a todos os danos após usar essa habilidade até o início do seu próximo turno. Você recupera o uso dessa habilidade após um descanso longo.', 'uso_unico', 6),
    ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 'Lâmina do Pacto Sombrio', 'Ao final de um descanso curto, você pode gastar 1 ponto de vida para banhar uma arma cortante ou perfurante no seu sangue, canalizando a energia sombria de sua herança drow. Essa energia permanece na arma até que você acerte um ataque ou até realizar outro descanso curto ou longo. O primeiro ataque que acertar com essa arma causa dano adicional necrótico igual a 1/10 dos pontos de vida máximos da criatura (arredondado para baixo), ignorando resistências. Além disso, até o início do seu próximo turno, a criatura não pode recuperar pontos de vida por qualquer meio. Você só pode ter uma arma sob o efeito da Lâmina do Pacto Sombrio por vez.', 'uso_unico', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'elfo-drow'), 100, 750);


-- ===== KOR =====
-- Nota: o material de origem apresenta o Kor logo após o Elfo Drow, como se fosse a "quarta sub-raça de
-- elfos" prometida no texto ("Existem quatro sub-raças de Elfos"), mas só três (Altivo/Floral/Drow) têm
-- de fato os traços élficos compartilhados. O Kor não tem nenhum traço élfico (idioma, treinamento com
-- armas, ancestralidade feérica) e sua ambientação (escaladores/acrobatas de penhasco) não tem relação
-- com os elfos — por isso foi cadastrado aqui como raça independente, não como "Elfo Kor".
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'kor', 'Kor', 'tribal', 9, 'medio', NULL,
    'Libras',
    NULL,
    'Nascidos entre penhascos suspensos e ilhas flutuantes, os Kor veem o céu como estrada e as cordas como extensão de seus próprios braços. Movendo-se com a graça de acrobatas e a precisão de caçadores, eles saltam entre abismos como quem atravessa uma rua. Sua fé e cultura estão entrelaçadas a essas linhas de vida, usando-as tanto para viajar quanto para subjugar presas e inimigos. Para um Kor, cada salto é um ato de coragem, e cada corda é um laço com o destino.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'kor'), 'sabedoria', 1, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'kor'), 'Escalada Kor', 'Você adquire proficiência nas perícias Atletismo e Acrobacia.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'kor'), 'Sorte Sobre o Destino', 'Quando você rolar um 1 no d20 em um ataque, teste de habilidade ou de resistência, você pode rolar o dado novamente e precisa usar o novo resultado.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'kor'), 'Bravura', 'Você tem vantagem em testes para resistir a ser amedrontado.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'kor'), 'Mestres do Chicote', 'Graças à cultura dos Kor, os chicotes são uma parte sagrada de sua cultura. Eles ganham proficiência com o uso do chicote, e o dado de dano de um chicote para um Kor é igual a 1d8. Além disso, enquanto estiverem com seu chicote em mãos, os Kor podem realizar grandes saltos e sobreviver a quedas perigosas: seu salto se torna 3 vezes maior, e com uma reação você pode realizar um teste de Acrobacia negando o dano de queda em um valor igual ao resultado do teste.', 'passiva', 3);


-- ===== FERAL (base compartilhada: Destreza +1, deslocamento 9m, Visão no Escuro, idiomas Comum e Silvestre — cada
-- sub-raça abaixo representa um "totem animal" diferente, escolhido no lugar da forma genérica de Feral) =====

-- Feral Loxodonte
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-loxodonte', 'Feral Loxodonte', 'tribal', 9, 'grande', NULL,
    'Comum e Silvestre',
    NULL,
    'Ferais são seres selvagens, muitas vezes criaturas humanoides que viveram e cresceram em ambientes selvagens, distantes do contato e influência da civilização, desenvolvendo características físicas que refletem a fauna local. Os Loxodontes carregam a compleição maciça e a sabedoria paciente dos elefantes, valorizando o peso da experiência acima de tudo.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'Compleição Poderosa', 'Você é considerado de uma categoria de tamanho maior para determinar sua capacidade de carga, o peso que você pode empurrar, arrastar ou erguer e criaturas que você pode agarrar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'Bravura Loxodonte', 'Você possui vantagem em testes de resistência contra a condição amedrontado.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'Corpo de Colosso', 'Seu máximo de pontos de vida aumenta em 1. A cada novo nível, recebe uma quantidade de vida adicional igual à metade do seu bônus de proficiência arredondado para baixo (mínimo 1).', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 'Olfato Aguçado', 'Graças a sua tromba sensível, você tem vantagem nos testes de Sabedoria (Percepção) e Inteligência (Investigação) que dependem do olfato.', 'passiva', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 2.80, 3.10, 3.40);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 336, 409, 482);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-loxodonte'), 60, 450);

-- Feral Taurus
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-taurus', 'Feral Taurus', 'tribal', 9, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Ferais são seres selvagens, muitas vezes criaturas humanoides que viveram e cresceram em ambientes selvagens, distantes do contato e influência da civilização, desenvolvendo características físicas que refletem a fauna local. Os Taurus carregam a força bruta e a teimosia dos touros, avançando com passos pesados que fazem o chão tremer.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Chifres', 'Você nunca está desarmado. Você é proficiente com seus chifres, uma arma corpo-a-corpo que causa 1d10 de dano perfurante. Seus chifres garantem a você vantagem em todos os testes feitos para empurrar uma criatura, mas não para evitar ser empurrado.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Passos Pesados', 'Sempre que você se move mais de 3 metros em linha reta, criaturas de tamanho Médio ou menor ao seu redor (em um raio de 1,5 metro) devem ser bem-sucedidas em um teste de resistência de Destreza (CD 8 + seu bônus de proficiência + seu modificador de Força) ou serão derrubadas.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Arremete com Chifres', 'Quando você usa a ação Correr durante o seu turno, você pode fazer um ataque corpo-a-corpo com seus chifres como uma ação bônus.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Pancada com Chifres', 'Quando você usa a ação Atacar durante o seu turno para fazer um ataque corpo-a-corpo, você pode tentar dar um encontrão na criatura com seus chifres como uma ação bônus. Você não pode usar essa tentativa de encontrão para derrubar a criatura.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 'Recordação Labiríntica', 'Você pode se lembrar perfeitamente de qualquer caminho por onde tenha viajado.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 2.10, 2.10, 2.10);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 235, 235, 235);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-taurus'), 17, 150);

-- Feral Felitinos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-felitinos', 'Feral Felitinos', 'tribal', 13.5, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Ferais são seres selvagens, muitas vezes criaturas humanoides que viveram e cresceram em ambientes selvagens, distantes do contato e influência da civilização, desenvolvendo características físicas que refletem a fauna local. Os Felitinos herdam a velocidade explosiva e as garras afiadas dos grandes felinos, além de sentidos aguçados que raramente são pegos de surpresa.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'destreza', 2, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'Velocidade Superior', 'Você possui um bônus em sua velocidade de movimento de +4,5 metros (já incluído no deslocamento base acima).', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'Agilidade Felina', 'Seus reflexos e agilidade permitem que você se mova com uma explosão de velocidade. Quando você se move no seu turno de combate, você pode dobrar seu deslocamento até o fim do turno. Uma vez que tenha usado esse traço racial, você não pode usá-lo novamente até que fique parado durante um de seus turnos.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'Garras de Gato', 'Devido a suas garras, você tem um deslocamento de escalada de 6 metros. Suas garras são consideradas armas naturais, que você pode usar para realizar ataques desarmados. Em caso de acerto, você causa dano cortante igual a 1d4 + modificador de Força, no lugar do dano de contusão para ataques desarmados.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 'Habilidades Felinas', 'Você tem proficiência nas perícias de Percepção e Furtividade.', 'passiva', 4);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-felitinos'), 18, 90);

-- Feral Sarubinos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-sarubinos', 'Feral Sarubinos', 'tribal', 9, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Ferais são seres selvagens, muitas vezes criaturas humanoides que viveram e cresceram em ambientes selvagens, distantes do contato e influência da civilização, desenvolvendo características físicas que refletem a fauna local. O amor dos Sarubinos por aventuras e suas personalidades enérgicas frequentemente os tornam mais caóticos — herdam de primatas a agilidade, a cauda preênsil e um apetite incansável.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Escaladores Ágeis', 'Sua agilidade natural concede a você um deslocamento de escalada igual ao seu deslocamento de caminhada. Você também pode escalar tetos, desde que tenha algo em que se segurar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Estômago Vazio', 'Você consome energia rapidamente, precisando do dobro de comida que uma criatura de seu tamanho normalmente requer.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Sono Pesado', 'Durante um descanso longo, qualquer um tentando acordá-lo deve fazer um teste de Carisma CD 15. Receber dano ou ser molhado com água desperta você automaticamente.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Quebra de Limites', 'Como uma reação, quando você falhar em um teste de habilidade ou salvaguarda de Força, Destreza ou Constituição, você pode refazer o teste e usar o novo resultado. Depois de usar essa habilidade, você precisa concluir um descanso longo antes de usá-la novamente.', 'uso_unico', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Energia Primata', 'Você tem proficiência em Acrobacia ou Atletismo. Você pode usar seus pés e cauda como se fossem mãos. Se usar ambos os pés simultaneamente para interagir com um objeto, seu deslocamento se torna 0.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 'Cauda', 'Sua cauda é extremamente flexível e conta como onerada quando usada. Você pode usá-la para acionar um objeto ou usar uma ferramenta (com desvantagem no teste), agarrar uma criatura de tamanho igual ou menor que o seu, ou cumprir componentes somáticos de feitiços. Desde que você não tenha usado sua cauda no seu turno, você recebe um bônus na sua CA igual ao seu bônus de proficiência.', 'passiva', 6);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-sarubinos'), 12, 150);

-- Feral Ursanores
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-ursanores', 'Feral Ursanores', 'tribal', 9, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Ursanores são humanoides robustos e intimamente conectados aos ursos, apresentando corpos fortes e resistentes. Eles vivem em harmonia com florestas e montanhas, muitas vezes formando pequenas tribos que se baseiam em hierarquias familiares. Sua presença impõe respeito, tanto pela força física quanto pela sabedoria que transmitem.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Garras Afiadas', 'Você possui garras que são armas naturais. Em ataques desarmados, você causa 1d6 de dano cortante, em vez do dano de contusão padrão.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Resiliência Natural', 'Você tem resistência a frio e vantagem em testes de resistência contra exaustão causada por ambientes gelados.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Fúria do Predador', 'Quando você atinge um inimigo com um ataque corpo a corpo, você pode optar por ativar sua Fúria do Predador. Até o final do seu próximo turno, você causa dano adicional igual ao seu bônus de proficiência em ataques corpo a corpo. Você pode usar essa habilidade um número de vezes igual ao seu modificador de Constituição (mínimo 1). Você recupera todos os usos após um descanso longo.', 'multiplos_usos', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Resistência de Ursino', 'Você tem vantagem em testes de resistência contra ser envenenado e resistência a dano de veneno.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Pancada Poderosa', 'Seus ataques desarmados são feitos com suas garras poderosas. Eles causam 1d8 + seu modificador de Força em dano cortante em vez do dano normal de ataques desarmados.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Hibernar', 'Quando você faz um descanso longo, recupera o dobro de pontos de vida do que normalmente recuperaria. Além disso, você pode passar até 24 horas em um estado de sono profundo para eliminar os níveis de exaustão acumulados.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Faro Apurado', 'Você tem vantagem em testes de Sabedoria (Percepção) relacionados ao olfato e audição.', 'passiva', 7),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Caminhante de Florestas', 'Você ignora terrenos difíceis causados por ambientes naturais, como neve, lama ou vegetação densa.', 'passiva', 8),
    ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 'Instinto de Sobrevivência', 'Você tem proficiência na perícia Sobrevivência.', 'passiva', 9);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 2.10, 2.30, 2.50);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 150, 200, 250);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-ursanores'), 20, 120);

-- Feral Luterinos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-luterinos', 'Feral Luterinos', 'tribal', 9, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Os Luterinos são humanoides ágeis e sociais, ligados aos lobos e cães. Eles vivem em comunidades cooperativas e são conhecidos por sua lealdade e capacidade de trabalho em equipe. Seus sentidos aguçados os tornam excelentes caçadores e exploradores.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Faro Apurado', 'Você tem vantagem em testes de Sabedoria (Percepção) e Inteligência (Investigação) que dependem do olfato.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Instinto de Matilha', 'Quando um aliado a até 1,5 m de você faz um ataque corpo a corpo contra uma criatura, você pode usar sua reação para realizar um ataque corpo a corpo contra a mesma criatura.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Lealdade Canina', 'Você tem vantagem em testes de resistência contra ser amedrontado ou encantado enquanto tiver um aliado a até 1,5 m de você.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Rastreador Natural', 'Você tem proficiência na perícia Sobrevivência. Além disso, você pode rastrear uma criatura específica pelo cheiro, desde que ela esteja a até 90 metros de você.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Uivo Inspirador', 'Como uma ação, você pode soltar um uivo que inspira coragem em seus aliados. Todas as criaturas aliadas a até 9 m de você que possam ouvi-lo ganham pontos temporários de vida iguais ao seu nível + seu modificador de Sabedoria. Você pode usar essa habilidade uma vez por descanso curto ou longo.', 'uso_unico', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Presa Selvagem', 'Seus ataques desarmados são feitos com suas mandíbulas, causando 1d6 + seu modificador de Força em dano perfurante, em vez do dano normal de ataques desarmados.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Saltos Ágeis', 'Sua força nas pernas lhe permite dobrar a distância de seus saltos com corrida.', 'passiva', 7),
    ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 'Comunicação Instintiva', 'Você pode se comunicar de forma limitada com cães, lobos e outras criaturas caninas. Essa comunicação não é verbal, mas permite transmitir intenções simples.', 'passiva', 8);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-luterinos'), 15, 90);

-- Feral Roedores
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-roedores', 'Feral Roedores', 'tribal', 9, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Roedores são humanoides curiosos e resilientes, com características que lembram animais como ratos e capivaras. Adaptados a ambientes diversos, eles são saltadores ágeis e têm uma conexão forte com suas famílias ou grupos.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'destreza', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Salto Poderoso', 'Você pode pular três vezes sua distância normal de salto em altura e distância, independentemente do seu deslocamento antes de saltar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Estabilidade em Combate', 'Você tem vantagem em testes e salvaguardas para evitar ser derrubado ou empurrado.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Investida Saltadora', 'Quando você usar a ação Correr em um turno e realizar um ataque corpo a corpo no mesmo turno, você pode causar dano adicional igual ao seu bônus de proficiência.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Pulmões Resilientes', 'Você tem vantagem em testes de resistência contra efeitos de sufocação ou gases nocivos.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Resistência Natural', 'Sempre que você recuperar pontos de vida durante um descanso curto, você pode rolar 1d6 adicional e adicionar o resultado aos pontos de vida recuperados.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Aderência Ágil', 'Você possui vantagem em testes de Força ou Destreza para resistir a quedas ou se agarrar em superfícies.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 'Instinto de Proteção', 'Quando um aliado a até 6 metros de você for alvo de um ataque, você pode usar sua reação para se mover até 4,5 metros em sua direção.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 1.40, 1.55, 1.70);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-roedores'), 12, 80);

-- Feral Cervídeos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-cervideos', 'Feral Cervídeos', 'tribal', 12, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Os Cervídeos são humanoides elegantes e graciosos, com chifres e pernas fortes que lembram veados e alces. Eles preferem viver em florestas densas e possuem um forte senso de comunidade e proteção.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'destreza', 2, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Velocidade de Fuga', 'Seu deslocamento base de caminhada é de 12 metros.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Graça Natural', 'Você tem vantagem em testes de Destreza (Acrobacia) e é capaz de se mover em terrenos difíceis sem gastar deslocamento adicional.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Chifres Naturais', 'Você nunca está desarmado. Seus chifres são armas naturais que causam 1d8 de dano perfurante e podem ser usados em ataques corpo a corpo.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Reflexos Aguçados', 'Você tem vantagem em testes de resistência contra armadilhas ou magias que exigem salvaguardas de Destreza.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Fuga Instintiva', 'Como uma reação, quando for atingido por um ataque corpo a corpo, você pode mover-se até metade do seu deslocamento sem provocar ataques de oportunidade. Você pode usar esta habilidade uma vez por descanso curto ou longo.', 'uso_unico', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Percepção Aguçada', 'Você é proficiente na perícia de Percepção.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 'Presença Tranquilizadora', 'Como uma ação, você pode forçar todas as criaturas hostis a até 6 metros de você a fazerem uma salvaguarda de Sabedoria (CD = 8 + seu bônus de proficiência + seu modificador de Sabedoria) ou ficarem encantadas por 1 minuto. Essa habilidade pode ser usada uma vez por descanso longo.', 'uso_unico', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 1.70, 1.90, 2.10);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-cervideos'), 18, 100);

-- Feral Mustelídeos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'feral-mustelideos', 'Feral Mustelídeos', 'tribal', 9, 'pequeno', NULL,
    'Comum e Silvestre',
    NULL,
    'Os Mustelídeos são humanoides ágeis e pequenos, inspirados por animais como lontras, furões e texugos. Eles são conhecidos por sua inteligência e habilidades de escavação, além de sua destreza em ambientes aquáticos e subterrâneos.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'destreza', 2, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Furtividade Natural', 'Você tem vantagem em testes de Destreza (Furtividade) e pode tentar se esconder mesmo quando levemente obscurecido por objetos ou ambientes.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Flexibilidade Sobrenatural', 'Você pode se espremer por espaços tão pequenos quanto 30 centímetros sem reduzir seu deslocamento ou sofrer penalidades.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Mordida Venenosa', 'Você possui uma mordida que causa 1d6 de dano perfurante. Quando você acerta com sua mordida, pode forçar a criatura atingida a fazer uma salvaguarda de Constituição (CD = 8 + seu bônus de proficiência + seu modificador de Constituição). Em caso de falha, ela sofre 1d4 de dano venenoso adicional e tem desvantagem em seu próximo ataque.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Instinto Predador', 'Você tem vantagem em ataques contra criaturas menores ou iguais ao seu tamanho que estejam com menos da metade de seus pontos de vida.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Adaptação Incansável', 'Você possui resistência a frio extremo e pode segurar a respiração por até 10 minutos.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 'Investida Ágil', 'Uma vez por turno, quando você fizer um ataque corpo a corpo, pode usar sua ação bônus para mover-se até 3 metros sem provocar ataques de oportunidade.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 1.20, 1.35, 1.50);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'feral-mustelideos'), 10, 60);


-- ===== FIRBOLG =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'firbolg', 'Firbolg', 'mistica', 9, 'medio', NULL,
    'Comum, Élfico, Silvestre e Gigante',
    NULL,
    'Os Firbolgs são uma raça gigante de seres humanoides, conhecida por sua estatura imponente e uma conexão profunda com a natureza. Geralmente pacíficos, mantêm-se afastados dos conflitos humanos e vivem em comunidades isoladas. Possuem uma forte afinidade com a magia druídica e são habilidosos na manipulação da terra, animais e plantas. São seres introspectivos, valorizando a harmonia entre a natureza e suas próprias comunidades, defendendo-as com fervor quando ameaçadas.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'sabedoria', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'Magia Firbolg', 'Você conhece um truque à sua escolha da lista de truques do druida. Você pode conjurar Detectar Magia e Disfarçar com esse traço, usando Sabedoria como sua habilidade de conjuração para eles. Depois de conjurar uma dessas magias, você não poderá conjurá-la novamente com esse traço até terminar um descanso curto ou longo. Quando você usa essa versão de Disfarçar, pode parecer até 1 metro mais baixo que o normal, permitindo que se misture mais facilmente com humanos e elfos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'Passo Oculto', 'Como uma ação bônus, você pode magicamente ficar invisível até o final do seu próximo turno ou até você atacar, fazer um teste de dano, ou forçar alguém a fazer um teste de resistência. Depois de usar esse traço, você não poderá usá-lo novamente até terminar um descanso curto ou longo.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'Compleição Poderosa', 'Você é considerado de uma categoria de tamanho maior para determinar sua capacidade de carga, o peso que você pode empurrar, arrastar ou erguer e criaturas que você pode agarrar.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'firbolg'), 'Fala de Besta e Folha', 'Você tem a habilidade de se comunicar de maneira limitada com animais e plantas. Eles podem entender o significado de suas palavras, embora você não tenha nenhuma habilidade especial para entendê-los em retorno. Você tem vantagem em todos os testes de Carisma que você faz para influenciá-los.', 'passiva', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'firbolg'), 2.10, 2.25, 2.40);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'firbolg'), 130, 150, 170);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'firbolg'), 30, 1500);


-- ===== ILLITHID =====
-- Nota: o traço original permite +1 em Sabedoria OU Carisma, à escolha. O schema só modela "+N num
-- atributo fixo" ou "+N em N atributos livres à escolha do jogador" — por fidelidade optamos por fixar
-- Carisma (mais alinhado à presença dominadora do illithid), mencionado na descrição do traço abaixo.
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'illithid', 'Illithid', 'mistica', 9, 'medio', NULL,
    'Comunica-se primariamente por telepatia; não possui um idioma falado tradicional.',
    NULL,
    'Os Illithid, ou devoradores de mentes, são criaturas inteligentes e cruéis que habitam principalmente o subsolo e as infinidades extraplanares. Com corpos humanoides e cabeças polvosas, eles possuem poderes psíquicos extraordinários, incluindo a capacidade de devorar e consumir as mentes de outras criaturas. Sua sociedade é rigidamente estruturada, liderada pelos Anciões e baseada na dominação mental e no controle.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'inteligencia', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'Mente Aberrante', 'Mesmo os illithids que passaram por mudanças de alinhamento têm dificuldade para entender os sentimentos de seres menos alienígenas. Você tem desvantagem em todos os testes de habilidade de Carisma nos quais não é proficiente. Seu tipo de criatura é aberração.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'Devorar Cérebro', 'Quando uma criatura viva a até 1,5 metro de você for reduzida a 0 pontos de vida, você pode, como reação, devorar completamente o cérebro dela, ganhando pontos de vida temporários iguais ao seu nível + seu bônus de proficiência, além de poder receber a resposta para uma pergunta que o cérebro consumido sabia. Essa criatura deve ter tamanho Médio ou menor. Alternativamente, como ação, você pode consumir o cérebro de uma criatura morta há poucos minutos e ganhar os mesmos benefícios. Você recupera o uso desse traço quando completa um descanso curto ou longo.', 'uso_unico', 2),
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'Explosão Mental', 'Você pode usar sua ação bônus para emitir uma explosão psíquica em um cone de 4,5 metros. Cada criatura na área deve realizar um teste de resistência de Inteligência (CD 8 + seu modificador de Inteligência + seu bônus de proficiência). Uma criatura sofre 2d6 de dano psíquico em um teste falho, e metade desse dano em um teste bem-sucedido. O dano aumenta para 4d6 no 6º nível, 6d6 no 11º nível e 8d6 no 16º nível. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um descanso curto ou longo.', 'multiplos_usos', 3),
    ((SELECT id FROM racas WHERE slug = 'illithid'), 'Telepatia', 'Você pode se comunicar mentalmente com outra criatura que conheça pelo menos um idioma em um raio de 18 metros. Essa criatura não precisa compartilhar um idioma com você, mas a menos que tenha telepatia, só pode receber e responder, não pode iniciar ou encerrar uma conversa telepática. Você deve estar consciente para usar esta característica e não pode se comunicar telepaticamente com múltiplas criaturas ao mesmo tempo.', 'passiva', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'illithid'), 1.75, 1.75, 1.75);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'illithid'), 15, 120);


-- ===== GENASI (base compartilhada: Constituição +2, deslocamento 9m, Manifestação Elemental e Absorção de Energia) =====

-- Genasi da Água
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'genasi-agua', 'Genasi da Água', 'mistica', 9, 'medio', NULL,
    'Comum e Primordial (dialeto Aquan)',
    NULL,
    'Os Genasi são descendentes de humanos e entidades elementais, possuindo uma conexão inata com um dos quatro elementos primordiais. Um Genasi da Água pode apresentar pele translúcida ou uma brisa suave ao seu redor, refletindo sua linhagem aquática. Eles frequentemente possuem uma mentalidade independente e têm a capacidade de controlar e manipular o elemento ao qual estão ligados.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Manifestação Elemental', 'No 5º nível, você é capaz de convocar um aliado primordial. Como uma ação, você invoca um Elemental da Água que se manifesta em um espaço desocupado que você possa ver dentro de 9 metros, usando o bloco de estatísticas do Espírito Elemental adaptado à água. Ele desaparece quando cai a 0 pontos de vida ou após um número de horas igual ao seu nível. Ele compartilha sua contagem de iniciativa e age imediatamente após o seu turno, obedecendo a seus comandos verbais; se não receber comandos, realiza a ação Esquiva e se move para evitar perigo. Você pode usar esta habilidade uma vez por descanso longo.', 'uso_unico', 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Absorção de Energia', 'Com uma ação, você se concentra nas forças naturais ao seu redor e extrai delas um fluxo vital que regenera seu corpo. Você recupera 2d6 pontos de vida, valor que aumenta para 3d6 no 6º nível, 4d6 no 11º nível e 5d6 no 16º nível. Após usar essa habilidade, é necessário um descanso curto ou longo para poder usá-la novamente.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Resistência às Profundezas', 'Você tem imunidade a dano de Ácido e Frio.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Anfíbio', 'Você pode respirar ar e água, e tem deslocamento de natação de 12 metros.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Magia Elemental', 'Você conhece o truque Moldar Água. Quando alcançar o 3° nível, você pode conjurar Criar ou Destruir Água uma vez com esse traço como uma magia de 2° nível, sem necessidade de componentes materiais, recuperando a capacidade de fazê-lo ao terminar um descanso curto ou longo. Sua habilidade de conjuração para essa magia é Constituição.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 'Escudo de Bolhas', 'A partir do 3° nível, a cada descanso longo você cria uma camada protetora de água que lhe fornece pontos de vida temporários iguais a (seu nível × seu bônus de proficiência). Você pode com uma ação consumir um corpo de água de 20 litros para recuperar seu Escudo de Bolhas novamente.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-agua'), 20, 120);

-- Genasi do Ar
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'genasi-ar', 'Genasi do Ar', 'mistica', 9, 'medio', NULL,
    'Comum e Primordial (dialeto Auran)',
    NULL,
    'Os Genasi são descendentes de humanos e entidades elementais, possuindo uma conexão inata com um dos quatro elementos primordiais. Um Genasi do Ar carrega leveza e uma brisa constante ao redor de si, refletindo sua linhagem ligada aos ventos.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Manifestação Elemental', 'No 5º nível, você é capaz de convocar um aliado primordial. Como uma ação, você invoca um Elemental do Ar que se manifesta em um espaço desocupado que você possa ver dentro de 9 metros, usando o bloco de estatísticas do Espírito Elemental adaptado ao ar. Ele desaparece quando cai a 0 pontos de vida ou após um número de horas igual ao seu nível. Ele compartilha sua contagem de iniciativa e age imediatamente após o seu turno, obedecendo a seus comandos verbais; se não receber comandos, realiza a ação Esquiva e se move para evitar perigo. Você pode usar esta habilidade uma vez por descanso longo.', 'uso_unico', 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Absorção de Energia', 'Com uma ação, você se concentra nas forças naturais ao seu redor e extrai delas um fluxo vital que regenera seu corpo. Você recupera 2d6 pontos de vida, valor que aumenta para 3d6 no 6º nível, 4d6 no 11º nível e 5d6 no 16º nível. Após usar essa habilidade, é necessário um descanso curto ou longo para poder usá-la novamente.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Fôlego Interminável', 'Você pode prender seu fôlego indefinidamente.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Queda Suave', 'Enquanto você estiver caindo e não estiver incapacitado, você pode subtrair até 18 metros de queda ao calcular o dano, e pode se mover até 1,2 metro horizontalmente para cada 30 centímetros que cair.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Resistência a Eletricidade', 'Você tem imunidade a dano Elétrico.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Misturar-se ao Vento', 'Você conhece o truque Lufada. Quando alcançar o 3° nível, você pode conjurar Levitação uma vez com esse traço, sem necessidade de componentes materiais, recuperando a capacidade de fazê-lo ao terminar um descanso curto ou longo. Sua habilidade de conjuração para essa magia é Constituição.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 'Agilidade do Vento', 'No 3° nível você recebe um bônus na sua CA contra ataques à distância igual ao seu bônus de proficiência. Além disso, adiciona esse bônus em testes de resistência de Destreza para evitar magias ou efeitos que permitam tal teste para desviar.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-ar'), 20, 120);

-- Genasi do Fogo
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'genasi-fogo', 'Genasi do Fogo', 'mistica', 9, 'medio', NULL,
    'Comum e Primordial (dialeto Ignan)',
    NULL,
    'Os Genasi são descendentes de humanos e entidades elementais, possuindo uma conexão inata com um dos quatro elementos primordiais. Um Genasi do Fogo pode ter cabelos flamejantes ou olhos brilhantes como brasas, refletindo sua linhagem ígnea.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'inteligencia', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Manifestação Elemental', 'No 5º nível, você é capaz de convocar um aliado primordial. Como uma ação, você invoca um Elemental do Fogo que se manifesta em um espaço desocupado que você possa ver dentro de 9 metros, usando o bloco de estatísticas do Espírito Elemental adaptado ao fogo. Ele desaparece quando cai a 0 pontos de vida ou após um número de horas igual ao seu nível. Ele compartilha sua contagem de iniciativa e age imediatamente após o seu turno, obedecendo a seus comandos verbais; se não receber comandos, realiza a ação Esquiva e se move para evitar perigo. Você pode usar esta habilidade uma vez por descanso longo.', 'uso_unico', 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Absorção de Energia', 'Com uma ação, você se concentra nas forças naturais ao seu redor e extrai delas um fluxo vital que regenera seu corpo. Você recupera 2d6 pontos de vida, valor que aumenta para 3d6 no 6º nível, 4d6 no 11º nível e 5d6 no 16º nível. Após usar essa habilidade, é necessário um descanso curto ou longo para poder usá-la novamente.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Fogo Poderoso', 'Sempre que você causar dano de fogo, você causa um dano extra igual à metade do seu nível arredondado para baixo.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Nascido no Fogo', 'Você tem imunidade a dano de Fogo.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Alcançar as Chamas', 'Você conhece o truque Criar Chamas. Quando alcançar o 3° nível, você pode conjurar Mãos Flamejantes uma vez com esse traço como uma magia de 1° nível, sem necessidade de componentes materiais, recuperando a capacidade de fazê-lo ao terminar um descanso curto ou longo. Sua habilidade de conjuração para essa magia é Constituição.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 'Chama Convergente', 'A partir do 3º nível, você pode canalizar o poder das chamas em um único ponto. Quando você acertar um ataque, pode fazer com que ele exploda em chamas ao contato, causando dano adicional de fogo igual a um número de d8 igual ao seu bônus de proficiência; todas as criaturas em um raio de 1,5 metro ao redor do alvo também sofrem esse dano. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um descanso longo.', 'multiplos_usos', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-fogo'), 20, 120);

-- Genasi da Terra
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'genasi-terra', 'Genasi da Terra', 'mistica', 9, 'medio', NULL,
    'Comum e Primordial (dialeto Terran)',
    NULL,
    'Os Genasi são descendentes de humanos e entidades elementais, possuindo uma conexão inata com um dos quatro elementos primordiais. Um Genasi da Terra tem uma compleição sólida e firme, refletindo sua linhagem ligada à rocha e ao solo.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'forca', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Manifestação Elemental', 'No 5º nível, você é capaz de convocar um aliado primordial. Como uma ação, você invoca um Elemental da Terra que se manifesta em um espaço desocupado que você possa ver dentro de 9 metros, usando o bloco de estatísticas do Espírito Elemental adaptado à terra. Ele desaparece quando cai a 0 pontos de vida ou após um número de horas igual ao seu nível. Ele compartilha sua contagem de iniciativa e age imediatamente após o seu turno, obedecendo a seus comandos verbais; se não receber comandos, realiza a ação Esquiva e se move para evitar perigo. Você pode usar esta habilidade uma vez por descanso longo.', 'uso_unico', 0),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Absorção de Energia', 'Com uma ação, você se concentra nas forças naturais ao seu redor e extrai delas um fluxo vital que regenera seu corpo. Você recupera 2d6 pontos de vida, valor que aumenta para 3d6 no 6º nível, 4d6 no 11º nível e 5d6 no 16º nível. Após usar essa habilidade, é necessário um descanso curto ou longo para poder usá-la novamente.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Caminhada Terrestre', 'Você pode se mover através de terreno difícil feito de terra ou pedra sem gastar movimento extra. Você tem deslocamento de escavação de 9 metros.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Visão Sísmica', 'Você possui visão sísmica de 6 metros.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Resistência a Impacto', 'Você tem imunidade a dano de Concussão.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Desmoronar Rochas', 'Você conhece o truque Orientação. Quando alcançar o 3° nível, você pode conjurar Onda Trovejante uma vez com esse traço, sem necessidade de componentes materiais, recuperando a capacidade de fazê-lo ao terminar um descanso curto ou longo. Sua habilidade de conjuração para essa magia é Constituição.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 'Pele Rochosa', 'Sua carne se compacta e endurece como pedra, dissipando parte do impacto de golpes e projéteis. Enquanto estiver consciente, todo dano (exceto psíquico) que você receber é reduzido em um valor igual ao seu modificador de Constituição (mínimo 1). Essa redução se aplica antes de resistências ou vulnerabilidades.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'genasi-terra'), 20, 120);


-- ===== GITH (base compartilhada: Constituição +2, Proficiências, Rejeitar o Cativeiro, Poder Psiônico) =====

-- Gith Githzerai
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'gith-githzerai', 'Gith Githzerai', 'mistica', 9, 'medio', NULL,
    'Comum e Gith',
    NULL,
    'Os Giths são uma raça que sofreu séculos de escravidão nas mãos dos Illithids. Após uma revolta bem-sucedida, dividiram-se em duas sub-raças. Os Githzerai, buscando preservar a paz e a estabilidade, optaram por um caminho de ordem e harmonia, dedicando-se a criar uma cultura focada na proteção da paz e na busca do equilíbrio.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Proficiências', 'Você é proficiente com armaduras leves e médias, espadas curtas, espadas longas e espadas de duas mãos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Rejeitar o Cativeiro', 'Todos os gith compartilham um legado cultural de horror por terem sido escravizados. Você tem vantagem em testes de resistência contra ser encantado ou impedido.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Poder Psiônico', 'Os gith foram criados pelos illithids como escravos e possuem algumas das habilidades mentais avançadas de seus antigos senhores. Você conhece o truque Mãos Mágicas, embora a mão seja sempre invisível. Essa habilidade conta como Psiônica, e a habilidade de conjuração para essa magia é determinada pela sua sub-raça.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Bravura', 'Você tem vantagem em testes de resistência contra ficar amedrontado.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Mente Fortalecida pelo Transe', 'Ao terminar um descanso longo, você pode escolher uma das seguintes opções para o dia: Aura de Calma (você ganha pontos de vida temporários iguais ao seu nível de personagem + seu modificador de Sabedoria); ou Foco Psíquico (você tem vantagem em testes de resistência de Sabedoria até o final de seu próximo descanso longo).', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Defesa Psíquica', 'Com uma reação, você pode usar o poder de sua mente para interferir com os ataques de seus inimigos. Quando uma criatura realiza um ataque dentro de 9 metros de você, você pode usar sua reação para causar desvantagem na jogada de ataque. Você pode usar esta habilidade um número de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um descanso longo.', 'multiplos_usos', 5),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Aura Suave', 'Você possui visão às cegas em até 1,5 metro enquanto não estiver incapacitado e se concentrando em algum efeito.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 'Intuição Pela Calma', 'Você conhece o truque Orientação.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 1.85, 1.85, 1.85);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 85, 85, 85);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githzerai'), 14, 120);

-- Gith Githyanki
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'gith-githyanki', 'Gith Githyanki', 'mistica', 9, 'medio', NULL,
    'Comum e Gith',
    NULL,
    'Os Giths são uma raça que sofreu séculos de escravidão nas mãos dos Illithids. Após uma revolta bem-sucedida, dividiram-se em duas sub-raças. Os Githyanki, acreditando na necessidade de poder para garantir a segurança do seu povo, escolheram um caminho de força militar e expansão, tornando-se uma sociedade armada e conquistadora.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Proficiências', 'Você é proficiente com armaduras leves e médias, espadas curtas, espadas longas e espadas de duas mãos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Rejeitar o Cativeiro', 'Todos os gith compartilham um legado cultural de horror por terem sido escravizados. Você tem vantagem em testes de resistência contra ser encantado ou impedido.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Poder Psiônico', 'Os gith foram criados pelos illithids como escravos e possuem algumas das habilidades mentais avançadas de seus antigos senhores. Você conhece o truque Mãos Mágicas, embora a mão seja sempre invisível. Essa habilidade conta como Psiônica, e a habilidade de conjuração para essa magia é determinada pela sua sub-raça.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Ameaçador', 'Você adquire proficiência na perícia Intimidação.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Êxtase do Conquistador', 'Quando você realizar um acerto crítico contra uma criatura, você recebe um bônus de +1 em suas jogadas de acerto até o fim do combate.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Fúria do Conquistador', 'Uma vez por turno, quando você realizar uma jogada de ataque, teste de resistência ou teste de perícia, você pode adicionar um dado extra à rolagem, depois de ver o resultado mas antes do mestre declarar sucesso ou fracasso: 1d4 se você não estiver com pontos de vida máximos; 1d8 se estiver com 50% ou menos de seus pontos de vida; 1d12 se estiver com 1 ponto de vida.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Resiliência pela Raiva', 'Quando você é reduzido a 0 pontos de vida, mas não é morto instantaneamente, você pode fazer uma jogada de resistência: role 1d12 e adicione seu modificador de Carisma e seu nível de personagem. Se o total for maior do que o dano recebido que o reduziu a 0, você fica com 1 ponto de vida em vez de cair.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 'Resistência Pela Raiva', 'Você conhece o truque Resistência.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 1.85, 1.85, 1.85);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 85, 85, 85);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'gith-githyanki'), 14, 120);


-- ===== GNOMO (base compartilhada: Inteligência +2, deslocamento 7,5m, Esperteza Gnômica) =====

-- Gnomo Cabeça de Ponta
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'gnomo-cabeca-de-ponta', 'Gnomo Cabeça de Ponta', 'global', 7.5, 'pequeno', NULL,
    'Comum e Gnômico',
    NULL,
    'Pequenos no tamanho, mas imensos na inventividade, os gnomos são mestres em transformar qualquer situação em uma oportunidade — seja para aprender algo novo, pregar uma boa peça ou defender ferozmente o que amam. Os Cabeça de Ponta são inventores incansáveis, engenhoqueiros de mão cheia e estudiosos dedicados. Vivem cercados de pergaminhos, ferramentas e protótipos que podem explodir a qualquer momento — mas que, quando funcionam, mudam o rumo de uma aldeia inteira. Gnomos variam entre 40 e 80 centímetros de altura, com corpos ágeis e rostos expressivos. Suas orelhas são longas e móveis, denunciando emoções, e seus olhos brilham com curiosidade constante.',
    'Masculinos: Berrin, Calno, Duvrik, Fenwick, Garrin, Jorvo, Lurmin, Tobren, Zannik. Femininos: Allira, Briska, Dimli, Fennya, Glimra, Nessa, Trilla, Vany, Zilra. Sobrenomes: Engrenapreta, Folhasoltas, Martelofino, Olho-claro, Rodabem, Sombrasuave, Tintatorta.',
    'A vida gnômica é regida por duas forças: a curiosidade e a comunidade. Gnomos raramente trabalham sozinhos — mesmo o mais recluso deles compartilha descobertas e experimentos com vizinhos. Valorizam humor e leveza, mas isso não significa que não sejam sérios quando necessário. Acreditam que o riso é uma defesa contra o desespero, e por isso até em tempos de guerra há música e piadas.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'inteligencia', 3, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Esperteza Gnômica', 'Vantagem em testes de resistência de Inteligência, Sabedoria e Carisma contra magia.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Ilusionista Nato', 'Conhecimento do truque Ilusão Menor; Inteligência é usada para conjurá-lo.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Curioso', 'Você recebe proficiência na perícia de Investigação e possui vantagem em testes de Destreza (Investigação).', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Sabido', 'Você recebe proficiência em uma ferramenta de artesão à sua escolha. Sempre que fizer um teste com essa ferramenta, você adiciona 1d6 à rolagem.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Epifania Caótica', 'Ao iniciar um descanso longo, você tem uma epifania e cria uma engenhoca improvisada capaz de replicar o efeito de uma magia. O mestre escolhe aleatoriamente uma magia de até o nível igual à metade do seu nível de personagem (arredondado para baixo). Você pode usar essa engenhoca para conjurar essa magia uma vez antes do próximo descanso longo. A engenhoca é única e pessoal — ninguém além de você pode usá-la — e se desgasta após o uso, precisando ser refeita na próxima epifania.', 'uso_unico', 4),
    ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 'Magia Gnômica', 'Você conhece um truque e uma magia de 1° nível da lista de magias de mago, da escola de transmutação. Você pode conjurar essa magia uma vez a cada descanso longo. Inteligência é sua habilidade para essa magia.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 0.40, 0.60, 0.80);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 20, 20, 20);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-cabeca-de-ponta'), 20, 425);

-- Gnomo Olhos Fundos
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'gnomo-olhos-fundos', 'Gnomo Olhos Fundos', 'global', 7.5, 'pequeno', NULL,
    'Comum, Gnômico e Subterrâneo',
    NULL,
    'Pequenos no tamanho, mas imensos na inventividade, os gnomos são mestres em transformar qualquer situação em uma oportunidade. Brincalhões por natureza, os Olhos Fundos enxergam o mundo como um palco para truques, histórias e ilusões. Adoram enganar de forma inofensiva, apenas para ver a reação dos outros, mas também usam sua astúcia para proteger os seus, confundindo e distraindo inimigos.',
    NULL,
    'Acreditam que a escuridão é apenas mais uma tela para pintar imagens e criar narrativas, e não raro suas vilas subterrâneas são um espetáculo de luzes mágicas e sombras dançantes.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'inteligencia', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Esperteza Gnômica', 'Vantagem em testes de resistência de Inteligência, Sabedoria e Carisma contra magia.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Magia Gnômica', 'Você conhece um truque e uma magia de 1° nível da lista de magias de mago, da escola de ilusão, à sua escolha. Você pode conjurar essa magia uma vez a cada descanso longo. Inteligência é sua habilidade de conjuração para essa magia.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Camuflagem na Escuridão', 'Vantagem em testes de Furtividade em terrenos obscurecidos.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Pó de Pirlimpimpim', 'Quando você é atingido por um ataque, antes de receber o dano, você pode lançar ao chão um punhado de pó mágico preparado por você, criando uma nuvem espessa e cintilante. O pó reduz o dano recebido pela metade e, logo em seguida, você se torna invisível até o início do seu próximo turno ou até atacar/conjurar uma magia. Durante essa invisibilidade, você pode se mover até seu deslocamento sem provocar ataques de oportunidade. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, e recupera todos os usos após terminar um descanso longo.', 'multiplos_usos', 4),
    ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 'Idioma Adicional', 'Falam, leem e escrevem Subterrâneo.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 0.40, 0.60, 0.80);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 20, 20, 20);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-olhos-fundos'), 20, 425);

-- Gnomo Nariz Afiado
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'gnomo-nariz-afiado', 'Gnomo Nariz Afiado', 'global', 7.5, 'pequeno', NULL,
    'Comum e Gnômico',
    NULL,
    'Pequenos no tamanho, mas imensos na inventividade, os gnomos são mestres em transformar qualquer situação em uma oportunidade. Os Nariz Afiado são gnomos marcados por uma aura de imprevisibilidade e travessura. Inspirados nas lendas dos leprechauns, eles carregam a sorte consigo — mas essa sorte tem seu preço. Mestres em manipular o destino, podem conceder bênçãos temporárias a seus aliados, porém a balança da fortuna pode pender para o lado oposto em breve.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'inteligencia', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'Esperteza Gnômica', 'Vantagem em testes de resistência de Inteligência, Sabedoria e Carisma contra magia.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'Sorte Inconstante', 'Como reação, você pode tocar uma criatura que possa alcançar e conceder vantagem em uma rolagem de dado à sua escolha — ataque, teste de habilidade, teste de resistência, dano, ou qualquer outra jogada envolvendo dados. Além disso, se a rolagem for maior que a metade do valor máximo do dado, ela é considerada o valor máximo possível; se for menor, o resultado é dobrado. Após conceder essa sorte, o alvo recebe uma "marca de azar" que dura 1 hora: enquanto marcado, ele sofre uma penalidade de -1d4 em todas as rolagens de d20 que realizar. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um descanso longo.', 'multiplos_usos', 1),
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'Presença Afortunada', 'Você tem vantagem em testes de resistência contra encantamento e medo, como se a sorte estivesse sempre ao seu lado.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 'Magia da Sorte', 'Você conhece o truque Benção (Bless). Quando atingir o 3º nível, pode conjurar a magia Benção uma vez por descanso longo, usando Carisma como sua habilidade de conjuração.', 'passiva', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 0.40, 0.60, 0.80);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 20, 20, 20);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'gnomo-nariz-afiado'), 20, 425);


-- ===== GOBLIN =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'goblin', 'Goblin', 'tribal', 9, 'pequeno', NULL,
    'Comum e Goblin',
    NULL,
    'Conhecidos por sua astúcia e agilidade, os goblins vivem em bandos organizados em torno de líderes fortes. Geralmente maus neutros e focados em suas próprias necessidades, embora alguns sejam bons ou neutros.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'goblin'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'goblin'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'goblin'), 'Visão no Escuro Incomum', 'Você pode ver na penumbra até 18 metros como se fosse luz brilhante e na escuridão como se fosse penumbra. Você não consegue discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'goblin'), 'Fúria do Pequeno', 'Ao causar dano a uma criatura maior que você com um ataque ou magia, pode adicionar dano extra igual a duas vezes o seu nível. Pode usar essa habilidade uma quantidade de vezes igual ao seu bônus de proficiência, recuperando todos os usos após um descanso curto ou longo.', 'multiplos_usos', 1),
    ((SELECT id FROM racas WHERE slug = 'goblin'), 'Escapada Ágil', 'Pode usar Desengajar ou Esconder como ação bônus em cada turno.', 'passiva', 2);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'goblin'), 0.90, 1.05, 1.20);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'goblin'), 18, 27, 36);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'goblin'), 8, 60);


-- ===== GOLIATH =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'goliath', 'Goliath', 'tribal', 10.5, 'grande', NULL,
    'Comum e Gigante',
    NULL,
    'Os Goliaths são uma raça montanhosa robusta, criada em clãs que valorizam a resistência, competição e determinação. Enraizados em terras inóspitas, valorizam a força física e a adaptabilidade aos ambientes hostis, reverenciando as montanhas como guias espirituais. Com uma cultura que exalta a igualdade de gênero, respeito mútuo e lealdade ao clã, os Goliaths buscam provar sua destreza por meio de feitos heróicos e competições.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'forca', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Compleição Poderosa', 'Você é considerado de uma categoria de tamanho maior para determinar sua capacidade de carga, o peso que você pode empurrar, arrastar ou erguer e criaturas que você pode agarrar.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Atleta Natural', 'Você tem proficiência na perícia Atletismo.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Resistência da Pedra', 'Quando você sofrer dano, você pode usar sua reação para rolar um d12, adicionar seu modificador de Constituição ao valor rolado e reduzir o dano por esse resultado. Você pode usar essa habilidade um número de vezes igual ao seu bônus de proficiência e recupera todos os usos após um descanso curto ou longo.', 'multiplos_usos', 2),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Resistência Implacável', 'Quando você é reduzido a 0 pontos de vida mas não é completamente morto, você pode voltar para 1 ponto de vida. Você não pode usar essa característica novamente até completar um descanso longo.', 'uso_unico', 3),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Corpo de Colosso', 'Seu máximo de pontos de vida aumenta em 1. A cada novo nível, recebe uma quantidade de vida adicional igual à metade do seu bônus de proficiência arredondado para baixo (mínimo 1).', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'goliath'), 'Nascido nas Montanhas', 'Você está aclimatado a altas altitudes, incluindo elevações acima de 6.000 metros, e naturalmente adaptado a climas frios. Você recebe resistência a dano de frio.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'goliath'), 2.60, 2.95, 3.30);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'goliath'), 350, 510, 670);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'goliath'), 18, 100);


-- ===== GRUNG =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'grung', 'Grung', 'tribal', 6, 'pequeno', NULL,
    'Comum',
    NULL,
    'Pequenos anfíbios venenosos que vivem em bandos organizados por tonalidade de pele, os grungs são resistentes a quase todo tipo de veneno e extremamente ágeis em ambientes úmidos.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'grung'), 'sabedoria', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'grung'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'grung'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'grung'), 'Anfíbio', 'Você pode respirar ar e água.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'grung'), 'Imunidade a Venenos', 'Você é imune a danos causados por venenos e à condição envenenada.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'grung'), 'Pele Venenosa', 'Qualquer criatura que te agarre ou entre em contato direto com a sua pele deve ter sucesso em um teste de resistência de Constituição (CD 8 + seu modificador de Constituição + seu bônus de proficiência) ou ser envenenada por 1 minuto; uma criatura envenenada que não está mais em contato direto com você pode repetir o teste no final de cada um dos seus turnos. Você também pode aplicar esse veneno a qualquer arma perfurante como parte de um ataque com ela; o alvo deve ter sucesso em um teste de resistência de Constituição ou sofrer 2d4 de dano venenoso.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'grung'), 'Salto em Pé', 'Seu salto em distância atinge até 7,5 metros e o salto em altura é de até 4,5 metros, com ou sem início de corrida.', 'passiva', 4);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'grung'), 0.80, 1.00, 1.20);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'grung'), 55, 55, 55);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'grung'), 1, 20);


-- ===== HALFLING =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'halfling', 'Halfling', 'global', 7.5, 'pequeno', NULL,
    'Comum e Halfling. A linguagem Halfling não é secreta, mas os halflings são relutantes em compartilhá-la com os outros. Eles escrevem muito pouco, por isso não possuem uma literatura rica — mas sua tradição oral é muito forte.',
    NULL,
    'Os Halflings são seres pequenos e alegres, conhecidos por sua curiosidade inesgotável e otimismo. Vindos de comunidades agrícolas ou nômades, eles são seres muito sociais, valorizando a amizade, a harmonia e a comunidade. Apesar de sua estatura pequena, são ágeis e habilidosos, capazes de escapar de problemas ou solucioná-los com astúcia e diplomacia.',
    NULL,
    'A maioria dos halflings é leal e boa. Via de regra, possuem um bom coração e são amáveis, odeiam ver o sofrimento dos outros e não toleram a opressão. São também muito ordeiros e tradicionais, fortemente apegados à sua comunidade e ao conforto de suas antigas tradições.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'destreza', 2, NULL, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Sortudo', 'Sempre que você obtiver um 1 natural em uma jogada de ataque, teste de habilidade ou teste de resistência, você pode jogar de novo o dado e deve utilizar o novo resultado.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Bravura', 'Você tem vantagem em testes de resistência contra ficar amedrontado.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Mente Estável', 'Você tem vantagem em testes de resistência de Inteligência e contra ser enfeitiçado.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Agilidade Halfling', 'Você pode mover-se através do espaço de qualquer criatura que for de um tamanho maior que o seu. Além disso, pode tentar se esconder mesmo quando possuir apenas a cobertura de uma criatura que for no mínimo um tamanho maior que você.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Mãos Ágeis', 'Você recebe proficiência na perícia Prestidigitação e possui vantagem em testes de Destreza (Prestidigitação).', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'halfling'), 'Rosto Inocente', 'Sua lábia é excepcional e suas técnicas são desenvolvidas: você recebe proficiência nas perícias de Persuasão e Atuação, e especialização em uma dessas perícias à sua escolha.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'halfling'), 1.0, 1.0, 1.0);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'halfling'), 35, 35, 35);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'halfling'), 20, 110);


-- ===== HUMANO =====
-- Reaproveita os textos de flavor já escritos pra este projeto (o antigo seed de teste da raça), só
-- trocando as habilidades especiais placeholder pelas 3 reais do Humano (Perícia/Determinação/Talento).
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'humano',
    'Humano',
    'global',
    9,
    'medio',
    'Entre os mais covardes e mais bravos, mais geniais e mais tolos, humanos são aqueles que possuem tudo, o menor e o maior — seu espírito é indomável.',
    'Comum e um idioma adicional à escolha.',
    'Constituição física mediana em quase todos os aspectos — nem a robustez dos anões, nem a leveza dos elfos. É essa ausência de extremos que os torna adaptáveis a praticamente qualquer clima e modo de vida.',
    'Altura e peso variam mais do que em qualquer outra raça conhecida. Traços faciais, tons de pele e cabelo cobrem um espectro amplo, refletindo a mistura de povos e regiões de origem.',
    'Nomes variam enormemente por cultura e região de origem — não há um padrão racial único, ao contrário de outras raças.',
    'Tendem a se organizar em torno de metas de curto prazo — cidades, reinos e guildas construídos rapidamente, e com a mesma rapidez abandonados ou reconstruídos. Essa urgência é sua maior força e sua maior fraqueza.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), NULL, 1, 4, 0);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Perícia', 'Você ganha proficiência em duas perícias, à sua escolha.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Determinação', 'Você recebe um bônus de +1 em um teste de resistência à sua escolha.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Talento', 'Você adquire um talento de sua escolha.', 'passiva', 2);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 45.00, 70.00, 110.00);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 18, 90);


-- ===== LUMIMYR =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'lumimyr', 'Lumimyr', 'mistica', 9, 'medio', NULL,
    'Comum, Silvestre e um idioma adicional à escolha',
    NULL,
    'Os Lumimyr são humanoides com características que refletem sua conexão mágica com as fadas, sendo notáveis pela habilidade de brilhar com um brilho etéreo que os torna únicos no cosmos. Eles possuem habilidades mágicas naturais que são aperfeiçoadas com o tempo, e sua aparência física evolui conforme ganham experiência.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'inteligencia', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Herança Mágica', 'Seu tipo de criatura é Fada.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Brilho Etéreo', 'Você possui uma aura que brilha suavemente ao redor de seu corpo e reage aos seus sentimentos e emoções. Esse brilho serve tanto como defesa natural, iluminando áreas ao seu redor em 3 metros de raio, quanto como efeito mágico em interações sociais. Você possui proficiência nas perícias de Persuasão e Intimidação.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Asas Evolutivas', 'Ao atingir o 3º nível, você desenvolve asas de inseto pequenas e frágeis, ganhando deslocamento de voo de 3 metros. A cada 4 níveis subsequentes, as asas se tornam mais fortes, aumentando a distância do voo em 3 metros.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Visão no Escuro Incomum', 'Você pode ver na penumbra até 18 metros como se fosse luz brilhante e na escuridão como se fosse penumbra. Você não consegue discernir cores na escuridão, apenas tons de cinza.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Visão Fada', 'Sua visão é sensível à magia ao redor, como a percepção de seres feéricos. Você pode usar o feitiço Detectar Magia à vontade, sem componentes materiais.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'lumimyr'), 'Resistência a Veneno', 'Por sua natureza feérica, você tem resistência a dano de veneno e vantagem em testes de resistência contra veneno.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'lumimyr'), 1.70, 1.85, 2.00);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'lumimyr'), 10, 200);


-- ===== MERRYLINS =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'merrylins', 'Merrylins', 'mistica', 7.5, 'miudo', NULL,
    'Comum e Silvestre',
    NULL,
    'Os Merrylins são pequenos seres feéricos que vivem para espalhar confusão. Quase todos são caóticos, embora muitos sejam neutros ou mesmo bondosos — mas há quem use seu azar para fins mais cruéis.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'carisma', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'Aura de Azar', 'Todas as criaturas à sua escolha que estiverem até 3 metros de você possuem uma penalidade em suas jogadas de ataque que não o tenham como alvo, igual ao seu bônus de proficiência. Uma criatura se torna imune a esse efeito após causar dano em você.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'Delícia na Desgraça', 'Quando uma criatura dentro de 9 metros de você falha em um teste de habilidade, salvaguarda ou ataque, você pode usar sua reação para ganhar vantagem em seu próximo ataque, teste de habilidade ou salvaguarda dentro do próximo minuto. Você pode usar esse traço um número de vezes igual ao seu bônus de proficiência, e recupera os usos após um descanso longo.', 'multiplos_usos', 1),
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'Pequeno e Inoportuno', 'Sempre que você estiver adjacente a uma criatura hostil, ela tem desvantagem em testes de Sabedoria (Percepção) para perceber qualquer outra coisa além de você.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'merrylins'), 'Riso Incontrolável', 'Você pode lançar a magia Riso Histérico de Tasha uma vez por descanso longo, usando Carisma como sua habilidade de conjuração.', 'uso_unico', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'merrylins'), 0.20, 0.40, 0.60);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'merrylins'), 10, 10, 10);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'merrylins'), 8, 90);


-- ===== SILVESTRES =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'silvestres', 'Silvestres', 'sobrenatural', 12, 'medio', NULL,
    'Comum e Silvestre',
    NULL,
    'Os silvestres são uma mistura intrigante de humano e besta, possuindo a capacidade de se transformar em criaturas selvagens, como lobos, tigres ou ursos, sob influência de uma maldição. Essa transformação pode ser tanto um dom quanto uma maldição, pois oferece força e sentidos aguçados, mas também pode significar a perda de controle e uma luta constante contra os instintos animais.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'forca', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'destreza', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Ameaçador', 'Você adquire proficiência na perícia Intimidação.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Sentidos Aguçados', 'Você tem proficiência na perícia Percepção e vantagem em testes de Percepção que dependam de olfato ou audição.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Compleição Poderosa', 'Você é considerado de uma categoria de tamanho maior para determinar sua capacidade de carga, o peso que você pode empurrar, arrastar ou erguer e criaturas que você pode agarrar.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Visão no Escuro Incomum', 'Você pode ver na penumbra até 18 metros como se fosse luz brilhante e na escuridão como se fosse penumbra. Você não consegue discernir cores na escuridão, apenas tons de cinza.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Besta Fera', 'A partir do 3° nível, com uma ação bônus, você pode assumir uma aparência mais bestial por 1 minuto (até você morrer, cair a 0 pontos de vida, ou ser atingido por um crítico com uma arma de prata). Enquanto transformado: seus pontos de vida máximos aumentam temporariamente em 2 × (seu bônus de proficiência + seu nível); você cresce uma categoria de tamanho; recebe um bônus em sua CA, jogadas de ataque corpo-a-corpo e dano Cortante, Contundente ou Perfurante igual à metade do seu bônus de proficiência (arredondado para baixo); tem desvantagem em qualquer teste de Inteligência; e tem resistência a dano de Concussão, Cortante e Perfurante não mágicos e que não sejam feitos com armas de prata. Uma vez transformado, você não pode fazê-lo novamente até concluir um descanso curto ou longo.', 'uso_unico', 4),
    ((SELECT id FROM racas WHERE slug = 'silvestres'), 'Terror da Lua Cheia', 'Em noites de lua cheia, você se transforma em sua forma de Besta Fera se entrar em contato direto com a luz da lua. Quando se transforma dessa forma, você só pode voltar ao normal ao fim da noite, quando morrer, cair a 0 pontos de vida ou ser atingido por um crítico com uma arma de prata. Você se torna extremamente agressivo e territorialista, incapaz de distinguir amigos de inimigos.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'silvestres'), 1.90, 1.90, 1.90);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'silvestres'), 125, 125, 125);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'silvestres'), 10, 70);


-- ===== ORC =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'orc', 'Orc', 'tribal', 10.5, 'medio', NULL,
    'Comum e Orc. O Orc é um idioma ríspido, com consoantes duras; não possui alfabeto próprio, usando o alfabeto Anão.',
    NULL,
    'Conhecidos por sua robustez e habilidades em combate, os orcs têm uma sociedade altamente estruturada em torno de líderes fortes e xamãs poderosos. Embora frequentemente retratados como antagonistas, sua identidade vai muito além da brutalidade, valorizando a lealdade e a honra entre suas tribos. Orcs possuem territórios fixos e normalmente vivem sossegados, mas são extremamente violentos contra indivíduos que invadem ou tentam usurpar o que lhes pertence.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'orc'), 'forca', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'constituicao', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Ameaçador', 'Você adquire proficiência na perícia Intimidação.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Compleição Poderosa', 'Você é considerado de uma categoria de tamanho maior para determinar sua capacidade de carga, o peso que você pode empurrar, arrastar ou erguer e criaturas que você pode agarrar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Armas de Orcs', 'Você é proficiente com machados grandes, martelos de guerra e marretas.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Frenesi Desenfreado', 'Em resposta a ser atingido por um ataque corpo-a-corpo, como reação você pode realizar um ataque corpo-a-corpo com arma com vantagem contra o atacante. Depois de usar esta característica, você não poderá usá-la novamente até terminar um descanso curto ou longo.', 'uso_unico', 3),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Avassalador', 'Quando você tiver vantagem em uma jogada de ataque corpo-a-corpo e acertar uma criatura, ela sofre um dano extra igual ao seu bônus de proficiência.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'orc'), 'Ataques Selvagens', 'Quando você atinge um ataque crítico com uma arma corpo-a-corpo, você pode rolar um dos dados de dano da arma mais uma vez e adicioná-lo ao dano extra causado pelo acerto crítico.', 'passiva', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'orc'), 2.10, 2.30, 2.50);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'orc'), 240, 285, 330);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'orc'), 14, 75);


-- ===== TIEFLING (base compartilhada: Carisma +2, Inteligência +1, Resistência Infernal, Visão no Escuro
-- Superior, Resistência à magia — nenhuma das 3 linhagens abaixo soma um bônus adicional de ASI) =====

-- Tiefling Diabos da Mente
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'tiefling-diabos-da-mente', 'Tiefling Diabos da Mente', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Infernal',
    NULL,
    'Há duas formas pelas quais tieflings vêm a existir: a mais comum é o nascimento natural de uma linhagem já marcada por sangue infernal; a outra remonta a um antigo pacto com o próprio Asmodeus, que infundiu sangue infernal na linhagem humana. Os Tieflings Diabos da Mente herdam o dom da telepatia e uma intuição afiada para enxergar através de mentiras.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'inteligencia', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Resistência Infernal', 'Você tem resistência a dano de Fogo e Necrótico, mas vulnerabilidade a dano Radiante.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Resistência à Magia', 'Você tem vantagem em todos os testes de resistência contra magia que envolvam Inteligência, Sabedoria e Carisma.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Telepatia', 'Você pode formar uma conexão telepática entre sua mente e a de outra pessoa. Como ação bônus, escolha uma criatura que você possa ver a até 9 metros de você. Vocês podem falar telepaticamente um com o outro enquanto estiverem a uma distância em km igual ao seu nível. Para se entenderem, cada um deve falar mentalmente em um idioma que o outro conheça.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Intuição Avançada', 'Sempre que você fizer um teste de Inteligência (Intuição) relacionado a ver se uma criatura está mentindo, você será considerado proficiente na perícia Intuição e adicionará o dobro do seu bônus de proficiência ao teste, em vez do seu bônus de proficiência normal.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 'Leitura Mental', 'Ao atingir o 5° nível, você pode conjurar a magia Detectar Pensamentos uma vez por descanso longo, sem gastar espaço de magia. Carisma é sua habilidade de conjuração para essa magia.', 'uso_unico', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-mente'), 18, 100);

-- Tiefling Diabos do Corpo
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'tiefling-diabos-do-corpo', 'Tiefling Diabos do Corpo', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Infernal',
    NULL,
    'Há duas formas pelas quais tieflings vêm a existir: a mais comum é o nascimento natural de uma linhagem já marcada por sangue infernal; a outra remonta a um antigo pacto com o próprio Asmodeus. Os Tieflings Diabos do Corpo canalizam sua herança infernal como força física e chamas que jorram do próprio sangue.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'inteligencia', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Resistência Infernal', 'Você tem resistência a dano de Fogo e Necrótico, mas vulnerabilidade a dano Radiante.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Resistência à Magia', 'Você tem vantagem em todos os testes de resistência contra magia que envolvam Inteligência, Sabedoria e Carisma.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Chamas do Sangue', 'Ao sofrer dano em combate, você pode canalizar a dor em energia infernal. Ao ser atingido por um ataque corpo-a-corpo, você pode liberar uma explosão de chamas infernais: todas as criaturas em um raio de 3 metros ao seu redor sofrem dano de Fogo igual ao seu nível, e você se cura em todo o dano causado por essa habilidade. Você pode utilizar essa habilidade a cada descanso curto ou longo.', 'uso_unico', 3),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Proeza Física', 'Você se torna excepcionalmente hábil em feitos de força. Você recebe proficiência na perícia Atletismo e, caso já seja proficiente, adiciona o dobro do seu bônus de proficiência a testes relacionados a essa perícia.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 'Toque Infernal', 'Ao atingir o 5° nível, você pode conjurar a magia Infligir Ferimentos em nível 2 uma vez por descanso longo, sem gastar espaços de magia. Seu modificador de conjuração para essa magia é baseado no seu Carisma.', 'uso_unico', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-do-corpo'), 18, 100);

-- Tiefling Diabos da Alma
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'tiefling-diabos-da-alma', 'Tiefling Diabos da Alma', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Infernal',
    NULL,
    'Há duas formas pelas quais tieflings vêm a existir: a mais comum é o nascimento natural de uma linhagem já marcada por sangue infernal; a outra remonta a um antigo pacto com o próprio Asmodeus. Os Tieflings Diabos da Alma herdam o dom da sedução e do encantamento, capazes de reforçar aqueles que caem sob sua influência.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'inteligencia', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Resistência Infernal', 'Você tem resistência a dano de Fogo e Necrótico, mas vulnerabilidade a dano Radiante.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Visão no Escuro Superior', 'Você pode ver na penumbra em um raio de 36 metros, como se fosse luz plena, e na escuridão como se fosse penumbra. Você não consegue distinguir cores na escuridão, apenas tons de cinza.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Resistência à Magia', 'Você tem vantagem em todos os testes de resistência contra magia que envolvam Inteligência, Sabedoria e Carisma.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Favor do Encantador', 'Criaturas que estão encantadas por você (sob efeito de magias da escola de Encantamento lançadas por você) recebem um bônus à sua escolha (CA, jogadas de ataque ou testes de resistência), igual à metade do seu bônus de proficiência (arredondado para baixo). Você escolhe qual bônus conceder no momento em que a criatura fica encantada, e o efeito dura enquanto o encantamento permanecer ativo.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Aura de Tentação', 'Você recebe proficiência em Persuasão e Enganação. Caso já seja proficiente em uma dessas perícias, você adiciona o dobro do seu bônus de proficiência a testes relacionados a ela.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 'Beijo Infernal', 'Ao atingir o 5° nível, você pode conjurar a magia Enfeitiçar Pessoa no nível 2 uma vez por descanso longo, sem gastar espaços de magia. Caso a criatura falhe no teste de resistência contra a magia, você pode causar 2d6 de dano psíquico adicional como parte da ação. Seu modificador de conjuração para essa magia é baseado no seu Carisma.', 'uso_unico', 5);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 1.50, 1.75, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 45, 70, 110);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'tiefling-diabos-da-alma'), 18, 100);


-- ===== THRI-KREEN =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'thri-kreen', 'Thri-Kreen', 'tribal', 12, 'medio', NULL,
    'Thri-Kreen (falado, lido e escrito) e Comum (apenas lido e escrito)',
    'Um thri-kreen adulto tem cerca de 2,1 metros de altura, com um corpo de cerca de 2,1 a 2,7 metros de comprimento. Suas quatro garras terminam em pinças pequenas, suas duas pernas são extremamente poderosas, capazes de saltos incríveis para frente, e seu corpo é coberto por uma carapaça de quitina amarelo-arenosa reforçada por um exoesqueleto resistente. A cabeça é rematada por duas antenas, com dois olhos compostos e multifacetados e uma boca com pequenas pinças.',
    'Machos e fêmeas thri-kreen são fisicamente indistinguíveis e normalmente não vestem mais do que arreios para carregar armas e comida. A liberação de feromônios muda a coloração de seus olhos e denuncia seus verdadeiros sentimentos: quanto mais claros os olhos, mais positiva a emoção; cores mais escuras indicam sentimentos negativos. Como carnívoros, os thri-kreen normalmente adoecem ao consumir matéria vegetal, com exceção de algumas especiarias e frutas comuns.',
    NULL,
    'Os thri-kreen não precisam dormir e por isso têm dificuldade em entender o conceito de "preguiça" ou exaustão em outras raças; sua vida é uma caçada contínua que só termina quando eles terminam. Têm uma forte mentalidade de matilha que domina suas relações com outras criaturas: um grupo de thri-kreen sempre precisa de uma liderança forte, e se alguém desafia essa autoridade, eles buscam apurar quem é o líder mais capaz — não por vaidade, mas para garantir que o grupo seja bem conduzido. Veem humanoides como possíveis fontes de alimento, mas raramente os caçam por não serem presas simples; têm um gosto particular por elfos, o que torna os encontros entre as duas raças frequentemente tensos. Têm um medo inato de qualquer corpo de água maior que uma poça, pois não sabem nadar nem flutuar.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'destreza', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Visão no Escuro Incomum', 'Você pode ver na penumbra até 18 metros como se fosse luz brilhante e na escuridão como se fosse penumbra. Você não consegue discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Carapaça Camaleônica', 'Como uma ação bônus, você pode mudar a cor e textura de sua carapaça adaptável para combinar com seu ambiente. Quando faz isso, você tem vantagem em testes de Destreza (Furtividade) feitos para se esconder até o início do seu próximo turno.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Estômago do Catador', 'Você está imune a contrair venenos e doenças comendo ou bebendo.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Exoesqueleto', 'Quando você não está usando armadura, sua Classe de Armadura é 13 + seu modificador de Destreza. Você pode usar sua armadura natural para determinar sua CA caso a armadura que estiver vestindo forneça uma CA inferior. Os benefícios de um escudo se aplicam normalmente enquanto você usa sua armadura natural.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Telepatia Entre os Iguais', 'Você é capaz de saber se há um igual em até 100 metros e é capaz de se comunicar com eles mentalmente.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Múltiplos Membros', 'Você possui um par de braços menores no centro do peito, com alcance de 1,5 metro, capazes de levantar um número de quilos igual a cinco vezes o seu valor de Força. Eles permitem que você interaja com objetos adicionais a cada rodada e segure itens, mas ataques feitos com eles têm desvantagem e causam metade do dano.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Salto em Pé', 'Seu salto em distância é de até 9 metros, e seu salto em altura é de até 4,5 metros, com ou sem uma corrida. Você não pode saltar para trás.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Treinamento em Armas dos Thri-Kreen', 'Os thri-kreen são conhecidos por sua habilidade marcial com o chatkcha e o gythka. Você tem proficiência com adagas, lanças, piques e glaives.', 'passiva', 7),
    ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 'Torpor', 'Você necessita apenas de 4 litros de água por semana, não precisa dormir e não sofre exaustão por falta de descanso. Durante um descanso longo, você deve permanecer pelo menos seis horas em um estado inativo e imóvel, em vez de dormir; nesse estado você parece inerte, mas permanece consciente, podendo ver e ouvir normalmente.', 'passiva', 8);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 2.10, 2.10, 2.10);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 200, 206.5, 213);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'thri-kreen'), 4, 25);


-- ===== TORTOISES =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'tortoises', 'Tortoises', 'tribal', 9, 'medio', NULL,
    'Comum e Aquan',
    NULL,
    'Humanoides-tartaruga pacientes e de vida longuíssima. Os jovens rastejam por algumas semanas após o nascimento antes de aprenderem a andar com as duas pernas.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'Visão no Escuro', 'Você pode ver na penumbra até 9 metros de você como se fosse luz plena, e na escuridão como se fosse penumbra. Você não pode discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'Mantenha Respiração', 'Você pode prender a respiração por até 1 hora por vez. Tortoises não são nadadores naturais, mas podem permanecer debaixo d''água por algum tempo antes de precisar respirar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'Armadura Natural', 'Devido à sua carapaça e ao formato do seu corpo, você não é adequado para usar armadura. Sua carapaça fornece ampla proteção: sua CA básica é 17 (seu modificador de Destreza não afeta esse número). Você não ganha nenhum benefício usando armadura, mas se estiver usando um escudo, poderá aplicar o bônus do escudo normalmente.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'tortoises'), 'Defesa da Carapaça', 'Você pode entrar na sua carapaça como uma ação. Até você emergir, você ganha um bônus na sua CA igual a 4 × seu bônus de proficiência, e tem vantagem nos testes de resistência de Força e Constituição. Enquanto estiver no seu casco, você está seguro, seu deslocamento é 0 e não pode aumentar, você tem desvantagem nos testes de Destreza, não pode reagir, e a única ação que você pode realizar é uma ação bônus para emergir da sua carapaça.', 'passiva', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tortoises'), 1.0, 1.5, 2.0);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tortoises'), 140, 140, 140);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'tortoises'), 15, 500);


-- ===== TRANSMORFOS =====
-- Nota: o traço original permite +2 em Destreza OU Inteligência, à escolha (além do Carisma +2 fixo).
-- Como o schema não modela "+N num de dois atributos específicos", isso foi traduzido para uma linha de
-- "escolha 1 atributo, +2" (mais aberta que o texto original, que restringia a Destreza ou Inteligência).
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'transmorfos', 'Transmorfos', 'mistica', 9, 'medio', NULL,
    'Comum e mais um idioma à escolha',
    NULL,
    'Os Transmorfos são criaturas que nasceram amaldiçoadas — de um experimento alquímico, da maldição de uma entidade ou de um acidente com magia. No momento de seu nascimento, o transmorfo se muda para a aparência da primeira pessoa que vê, perdendo para sempre a chance de saber seu próprio rosto, uma incógnita que contribui para uma forte crise de identidade. Sua natureza caótica muitas vezes reflete essa incerteza, tornando-os seres adaptáveis, mas também propensos a oscilações emocionais.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), 'carisma', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), NULL, 2, 1, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), 'Mente Ardilosa', 'Proficiência em Enganação.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), 'Sussurro do Abismo', 'Com uma ação, você pode sussurrar uma palavra de desorientação para um humanoide que possa ver a até 9 metros. A criatura deve fazer um teste de resistência de Sabedoria (CD 8 + seu bônus de proficiência + seu modificador de Carisma), com a CD aumentando em 1 para cada ponto que o ND da criatura for menor que o seu nível de personagem. Em caso de falha, a criatura cai no sono, podendo ser acordada se sofrer dano ou se alguém usar uma ação para sacudi-la. Se a criatura passar no teste ou for acordada de forma não natural, ela se torna imune a esse traço por 24 horas.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), 'Mudar Aparência', 'Com uma ação, você pode transformar sua aparência para a de qualquer humanoide que tenha tocado. Você possui uma Galeria de Ecos que pode armazenar um número de aparências igual a três vezes o seu nível, substituindo uma delas a cada novo toque; um rosto substituído só pode ser usado de novo tocando o humanoide original outra vez. Você não pode duplicar a aparência de uma criatura que nunca viu, e reverte à sua forma natural se morrer. Suas roupas e equipamentos não mudam de forma. Se levantar suspeitas, você tem vantagem em qualquer teste de Carisma (Enganação) para evitar detecção.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'transmorfos'), 'Invasor de Consciência', 'Como uma ação, se uma criatura humanoide estiver dormindo, você pode tocá-la e tentar invadir sua consciência com um teste de Sabedoria (Intuição). Em um teste bem-sucedido, você aprende detalhes importantes da personalidade, comportamento e maneirismos da criatura, além de uma compreensão do assunto que ela tem mais pensado recentemente. Você recebe um dado de bônus para qualquer teste de Carisma (Enganação, Persuasão ou Atuação) que fizer para se passar pela pessoa, cujo tamanho depende do resultado do teste de Intuição: 10–15 (1d4), 16–20 (1d6), 21–25 (1d8), 26–30 (1d12).', 'passiva', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'transmorfos'), 1.50, 1.65, 1.80);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'transmorfos'), 20, 100);


-- ===== TRITÃO =====
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'tritao', 'Tritão', 'sobrenatural', 9, 'medio', NULL,
    'Comum e Primordial',
    NULL,
    'Os tritões emergiram em Ygradashi, fugindo de um histórico de escravidão em seu plano natal. Com uma resistência nata, eles resistiram por eras, dedicando-se à proteção das águas do mundo. As marcas do sofrimento persistem, especialmente sob o jugo opressivo de Malzarar, deixando-os à beira da extinção — agora, dispersos por pequenas células, esses seres tentam prosperar em um mundo severo e hostil.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'forca', 1, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'constituicao', 1, NULL, 1),
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'carisma', 1, NULL, 2);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'Anfíbio', 'Você pode respirar ar e água. Adicionalmente, você possui um deslocamento de natação de 12 metros.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'Proficiência com Armas de Pesca', 'Você possui proficiência com tridentes e redes.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'Emissário do Mar', 'Bestas aquáticas têm uma afinidade extraordinária com o seu povo. Você pode se comunicar com bestas que respiram água, transmitindo ideias simples. Elas podem entender o significado de suas palavras, mas você não tem nenhuma capacidade especial para compreendê-las.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'tritao'), 'Guardiões das Profundezas', 'Adaptado para as mais profundas profundezas do oceano, você recebe resistência a dano de frio e ignora qualquer penalidade causada por um ambiente de águas profundas.', 'passiva', 3);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'tritao'), 1.50, 1.50, 1.50);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'tritao'), 15, 200);


-- ===== VAZIOS =====
-- Nota: sem altura/peso/idade no material de origem — "os Vazios não envelhecem" e mantêm o corpo de
-- antes da morte, o que não se encaixa nos 3 pontos fixos de raca_altura/raca_peso/raca_idade; essas
-- tabelas foram deliberadamente omitidas para esta raça (ficam null no detalhe, não exibidas).
-- O traço original também permite +1 num atributo à escolha (além do Constituição +2 fixo).
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'vazios', 'Vazios', 'sobrenatural', 9, 'medio', NULL,
    'Escolha três idiomas de sua escolha — normalmente os de sua vida anterior.',
    NULL,
    'Os Vazios são mortos-vivos que retornaram à vida com um objetivo específico nascido de um desejo que tinham enquanto vivos, seja vingança ou um sonho a realizar. Possuem características únicas que refletem sua existência além da morte. Eles não envelhecem, mas sua jornada não tem fim até que seu objetivo seja alcançado, sendo movidos por uma força imortal e determinada.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'vazios'), NULL, 1, 1, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Visão no Escuro Incomum', 'Você pode ver na penumbra até 18 metros como se fosse luz brilhante e na escuridão como se fosse penumbra. Você não consegue discernir cores na escuridão, apenas tons de cinza.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Natureza dos Vazios', 'Você precisa se alimentar somente uma vez por semana, e pode consumir qualquer carne crua sem problemas. Você precisa beber, mas apenas 50 ml por dia. Você precisa respirar, mas tem vantagem contra efeitos que afetam a respiração. Você não precisa dormir, e a magia não pode colocá-lo para dormir — mas precisa permanecer em um estado imóvel por 4 horas por dia, durante o qual está totalmente ciente de seu entorno, como se estivesse acordado.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Corpo Podre', 'Você tem resistência ao dano necrótico. Também tem vantagem contra doenças.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Cura Difícil', 'Você tem resistência (arredondada para cima) contra efeitos de cura que não se originam de magias ou habilidades de clérigos ou paladinos.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Fortitude Morto-Vivo', 'Se dano reduzir você a 0 pontos de vida, você deve fazer um teste de resistência de Constituição com CD igual a 5 + metade do dano sofrido, a menos que o dano seja radiante ou de um acerto crítico. Em um sucesso, você cai para 1 ponto de vida em vez disso. Você recupera o uso desse traço após um descanso curto.', 'uso_unico', 4),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Falar com o Passado', 'No 5º nível, você pode conjurar Falar com os Mortos sem componentes materiais, um número de vezes igual ao seu bônus de proficiência. Além disso, pode se comunicar com criaturas mortas-vivas por 10 minutos, se a criatura for inteligente o suficiente (Inteligência 5+) e disposta, mesmo que não compartilhem um idioma comum. Você recupera todos os usos no final de um descanso longo.', 'multiplos_usos', 5),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Objetivo de Vida', 'Antes de começar a jogar, você e seu mestre devem formular um objetivo para o Vazio. Quando esse objetivo for alcançado, o Vazio morrerá. Esse objetivo pode ser realista, como derrotar o vilão principal, ou irrealista, como dominar o mundo ou derrotar uma divindade.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'vazios'), 'Conhecimento de uma Vida Passada', 'Você temporariamente lembra de flashes de sua vida anterior. Quando você realizar um teste de habilidade, pode rolar um d6 imediatamente após ver o número no dado de d20 e adicionar esse número ao teste. Você pode usar essa característica um número de vezes igual ao seu bônus de proficiência, recuperando todas as utilizações após um descanso longo.', 'multiplos_usos', 7);


-- ===== VALDEKEANO =====
-- Nota: o material de origem chama essa raça de "VEDALKEANOS" no título, mas o próprio texto dos
-- traços a chama de "Valdekeano"/"Astúcia Valdekeana" de forma consistente — usamos esse segundo nome.
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'valdekeano', 'Valdekeano', 'mistica', 9, 'medio', NULL,
    'Comum e mais quatro idiomas à escolha',
    NULL,
    'Valdekeanos são maiores que os humanos e mais esguios, com uma pele que varia entre tons de azul e roxo. Têm uma aparência andrógena, com olhos que se assemelham a gemas lapidadas e não possuem cabelo ou pelos corporais. Seus corpos são feitos para serem eficientes, com uma postura ereta e movimentos precisos.',
    'Nomes complexos, usados para demonstrar superioridade e intelectualidade: Vranth, Zindathar, Kaelthrax, Ysh''ar, Sothis''ra.',
    'Os Valdekeanos são uma raça de intelecto brilhante e perigosa ambição, com uma fome extraordinária por conhecimento e uma arrogância ainda maior, decorrente de sua crença em sua superioridade sobre outras raças e até mesmo sobre os deuses. No passado, eram obcecados com a ideia de sobrepujar os deuses e tê-los a seu comando; por verem essa ambição como uma ofensa, os deuses se voltaram contra eles, quase levando-os à extinção. Seu legado é o de sobreviventes que aprenderam a se esconder nas sombras, esperando o momento de sobrepujar seus inimigos divinos. Grupos de Valdekeanos são normalmente compostos por um chefe e outros submissos, numa hierarquia de poder e conhecimento; quando um jovem cresce, normalmente se afasta do pai por insatisfação com a submissão, ou tenta sobrepujá-lo em sua própria casa. Praticamente todos são apóstatas, vendo os deuses como inimigos jurados.'
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'inteligencia', 3, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'sabedoria', 1, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Astúcia Valdekeana', 'Você tem vantagem em todos os testes de resistência contra magia que envolvam Inteligência, Sabedoria e Carisma.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Mente Endurecida', 'Você tem resistência a dano psíquico. No 5º nível, essa resistência se torna imunidade.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Telepatia', 'Você pode se comunicar telepaticamente com qualquer criatura a até 9 metros de você. Você precisa compartilhar um idioma com a criatura para que ela entenda suas comunicações telepáticas. Uma criatura sem telepatia pode receber e responder às suas mensagens, mas não pode iniciar ou encerrar a conversa.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Troca de Memória', 'Você tem a habilidade de mostrar memórias a outras criaturas com apenas um toque. A menos que a criatura seja voluntária, você deve fazer um teste de Carisma com CD 12 + o modificador de Inteligência do alvo. O alvo pode ver e memorizar completamente as memórias de outras pessoas.', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Memória Perfeita', 'O uso contínuo de sua habilidade de troca de memória, através de extensas gerações, concedeu aos valdekeanos a capacidade de se lembrar de qualquer coisa que já tenha acontecido em suas vidas com detalhes perfeitos.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Magia Profunda', 'Você conhece a magia Mind Sliver. A partir do 3º nível, você pode conjurar Sussurros Dissonantes com este traço; a partir do 5º nível, também Detectar Pensamentos. Você pode usar este traço para conjurar essas magias um número de vezes igual ao seu bônus de proficiência, recuperando os usos ao finalizar um descanso longo (ou usando espaços de magia do nível apropriado, se os tiver). Inteligência, Sabedoria ou Carisma é sua habilidade de conjuração para essas magias (escolhida quando você seleciona esta raça). Nenhuma delas requer componentes materiais quando conjurada com este traço.', 'multiplos_usos', 5),
    ((SELECT id FROM racas WHERE slug = 'valdekeano'), 'Precisão Incansável', 'Você possui proficiência em uma das seguintes perícias à sua escolha: Arcanismo, Atuação, História, Investigação, Medicina ou Prestidigitação. Você também possui proficiência com uma ferramenta à sua escolha. Sempre que fizer um teste de habilidade com a perícia ou ferramenta escolhida, role um d4 e some o número obtido ao total do teste.', 'passiva', 6);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'valdekeano'), 1.80, 1.90, 2.00);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'valdekeano'), 90, 90, 90);
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida) VALUES ((SELECT id FROM racas WHERE slug = 'valdekeano'), 40, 275);


-- ===== WARFORGED (base compartilhada: Constituição +2, tamanho médio, Construto Vivo, Descanso dos Sem
-- Sono, Anatomia Artificial, Proteção Integrada — sem envelhecimento, por isso sem raca_idade) =====

-- Warforged Servo
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'warforged-servo', 'Warforged Servo', 'mistica', 9, 'medio', NULL,
    'Comum e dois idiomas adicionais à escolha',
    NULL,
    'A tecnologia usada para criar os warforged começou com os métodos usados para criar constructos sem mente; embora a verdadeira senciência fosse um objetivo, pouco se pensou sobre os efeitos dessa senciência ou como melhor preparar essas mentes para sua nova existência. No momento de seu primeiro despertar, um warforged não tem conhecimento do mundo, nem compreensão de falsidade, nem sentimentos sobre o bem ou o mal. Um Warforged Servo foi moldado para ser versátil, auxiliando seus companheiros nas mais diversas tarefas.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), NULL, 1, 2, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Construto Vivo', 'Você é imune à condição envenenado e a doenças não-mágicas, além de ter resistência a dano de veneno. Você não precisa comer, beber, dormir ou respirar, e não tem olfato, mas pode se beneficiar de itens consumíveis normalmente. Você pode ser afetado por magias e habilidades que afetem criaturas do tipo constructo ou humanoide. Como um constructo vivo, você só recupera metade dos pontos de vida normalmente restaurados por magias de cura (mínimo de 1), e trata todos os níveis de exaustão como sendo um a menos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Descanso dos Sem Sono', 'Você não dorme e não pode ser forçado a dormir por qualquer meio. Para obter os benefícios de um descanso longo, você pode passar todas as 8 horas fazendo atividade leve, como se reparar e vigiar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Anatomia Artificial', 'Você não recupera pontos de vida automaticamente ao final de um descanso longo. Você começa com um "kit de reparo warforged" (um conjunto de ferramentas de artesão projetado para repará-lo) que pode ser usado para recuperar todos os seus pontos de vida, ou gastar Dados de Vida durante um descanso curto. As ferramentas de joalheiro, pedreiro, ferreiro ou consertador podem ser usadas no lugar do kit completo, com metade da recuperação normal (arredondado para cima). Você é proficiente com o kit de reparo warforged e começa com um.', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Proteção Integrada', 'Seu corpo foi construído com camadas de proteção que determinam sua Classe de Armadura. Você não ganha benefício por usar armaduras, mas se utilizar um escudo, aplica seu bônus na CA normalmente. Toda vez que finalizar um descanso longo, escolha um modo de proteção, desde que possua os pré-requisitos: Núcleo de Madeira Negra (sem pré-requisito; CA 11 + modificador de Destreza, +bônus de proficiência se proficiente com armadura leve); Composto de Chapas (requer proficiência em armaduras leves; CA 13 + modificador de Destreza [máx. 2] + bônus de proficiência, com desvantagem em Destreza (Furtividade)); Chapas Pesadas (requer proficiência em armaduras pesadas; CA 16 + bônus de proficiência, com desvantagem em Destreza (Furtividade)).', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Design Especializado', 'Você foi criado para ser multifuncional e versátil. Você ganha proficiência em uma perícia, proficiência com uma ferramenta (como kit de herbalismo, ferramentas de ferreiro ou instrumentos musicais), e fluência em um idioma adicional de sua escolha.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Mestre da Assistência', 'Você é um especialista em ajudar os outros. Quando você usa a ação de Ajudar, a criatura que você ajuda ganha um bônus adicional igual ao seu bônus de proficiência na rolagem de ataque ou teste de habilidade beneficiado.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Ferramentas Integradas', 'Escolha uma ferramenta em que você tenha proficiência. Você pode usá-la sem precisar segurá-la, pois ela é integrada ao seu corpo, e dobra o bônus de proficiência para testes feitos com ela.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 'Modo de Serviço', 'Quando você realiza um descanso curto, pode realizar uma tarefa utilitária ao mesmo tempo, como consertar equipamentos, cozinhar, ou preparar uma armadilha, sem perder os benefícios do descanso.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 2.0, 2.0, 2.0);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-servo'), 300, 300, 300);

-- Warforged Colosso
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'warforged-colosso', 'Warforged Colosso', 'mistica', 9, 'medio', NULL,
    'Comum',
    NULL,
    'A tecnologia usada para criar os warforged começou com os métodos usados para criar constructos sem mente; verdadeiros soldados ideais para o campo de batalha. Um Warforged Colosso foi moldado como uma máquina de guerra maciça e praticamente inamovível, capaz de resistir a golpes que derrubariam qualquer outro soldado.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'forca', 2, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Construto Vivo', 'Você é imune à condição envenenado e a doenças não-mágicas, além de ter resistência a dano de veneno. Você não precisa comer, beber, dormir ou respirar, e não tem olfato, mas pode se beneficiar de itens consumíveis normalmente. Como um constructo vivo, você só recupera metade dos pontos de vida normalmente restaurados por magias de cura (mínimo de 1), e trata todos os níveis de exaustão como sendo um a menos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Descanso dos Sem Sono', 'Você não dorme e não pode ser forçado a dormir por qualquer meio. Para obter os benefícios de um descanso longo, você pode passar todas as 8 horas fazendo atividade leve, como se reparar e vigiar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Anatomia Artificial', 'Você não recupera pontos de vida automaticamente ao final de um descanso longo. Você começa com um "kit de reparo warforged" que pode ser usado para recuperar todos os seus pontos de vida, ou gastar Dados de Vida durante um descanso curto. Ferramentas de joalheiro, pedreiro, ferreiro ou consertador podem ser usadas no lugar, com metade da recuperação normal (arredondado para cima).', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Proteção Integrada', 'Seu corpo foi construído com camadas de proteção que determinam sua Classe de Armadura. Você não ganha benefício por usar armaduras, mas se utilizar um escudo, aplica seu bônus na CA normalmente. Toda vez que finalizar um descanso longo, escolha um modo de proteção, desde que possua os pré-requisitos: Núcleo de Madeira Negra (sem pré-requisito; CA 11 + Destreza, +proficiência se proficiente com armadura leve); Composto de Chapas (proficiência em armaduras leves; CA 13 + Destreza [máx. 2] + proficiência, desvantagem em Furtividade); Chapas Pesadas (proficiência em armaduras pesadas; CA 16 + proficiência, desvantagem em Furtividade).', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Corpo de Colosso', 'Seu máximo de pontos de vida aumenta em 1. A cada novo nível, recebe uma quantidade de vida adicional igual à metade do seu bônus de proficiência arredondado para baixo (mínimo 1).', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Corpo Pesado', 'Seu peso massivo o torna quase inamovível. Você tem vantagem em testes e resistências para evitar ser empurrado, derrubado ou deslocado contra sua vontade. Além disso, quando você sofre dano de queda, reduz o dano pela metade.', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Construção Poderosa', 'Você conta como uma categoria de tamanho acima para determinar sua capacidade de carga.', 'passiva', 6),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Construção Sólida', 'Graças à sua integridade estrutural, você pode avançar incansavelmente em batalhas que derrubariam até o mais firme dos soldados. No início de cada um dos seus turnos, você ganha pontos de vida temporários iguais ao seu bônus de proficiência, se tiver pelo menos 1 ponto de vida.', 'passiva', 7),
    ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 'Corpo Resiliente', 'Sua construção robusta e mágica reduz todo dano Cortante, Perfurante e Contundente em um valor igual ao seu bônus de proficiência. Essa redução se aplica antes de qualquer resistência ao dano.', 'passiva', 8);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 2.0, 2.0, 2.0);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-colosso'), 300, 300, 300);

-- Warforged Sentinela
INSERT INTO racas (slug, nome, categoria, deslocamento, tamanho, quote, idiomas, anatomia, aparencia, nomes_raciais, tracos_culturais)
VALUES (
    'warforged-sentinela', 'Warforged Sentinela', 'mistica', 9, 'medio', NULL,
    'Comum',
    NULL,
    'A tecnologia usada para criar os warforged começou com os métodos usados para criar constructos sem mente; verdadeiros soldados ideais para o campo de batalha. Um Warforged Sentinela foi moldado para vigiar e proteger, equipado com um escudo integrado ao próprio corpo e reflexos afiados para interceptar ameaças antes que atinjam seus aliados.',
    NULL, NULL
);
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'constituicao', 2, NULL, 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'destreza', 2, NULL, 1);
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem) VALUES
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Construto Vivo', 'Você é imune à condição envenenado e a doenças não-mágicas, além de ter resistência a dano de veneno. Você não precisa comer, beber, dormir ou respirar, e não tem olfato, mas pode se beneficiar de itens consumíveis normalmente. Como um constructo vivo, você só recupera metade dos pontos de vida normalmente restaurados por magias de cura (mínimo de 1), e trata todos os níveis de exaustão como sendo um a menos.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Descanso dos Sem Sono', 'Você não dorme e não pode ser forçado a dormir por qualquer meio. Para obter os benefícios de um descanso longo, você pode passar todas as 8 horas fazendo atividade leve, como se reparar e vigiar.', 'passiva', 1),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Anatomia Artificial', 'Você não recupera pontos de vida automaticamente ao final de um descanso longo. Você começa com um "kit de reparo warforged" que pode ser usado para recuperar todos os seus pontos de vida, ou gastar Dados de Vida durante um descanso curto. Ferramentas de joalheiro, pedreiro, ferreiro ou consertador podem ser usadas no lugar, com metade da recuperação normal (arredondado para cima).', 'passiva', 2),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Proteção Integrada', 'Seu corpo foi construído com camadas de proteção que determinam sua Classe de Armadura. Você não ganha benefício por usar armaduras, mas se utilizar um escudo, aplica seu bônus na CA normalmente. Toda vez que finalizar um descanso longo, escolha um modo de proteção, desde que possua os pré-requisitos: Núcleo de Madeira Negra (sem pré-requisito; CA 11 + Destreza, +proficiência se proficiente com armadura leve); Composto de Chapas (proficiência em armaduras leves; CA 13 + Destreza [máx. 2] + proficiência, desvantagem em Furtividade); Chapas Pesadas (proficiência em armaduras pesadas; CA 16 + proficiência, desvantagem em Furtividade).', 'passiva', 3),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Vigilância', 'Você tem vantagem em testes de Sabedoria (Percepção) relacionados à detecção de perigos.', 'passiva', 4),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Escudo Integrado', 'Você possui um escudo especial embutido. Com uma ação bônus, você pode integrá-lo a uma de suas mãos, concedendo um bônus adicional de +1 à sua CA além do bônus normal de escudos. Você também pode usá-lo como arma corpo a corpo, causando 1d6 de dano contundente; sempre que atingir uma criatura com o escudo, pode empurrá-la 1,5 metro para trás (se o tamanho dela for igual ou menor que o seu).', 'passiva', 5),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Proteção Instintiva', 'Uma vez por descanso curto, você pode usar sua reação para interpor seu escudo entre um aliado dentro de 1,5 metro e um ataque que ele sofreu. O aliado recebe um bônus de +2 na CA contra esse ataque.', 'uso_unico', 6),
    ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 'Resistência à Magia', 'Você tem vantagem em todos os testes de resistência contra magia que envolvam Inteligência, Sabedoria e Carisma.', 'passiva', 7);
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 2.0, 2.0, 2.0);
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior) VALUES ((SELECT id FROM racas WHERE slug = 'warforged-sentinela'), 300, 300, 300);
