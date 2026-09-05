-- Dados de exemplo para desenvolvimento/teste local.
-- Substitua pelo script real de migração dos dados de RACAS_DATA quando disponível.

INSERT INTO racas (id, nome, categoria, tamanho, deslocamento, descricao) VALUES
('anao-rochoso', 'Anão Rochoso', 'global', 'medio', '7,5 m',
 'Descendentes das montanhas mais antigas de Cosmos Sombrio, resistentes e teimosos.');

INSERT INTO raca_tracos (raca_id, texto, ordem) VALUES
('anao-rochoso', 'Aumento de Constituição +2 (raça) +1 (sub-raça)', 0),
('anao-rochoso', 'Visão no escuro até 18 m', 1);

INSERT INTO raca_habilidades (raca_id, nome, descricao, ordem) VALUES
('anao-rochoso', 'Visão Sísmica', 'Pode sentir vibrações no solo em um raio de 9 m, mesmo sem visão direta.', 0);
