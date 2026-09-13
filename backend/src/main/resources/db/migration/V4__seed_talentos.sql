-- Seed do compêndio de Talentos (comuns) — 57 talentos, texto colado diretamente
-- pelo usuário (mesma origem dos dados de Raças: colado no chat, não extraído de PDF).
--
-- Convenção de pré-requisito (só existe UMA coluna de atributo fixo no schema):
--   - Todo pré-requisito vira uma linha "Pré-requisito: ..." em texto livre no início
--     da descrição, sempre.
--   - Quando o pré-requisito é um ÚNICO atributo fixo (ex.: "Destreza 13 ou maior"),
--     ele TAMBÉM é espelhado em atributo_requerido/valor_minimo_atributo_requerido,
--     pra exibição estruturada.
--   - Pré-requisitos de proficiência (ex.: "Proficiência com escudos"), de
--     característica (ex.: "Habilidade de Conjuração") ou de "atributo X OU Y"
--     (ex.: "Inteligência ou Sabedoria 13 ou maior") ficam só em texto — o schema
--     não tem como representá-los de forma estruturada.
--
-- Convenção de "+1 em um de N atributos nomeados" (ex.: "Força ou Destreza"):
--   mesmo caso já resolvido em raca_atributos — o schema só suporta atributo fixo OU
--   escolha livre entre N atributos quaisquer (quantidade_escolhas). Usa-se a escolha
--   livre (atributo = NULL, quantidade_escolhas = 1) como simplificação deliberada,
--   mais ampla que o par/trio nomeado da fonte. Isso se repete na maioria dos
--   talentos abaixo, por isso a nota fica só aqui em vez de repetida em cada um.

DELETE FROM talento_atributos;
DELETE FROM talentos;

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-elemental', 'Adepto Elemental', '🔥', 'Quando você ganha esse talento, escolha um dos tipos de dano a seguir: ácido, elétrico, fogo, frio ou trovão.

Benefícios:
- Suas magias ignoram resistência a dano do tipo escolhido.
- Ao rolar dano de uma magia sua desse tipo, pode refazer qualquer rolagem de 1.
- Pode ser escolhido diversas vezes; a cada vez, escolha um tipo diferente de dano.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-marcial', 'Adepto Marcial', '⚔️', 'Você tem treinamento marcial que permite realizar manobras de combate especiais.

Benefícios:
- Aprende duas manobras à sua escolha da lista do arquétipo Mestre de Batalha do guerreiro. CD de resistência das manobras = 8 + bônus de proficiência + mod. de Força ou Destreza (à sua escolha).
- Ganha um dado de superioridade d6 (ou mais um, se já possuir um). Recupera dados gastos ao terminar um descanso curto ou longo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-metamagico', 'Adepto Metamágico', '✨', 'Você aprendeu a exercer sua vontade sobre suas magias para mudar a forma como elas funcionam.

