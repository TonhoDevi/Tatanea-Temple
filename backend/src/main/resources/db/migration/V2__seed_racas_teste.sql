-- Seed único de teste do compêndio de Raças remodelado.
-- Objetivo: exercitar toda a estrutura nova (atributo fixo x à escolha,
-- os 3 tipos de habilidade especial, e os blocos de altura/peso/idade)
-- com uma única raça, antes do trabalho no frontend.

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

-- Atributo à escolha: "+1 em quatro atributos à escolha"
INSERT INTO raca_atributos (raca_id, atributo, valor, quantidade_escolhas, ordem)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), NULL, 1, 4, 0);

-- Habilidades especiais — uma de cada tipo, pra cobrir os 3 casos
INSERT INTO raca_habilidade_especial (raca_id, nome, descricao, tipo, ordem)
VALUES
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Versatilidade',
     'Sempre proficiente em uma perícia adicional à sua escolha.', 'passiva', 0),
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Fôlego Extra',
     'Uma vez por descanso longo, pode gastar uma ação bônus para recuperar um dado de vida.', 'uso_unico', 1),
    ((SELECT id FROM racas WHERE slug = 'humano'), 'Determinação',
     'Pode adicionar +1 a um teste de resistência à sua escolha. Pode ser usada mais de uma vez por dia.', 'multiplos_usos', 2);

-- Altura (metros)
INSERT INTO raca_altura (raca_id, valor_menor, valor_medio, valor_maior)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 1.50, 1.75, 2.00);

-- Peso (kg)
INSERT INTO raca_peso (raca_id, valor_menor, valor_medio, valor_maior)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 45.00, 70.00, 110.00);

-- Idade (anos)
INSERT INTO raca_idade (raca_id, idade_adulta, expectativa_vida)
VALUES ((SELECT id FROM racas WHERE slug = 'humano'), 18, 90);
