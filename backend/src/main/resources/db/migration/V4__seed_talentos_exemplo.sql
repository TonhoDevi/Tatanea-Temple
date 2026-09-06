-- Substitua pelo script real de migração de TALENTOS_DATA quando disponível.

INSERT INTO talentos (id, nome, categoria, icone, prereq, descricao) VALUES
('adepto-marcial', 'Adepto Marcial', 'combate', '⚔️', NULL,
 'Seu treino em combate te tornou mais rápido a reagir a ameaças e mais preciso em seus ataques.');

INSERT INTO talento_beneficios (talento_id, texto, ordem) VALUES
('adepto-marcial', '+5 de bônus em iniciativa.', 0),
('adepto-marcial', 'Uma vez por turno, pode rerrolar um ataque corpo a corpo que erre.', 1);