Benefícios:
- Aprende duas opções de Metamagia da lista do feiticeiro; só pode usar uma por magia, a menos que a opção diga o contrário.
- Ao alcançar um nível que conceda Aumento no Valor de Atributo, pode trocar uma dessas opções por outra da lista do feiticeiro.
- Ganha 2 pontos de feitiçaria para gastar com Metamagia; recupera todos ao terminar um descanso longo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('adepto-mistico', 'Adepto Místico', '🌙', 'Pré-requisito: Habilidade de Conjuração ou Característica de Magia de Pacto.

Estudando os conhecimentos de ocultismo, você desbloqueou o poder místico dentro de si mesmo.

Benefícios:
- Aprende uma Invocação Mística da classe do bruxo à sua escolha; se ela tiver requisito, só pode escolhê-la sendo um bruxo que o cumpra.
- Sempre que adquire um nível de personagem, pode trocar essa invocação por outra da lista do bruxo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('alerta', 'Alerta', '👁️', 'Sempre à espera de perigo, você ganha os seguintes benefícios:

Benefícios:
- Você recebe +5 de bônus em iniciativa.
- Você não pode ser surpreendido enquanto estiver consciente.
- Outras criaturas não ganham vantagem nas jogadas de ataque contra você por não serem visíveis por você.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ambidestro', 'Ambidestro', '🗡️', 'Você dominou o estilo de luta com duas armas.

Benefícios:
- Você ganha +1 de bônus na CA enquanto estiver empunhando uma arma corpo a corpo em cada mão.
- Pode usar Combater com Duas Armas mesmo que a arma de uma mão que estiver empunhando não seja leve.
- Pode sacar ou guardar duas armas de uma mão de uma só vez, quando normalmente só poderia uma.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atacante-bestial', 'Atacante Bestial', '🐾', 'Benefícios:
- Quando você rolar o dano para um ataque corpo a corpo com arma, pode jogar novamente o dado de dano da arma e usar qualquer dos valores.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atirador-aguçado', 'Atirador Aguçado', '🏹', 'Você dominou o uso de armas à distância e pode realizar tiros que seriam impossíveis para outros.

Benefícios:
- Atacar um alvo além da distância normal não impõe desvantagem nas suas jogadas de ataque com armas à distância.
- Seus ataques com armas à distância ignoram meia-cobertura e três-quartos de cobertura.
- Antes de atacar com uma arma à distância na qual seja proficiente, pode sofrer –5 de penalidade na jogada de ataque; se acertar, adiciona +10 no dano.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atirador-magia', 'Atirador de Magia', '⚡', 'Você aprendeu técnicas para aprimorar seus ataques com certos tipos de magia.

Benefícios:
- Quando conjurar uma magia que exige jogada de ataque, o alcance da magia é dobrado.
- Seus ataques à distância com magia ignoram meia-cobertura e três-quartos de cobertura.
- Aprende um truque que requer jogada de ataque, da lista de bardo, bruxo, clérigo, druida, feiticeiro ou mago. O atributo de conjuração depende da lista escolhida: Carisma (bardo, bruxo, feiticeiro), Sabedoria (clérigo, druida) ou Inteligência (mago).', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('atleta', 'Atleta', '🏃', 'Você passou por extenso treinamento físico.

Benefícios:
- Aumente seu valor de Força ou Destreza em 1, até o máximo de 20.
- Quando estiver caído, se levantar custa apenas 1,5 m de deslocamento.
- Escalar não custa deslocamento adicional.
- Pode realizar um salto em distância ou em altura correndo se movendo apenas 1,5 m, em vez de 3 m.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'atleta'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('ator', 'Ator', '🎭', 'Perito em mímica e dramaturgia.

Benefícios:
- Aumente seu valor de Carisma em 1, até o máximo de 20.
- Vantagem em Carisma (Atuação) e Carisma (Enganação) ao se passar por outra pessoa.
- Pode imitar a articulação ou os sons de outra criatura que tenha ouvido por pelo menos 1 minuto; um sucesso em Sabedoria (Intuição) resistido pela sua Carisma (Enganação) revela o embuste.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'ator'), 'carisma', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('chef', 'Chef', '🍖', 'O tempo gasto se especializando na arte culinária valeu a pena.

Benefícios:
- Aumente seu valor de Constituição ou Sabedoria em 1, até o máximo de 20.
- Proficiência com Utensílios de Cozinheiro. Descanso curto: pode cozinhar para 4 + bônus de proficiência criaturas; quem gastar Dado de Vida para curar recupera 1d8 PV adicionais.
- 1 hora de trabalho ou descanso longo: cria aperitivos em quantidade igual ao bônus de proficiência, válidos por 8h; ação bônus para comer um e ganhar PV temporários iguais ao bônus de proficiência.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'chef'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('combatente-montado', 'Combatente Montado', '🐴', 'Você é um oponente perigoso quando montado. Enquanto estiver montado e não incapacitado:

Benefícios:
- Vantagem nas jogadas de ataque corpo a corpo contra qualquer criatura desmontada menor que sua montaria.
- Pode forçar que um ataque direcionado à sua montaria seja direcionado a você.
- Se sua montaria for alvo de efeito com teste de resistência de Destreza para metade do dano, ela não sofre dano nenhum se passar, e apenas metade se falhar.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('conjurador-guerra', 'Conjurador de Guerra', '⚔️', 'Você praticou a conjuração de magias no meio do combate.

Benefícios:
- Vantagem em testes de resistência de Constituição para manter concentração ao sofrer dano.
- Pode realizar componentes somáticos de uma magia mesmo com armas ou escudo em uma ou ambas as mãos.
- Quando o movimento de uma criatura hostil provocaria um ataque de oportunidade seu, pode usar sua reação para conjurar uma magia (tempo de conjuração de 1 ação, alvo único) nela em vez de atacar.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('conjurador-ritual', 'Conjurador de Ritual', '📜', 'Pré-requisito: Inteligência ou Sabedoria 13 ou maior.

Você aprendeu magias que pode conjurar como rituais, escritas em um livro de rituais que deve estar em suas mãos ao conjurá-las.

Benefícios:
- Ao escolher esse talento, recebe um livro de rituais com duas magias de 1º nível de uma classe escolhida (bardo, bruxo, clérigo, druida, feiticeiro ou mago), ambas com o descritor ritual. A classe escolhida define o atributo de conjuração: Carisma (bardo, bruxo, feiticeiro), Sabedoria (clérigo, druida) ou Inteligência (mago).
- Pode adicionar magias rituais encontradas por escrito ao livro, desde que estejam na lista da classe escolhida e tenham nível ≤ metade do seu nível (arred. para cima); custa 2h + 50 po por nível da magia.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('curandeiro', 'Curandeiro', '⚕️', 'Você é um cirurgião capacitado, permitindo tratar de ferimentos rapidamente.

Benefícios:
- Quando usa um kit de primeiros-socorros para estabilizar uma criatura morrendo, ela recupera 1 ponto de vida.
- Ação: gasta um uso do kit para tratar uma criatura e restaurar 1d6 + 4 PV, mais uma quantidade adicional igual ao total de Dados de Vida da criatura. Uma criatura só se beneficia disso de novo após um descanso curto ou longo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('duelista-defensivo', 'Duelista Defensivo', '🤺', 'Pré-requisito: Destreza 13 ou maior.

Benefícios:
- Enquanto empunhar uma arma de acuidade na qual seja proficiente, ao ser atingido por um ataque corpo a corpo, pode usar sua reação para adicionar seu bônus de proficiência à CA contra esse ataque, potencialmente fazendo-o errar.', 'destreza', 13);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('envenenador', 'Envenenador', '🧪', 'Você pode preparar e transmitir venenos mortais.

Benefícios:
- Dano venenoso causado por você ignora resistências a esse tipo de dano.
- Pode aplicar veneno em uma arma ou munição com uma ação bônus, em vez de uma ação. Proficiência com kit de envenenador (se ainda não tiver).
- Com 1h de trabalho e 50 po em materiais, cria doses de veneno potente em quantidade igual ao seu bônus de proficiência. Uma vez aplicado, o veneno mantém potência por 1 minuto ou até um acerto; a criatura atingida deve ser bem-sucedida em Constituição CD 14 ou sofre 2d8 de dano venenoso e fica envenenada até o fim do seu próximo turno.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('esmagador', 'Esmagador', '🔨', 'Você se especializou na arte de esmagar os inimigos.

Benefícios:
- Aumente seu valor de Força ou Constituição em 1, até o máximo de 20.
- Uma vez por turno, ao acertar um ataque de dano contundente, pode mover o alvo até 1,5 m para um espaço desocupado, desde que não seja mais de uma categoria de tamanho maior que você.
- Ao acertar um golpe crítico com dano contundente, os ataques seguintes contra essa criatura têm vantagem até o início do seu próximo turno.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'esmagador'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-besta', 'Especialista em Besta', '🔫', 'Graças a sua prática extensiva com bestas.

Benefícios:
- Ignora a qualidade de recarga de bestas nas quais é proficiente.
- Estar a 1,5 m de uma criatura hostil não impõe desvantagem nas suas jogadas de ataque à distância.
- Ao usar a ação de Ataque e atacar com uma arma de uma mão, pode usar ação bônus para atacar com uma besta de mão carregada que esteja empunhando.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especialista-briga', 'Especialista em Briga', '👊', 'Acostumado a brigas de bar usando qualquer coisa como arma, e na falta, os punhos.

Benefícios:
- Aumente o valor de Força ou Constituição em 1, até o máximo de 20.
- Seus ataques desarmados ou com armas improvisadas causam 1d4 de dano extra.
- Ao atingir uma criatura com ataque desarmado ou arma improvisada, pode usar ação bônus para tentar agarrá-la.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'especialista-briga'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('especializado-pericia', 'Especializado em Perícia', '🎯', 'Você aprimorou sua proficiência em uma perícia específica.

Benefícios:
- Aumenta o valor de um atributo à sua escolha em 1, até o máximo de 20.
- Adquire proficiência em uma perícia à sua escolha.
- Escolhe uma perícia na qual seja proficiente e ganha especialidade, dobrando o bônus de proficiência para testes relacionados a ela.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'especializado-pericia'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('explorador-cavernas', 'Explorador de Cavernas', '🗺️', 'Alerta às armadilhas escondidas e portas secretas encontradas em muitas masmorras.

Benefícios:
- Vantagem em Sabedoria (Percepção) e Inteligência (Investigação) para detectar portas secretas.
- Vantagem em testes de resistência para evitar ou resistir a armadilhas.
- Resistência a dano causado por armadilhas.
- Pode procurar armadilhas viajando em ritmo normal, em vez de metade do ritmo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('imobilizador', 'Imobilizador', '🪢', 'Pré-requisito: Força 13 ou maior.

Você desenvolveu a perícia necessária para prender alguém em combate engajado.

Benefícios:
- Vantagem nas jogadas de ataque contra uma criatura agarrada por você.
- Ação: tenta imobilizar uma criatura já agarrada realizando outro teste de agarrar; em sucesso, você e a criatura ficam ambos impedidos até o agarre terminar.', 'forca', 13);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-artifice', 'Iniciado Artífice', '⚙️', 'Você aprendeu habilidades dos artífices.

Benefícios:
- Aprende um truque e uma magia de 1º círculo da lista do artífice, à sua escolha, conjurados com Inteligência.
- Pode conjurar a magia de 1º círculo sem gastar espaço de magia uma vez após um descanso longo, além de poder usá-la com um espaço que possua.
- Proficiência com um tipo de ferramenta de artesão à sua escolha, utilizável como foco de conjuração para magias que usam Inteligência.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-combate', 'Iniciado em Combate', '🛡️', 'Pré-requisito: Força 13 ou maior.

Você desenvolveu um estilo de luta único.

Benefícios:
- Aumente o valor de Força ou Destreza em 1, até o máximo de 20.
- Aprende um Estilo de Luta à sua escolha da lista do guerreiro (deve ser diferente se já possuir um).
- Ao alcançar um nível que conceda Aumento no Valor de Atributo, pode trocar esse Estilo de Luta por outro da lista do guerreiro que não possua.', 'forca', 13);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'iniciado-combate'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('iniciado-magia', 'Iniciado em Magia', '📖', 'Benefícios:
- Escolha uma classe entre bardo, bruxo, clérigo, druida, feiticeiro ou mago; aprende dois truques da lista de magias dessa classe.
- Escolhe também uma magia de 1º nível da mesma lista; pode conjurá-la com o menor nível possível, mas precisa de um descanso longo para conjurá-la de novo por esse talento.
- O atributo de conjuração depende da classe escolhida: Carisma (bardo, bruxo, feiticeiro), Sabedoria (clérigo, druida) ou Inteligência (mago).', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('investida-poderosa', 'Investida Poderosa', '💨', 'Benefícios:
- Ao usar a ação de Disparada, pode usar ação bônus para realizar um ataque corpo a corpo com arma ou empurrar uma criatura.
- Se mover pelo menos 3 m em linha reta imediatamente antes dessa ação bônus, ganha +5 no dano do ataque (se acertar) ou empurra o alvo até 3 m (se for bem-sucedido).', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('lider-inspirador', 'Líder Inspirador', '👑', 'Pré-requisito: Carisma 13 ou maior.

Benefícios:
- Pode gastar 10 minutos inspirando até seis criaturas amigáveis (incluindo você) a até 9 m que possam ver, ouvir e compreender você. Cada uma ganha PV temporários iguais ao seu nível + mod. de Carisma. Uma criatura só se beneficia de novo após um descanso curto ou longo.', 'carisma', 13);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-arma-haste', 'Maestria em Arma de Haste', '🪄', 'Você consegue manter seus inimigos afastados utilizando armas de haste.

Benefícios:
- Ao atacar com uma glaive, alabarda ou bordão, pode usar ação bônus para atacar com a outra extremidade da arma (mesmo mod. de habilidade, d4 de dano de concussão).
- Enquanto empunhar uma glaive, alabarda, lança longa ou bastão, outras criaturas provocam ataque de oportunidade seu ao entrarem no seu alcance.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-armadura-media', 'Maestria em Armadura Média', '🛡️', 'Pré-requisito: Proficiência em armadura média.

Você praticou seus movimentos usando armaduras médias.

Benefícios:
- Vestir armadura média não impõe desvantagem em Destreza (Furtividade).
- Enquanto vestir armadura média, adiciona +3 (em vez de +2) à sua CA, se tiver Destreza 16 ou maior.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('maestria-armadura-pesada', 'Maestria em Armadura Pesada', '🛡️', 'Pré-requisito: Proficiência em armadura pesada.

Você pode usar sua armadura para se defender de ataques potencialmente fatais.

Benefícios:
- Aumente seu valor de Força em 1, até o máximo de 20.
- Enquanto vestir armadura pesada, dano de concussão, cortante e perfurante de ataques não-mágicos que receber é reduzido em 3.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'maestria-armadura-pesada'), 'forca', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('matador-conjuradores', 'Matador de Conjuradores', '🔮', 'Você praticou técnicas úteis em combate corpo a corpo contra conjuradores.

Benefícios:
- Quando uma criatura a até 1,5 m de você conjurar uma magia, pode usar sua reação para realizar um ataque corpo a corpo contra ela.
- Ao causar dano em uma criatura concentrada em uma magia, ela tem desvantagem no teste de resistência para manter a concentração.
- Vantagem em testes de resistência contra magias conjuradas por criaturas a até 1,5 m de você.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mente-afiada', 'Mente Afiada', '🧭', 'Você tem uma mente que cronometra o tempo e memoriza direção e detalhes com precisão absurda.

Benefícios:
- Aumente seu valor de Inteligência em 1, até o máximo de 20.
- Você sempre sabe qual é a direção do norte.
- Você sempre sabe o número de horas restantes para o próximo nascer ou pôr do sol.
- Pode relembrar, com precisão, qualquer coisa vista ou ouvida no último mês.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'mente-afiada'), 'inteligencia', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-armas', 'Mestre de Armas', '⚙️', 'Você tem praticado extensamente com uma variedade de armas.

Benefícios:
- Aumente o valor de Força ou Destreza em 1, até o máximo de 20.
- Ganha proficiência com quatro armas simples e marciais, à sua escolha.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'mestre-armas'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-armas-grandes', 'Mestre de Armas Grandes', '🪓', 'Você aprendeu a usar o peso das armas pesadas em sua vantagem.

Benefícios:
- No seu turno, ao acertar um golpe crítico com arma corpo a corpo ou reduzir os PV de uma criatura a 0, pode realizar um ataque corpo a corpo com arma usando uma ação bônus.
- Antes de atacar corpo a corpo com uma arma pesada na qual seja proficiente, pode sofrer –5 de penalidade na jogada de ataque; se acertar, adiciona +10 ao dano.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mestre-escudo', 'Mestre de Escudo', '🛡️', 'Você não usa escudos apenas para proteção, mas também de forma ofensiva. Enquanto empunhar um escudo:

Benefícios:
- Ao realizar a ação de Ataque no seu turno, pode usar ação bônus para tentar empurrar uma criatura a até 1,5 m com seu escudo.
- Se não estiver incapacitado, pode adicionar o bônus de CA do escudo a qualquer teste de resistência de Destreza contra magia ou efeito nocivo que o tenha como alvo.
- Se for alvo de efeito com teste de resistência de Destreza para metade do dano, pode usar sua reação para não sofrer dano nenhum se passar no teste, interpondo o escudo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('mobilidade', 'Mobilidade', '💨', 'Você é excepcionalmente rápido e ágil.

Benefícios:
- Seu deslocamento aumenta em 3 metros.
- Ao usar a ação de Disparada, mover-se por terreno difícil não custa deslocamento adicional nesse turno.
- Ao realizar um ataque corpo a corpo contra uma criatura, não provoca ataque de oportunidade dela pelo resto do turno, independentemente de ter acertado.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('lacerador', 'Lacerador', '🗡️', 'Você aprendeu onde cortar para obter os melhores resultados.

Benefícios:
- Aumenta seu valor de Força ou Destreza em 1, até o máximo de 20.
- Uma vez por turno, ao acertar dano cortante, pode reduzir o deslocamento do alvo em 3 m até o início do seu próximo turno.
- Ao acertar um golpe crítico com dano cortante, a criatura sofre desvantagem em jogadas de ataque até o início do seu próximo turno.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'lacerador'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('observador', 'Observador', '🔍', 'Rápido em perceber os detalhes do ambiente.

Benefícios:
- Aumente seu valor de Inteligência ou Sabedoria em 1, até o máximo de 20.
- Se puder ver a boca de uma criatura falando um idioma que compreenda, pode interpretar o que ela diz lendo os lábios.
- +5 de bônus nos seus valores passivos de Sabedoria (Percepção) e Inteligência (Investigação).', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'observador'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('perfurador', 'Perfurador', '🗡️', 'Você alcançou precisão em perfurações durante o combate.

Benefícios:
- Aumenta seu valor de Força ou Destreza em 1, até o máximo de 20.
- Uma vez por turno, ao acertar dano perfurante, pode rolar novamente um dos dados de dano do ataque e escolher o resultado.
- Ao acertar um golpe crítico com dano perfurante, pode rolar um dado de dano adicional.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'perfurador'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('perito', 'Perito', '📚', 'Benefícios:
- Ganha proficiência em qualquer combinação de três perícias ou ferramentas, à sua escolha.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('pistoleiro', 'Pistoleiro', '🔫', 'Você é ágil e preciso ao usar armas de fogo.

Benefícios:
- Aumenta seu valor de Destreza em 1, até o máximo de 20.
- Adquire proficiência com armas de fogo.
- Ignora as propriedades de recarga e de mira de armas de fogo.
- Não sofre desvantagem em ataques à distância a 1,5 m de uma criatura hostil.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'pistoleiro'), 'destreza', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('poliglota', 'Poliglota', '🗣️', 'Você estudou línguas e códigos.

Benefícios:
- Aumente seu valor de Inteligência em 1, até o máximo de 20.
- Aprende três idiomas à sua escolha.
- Pode criar criptogramas escritos; outros só os decifram se você ensinar, forem bem-sucedidos em um teste de Inteligência (CD = seu valor de Inteligência + bônus de proficiência) ou usarem magia.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'poliglota'), 'inteligencia', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('protecao-leve', 'Proteção Leve', '🛡️', 'Você treinou até dominar o uso de armaduras leves.

Benefícios:
- Aumente seu valor de Força ou Destreza em 1, até o máximo de 20.
- Ganha proficiência com armaduras leves.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'protecao-leve'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('protecao-moderada', 'Proteção Moderada', '🛡️', 'Pré-requisito: Proficiência em armadura leve.

Você treinou até dominar o uso de armaduras médias e escudos.

Benefícios:
- Aumente seu valor de Força ou Destreza em 1, até o máximo de 20.
- Ganha proficiência com armadura média e escudos.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'protecao-moderada'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('protecao-pesada', 'Proteção Pesada', '🛡️', 'Pré-requisito: Proficiência em armadura média.

Você treinou até dominar o uso de armaduras pesadas.

Benefícios:
- Aumente seu valor de Força em 1, até o máximo de 20.
- Ganha proficiência com armadura pesada.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'protecao-pesada'), 'forca', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('protetor', 'Protetor', '🛡️', 'Pré-requisitos: Constituição 13 ou superior, Proficiência com escudos.

Você é um companheiro de equipe atencioso e disposto a se colocar em risco pelos outros.

Benefícios:
- Aumente seu valor de Constituição em 1, até o máximo de 20.
- Reação: corre na frente de um ataque à distância ou corpo a corpo mirando um aliado dentro do seu deslocamento, forçando o atacante a rolar contra a sua CA (você sofre o dano normalmente). Usos = mod. de Destreza; recupera após descanso curto ou longo.', 'constituicao', 13);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'protetor'), 'constituicao', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('resiliente', 'Resiliente', '💠', 'Escolha um valor de habilidade.

Benefícios:
- Aumente o valor de habilidade escolhido em 1, até o máximo de 20.
- Ganha proficiência em testes de resistência usando essa habilidade.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'resiliente'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('resistente', 'Resistente', '🪨', 'Duro e resistente.

Benefícios:
- Aumente seu valor de Constituição em 1, até o máximo de 20.
- Ao rolar um Dado de Vida para recuperar PV, o valor mínimo recuperado é igual a duas vezes o seu mod. de Constituição (mínimo 2).', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'resistente'), 'constituicao', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('robusto', 'Robusto', '❤️', 'Benefícios:
- Aumente o valor de Constituição em 1, até o máximo de 20.
- Seu máximo de pontos de vida aumenta em um valor igual a três vezes seu nível ao adquirir esse talento; a cada nível seguinte, aumenta mais 3.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'robusto'), 'constituicao', 1, NULL, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sentinela', 'Sentinela', '🗡️', 'Você domina técnicas para tirar vantagem sempre que um inimigo baixa a guarda.

Benefícios:
- Ao acertar uma criatura com ataque de oportunidade, o deslocamento dela se torna 0 pelo resto do turno.
- Criaturas provocam ataque de oportunidade seu mesmo ao usar Desengajar antes de sair do seu alcance.
- Quando uma criatura a até 1,5 m de você ataca um alvo diferente de você (sem esse talento), pode usar sua reação para atacá-la corpo a corpo.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sorrateiro', 'Sorrateiro', '🌑', 'Pré-requisito: Destreza 13 ou maior.

Você é especialista em espreitar através das sombras.

Benefícios:
- Pode tentar se esconder quando estiver levemente obscurecido para a criatura de quem tenta se esconder.
- Ao estar escondido de uma criatura e errar um ataque à distância contra ela, isso não revela sua posição.
- Penumbra não impõe desvantagem nos seus testes de Sabedoria (Percepção) relacionados à visão.', 'destreza', 13);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('sortudo', 'Sortudo', '🍀', 'Você tem uma sorte inexplicável que parece surgir nos momentos exatos.

Benefícios:
- Tem 3 pontos de sorte, recuperados ao terminar um descanso longo.
- Pode gastar 1 ponto para rolar um d20 adicional em uma jogada de ataque, teste de habilidade ou resistência — inclusive depois de rolar, antes de saber o resultado — e escolher qual usar.
- Também pode gastar um ponto quando um ataque for feito contra você, rolando um d20 e escolhendo se o ataque usa a jogada do atacante ou a sua.
- Se mais de uma criatura gastar um ponto de sorte na mesma jogada, os pontos se cancelam mutuamente.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('telepatico', 'Telepático', '🧠', 'Você despertou a habilidade de se conectar mentalmente.

Benefícios:
- Aumenta seu valor de Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.
- Pode falar telepaticamente com criaturas à vista até 18 m, em um idioma conhecido — só compreende quem conhece o idioma, e ela não pode responder telepaticamente.
- Pode conjurar Detectar Pensamentos sem espaço de magia ou componentes, usando o atributo escolhido por este talento.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'telepatico'), NULL, 1, 1, 0);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('tita-ataque', 'Titã de Ataque', '💪', 'Você provou ser uma grande e imparável força no campo de batalha; seus inimigos suam ao vê-lo se aproximar.

Benefícios:
- Pode ignorar a propriedade de duas mãos de armas pesadas.
- Se mover pelo menos 3 m antes de atacar, pode rolar o dano da arma duas vezes e ficar com o melhor resultado.
- Ao acertar uma criatura, seu próximo ataque contra outra criatura a até 3 m da primeira ganha bônus no dano igual ao seu nível de personagem.', NULL, NULL);

INSERT INTO talentos (slug, nome, icone, descricao, atributo_requerido, valor_minimo_atributo_requerido)
VALUES ('tocado-sombras', 'Tocado pelas Sombras', '🌑', 'Sua exposição à magia sombria o modificou.

Benefícios:
- Aumenta seu valor de Inteligência, Sabedoria ou Carisma em 1, até o máximo de 20.
- Aprende a magia Invisibilidade e mais uma magia de 1º círculo das escolas de Ilusão ou Necromancia. Pode conjurá-las sem gastar espaço de magia, mas precisa de um descanso longo para conjurá-las de novo assim.', NULL, NULL);
INSERT INTO talento_atributos (talento_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos WHERE slug = 'tocado-sombras'), NULL, 1, 1, 0);

-- ===== Seed de demonstração: talentos raciais =====
-- Diferente do talento normal, aqui raça e nível mínimo são sempre obrigatórios
-- (não há pré-requisito de atributo). Só há 'humano' seedado em racas por enquanto,
-- então os dois exemplos abaixo usam essa raça.

DELETE FROM talento_racial_atributos;
DELETE FROM talentos_raciais;

INSERT INTO talentos_raciais (slug, nome, icone, descricao, raca_id, nivel_minimo)
VALUES (
    'sangue-de-tatanea',
    'Sangue de Tatânea',
    '🩸',
    'Reservado a quem nasceu sob o teto do templo, esse talento é a marca de quem já sobreviveu ao próprio corpo mais de uma vez.

Benefícios:
- Você ganha resistência a dano de veneno e vantagem em testes de resistência contra doenças.
- Uma vez por descanso longo, pode estabilizar automaticamente ao cair a 0 pontos de vida.',
    (SELECT id FROM racas WHERE slug = 'humano'),
    1
);

-- Bônus de atributo do talento acima: exercita o caso "fixo".
INSERT INTO talento_racial_atributos (talento_racial_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos_raciais WHERE slug = 'sangue-de-tatanea'), 'sabedoria', 1, NULL, 0);

-- Segundo talento racial de demonstração: exercita o bônus "à escolha" e um
-- nível mínimo mais alto, caso que o exemplo acima não usa.
INSERT INTO talentos_raciais (slug, nome, icone, descricao, raca_id, nivel_minimo)
VALUES (
    'instinto-do-templo',
    'Instinto do Templo',
    '🦉',
    'Quem cresce entre os totens do templo aprende a ler seus sinais antes mesmo de entender por quê.

Benefícios:
- Vantagem em testes de resistência contra ser Amedrontado enquanto estiver a até 9 m de uma estrutura do templo.
- Uma vez por descanso longo, pode repetir um teste de Sobrevivência ou Percepção falho.',
    (SELECT id FROM racas WHERE slug = 'humano'),
    5
);

INSERT INTO talento_racial_atributos (talento_racial_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM talentos_raciais WHERE slug = 'instinto-do-templo'), NULL, 1, 1, 0);
