-- Dados reais migrados de CLASSES_DATA (js/compendium/data-classes.js)

INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, atributo_chave, armadura, armas, ferramentas, resistencias, pericias, descricao, dificuldade) VALUES ('ladino', 'Ladino', 'Versão Épico', '🗡️', '#4a7a8c', 'd6', 'Destreza', 'Armaduras leves', 'Armas simples, bestas de mão, espadas longas, rapieiras, espadas curtas', 'Ferramentas de ladrão', 'Destreza, Inteligência', 'Escolha quatro: Acrobacia, Atletismo, Atuação, Enganação, Furtividade, Intimidação, Intuição, Investigação, Percepção, Persuasão e Prestidigitação', 'Ladinos contam com perícia, furtividade e as vulnerabilidades dos inimigos para obter vantagem em qualquer situação. Mestres da astúcia, eles preferem um ataque preciso a uma barragem de força bruta.', 'Intermediário');
INSERT INTO classes (id, nome, subtitulo, icone, cor, dado_de_vida, atributo_chave, armadura, armas, ferramentas, resistencias, pericias, descricao, dificuldade) VALUES ('caçador', 'Caçador', 'Versão Épico', '🏹', '#4a8a5a', 'd10', 'Sabedoria', 'Leves, Médias e Escudos', 'Simples e Marciais', 'Nenhuma', 'Inteligência, Sabedoria', 'Escolha três: Acrobacia, Arcana, Atletismo, Furtividade, História, Percepção, Investigação, Religião e Sobrevivência', 'Guerreiros da natureza que rastreiam suas presas com maestria. Combinam habilidades de combate com magia natural para proteger as fronteiras da civilização.', 'Média');

INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Furtividade', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Suporte', 2);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('ladino', 'Exploração', 3);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Dano', 0);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Controle', 1);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Exploração', 2);
INSERT INTO classe_papeis (classe_id, papel, ordem) VALUES ('caçador', 'Sobrevivência', 3);

INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('ladino', 'Assassino', '💀', 'Arte da morte, veneno e disfarce', 0);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('ladino', 'Inquisidor', '🔍', 'Detecção de mentiras e combate intuitivo', 1);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('ladino', 'Ladrão', '🔑', 'Roubo, escalada e itens mágicos', 2);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('ladino', 'Saqueador', '🏹', 'Sobrevivência, emboscadas e mobilidade', 3);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('caçador', 'Exterminador Profano', '☠️', 'Magia negra, maldições e erradicação do mal', 0);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('caçador', 'Perseguidor do Horizonte', '🌀', 'Portais planares e caça interdimensional', 1);
INSERT INTO classe_subclasses (classe_id, nome, icone, descricao, ordem) VALUES ('caçador', 'Predador Primal', '🐾', 'Instinto ancestral e caça bruta', 2);

INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('ladino', 'Ataque Furtivo', 0);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('ladino', 'Ação Ardilosa', 1);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('ladino', 'Evasão', 2);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('ladino', 'Golpe de Sorte', 3);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('caçador', 'Marca do Caçador', 0);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('caçador', 'Território de Caça', 1);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('caçador', 'Conjuração', 2);
INSERT INTO classe_habilidades_destaque (classe_id, nome, ordem) VALUES ('caçador', 'Matador de Inimigos', 3);
