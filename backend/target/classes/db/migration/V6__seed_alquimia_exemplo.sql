-- Substitua pelo script real de migração de ESSENCIAS e POCOES_DATA quando disponível.

INSERT INTO essencias (simbolo, nome, cor, cor_fundo, elemento) VALUES
('λ', 'Água', '#4ab0e8', 'rgba(74,176,232,.25)', 'Água'),
('Φ', 'Ar', '#c9d6e3', 'rgba(201,214,227,.25)', 'Ar'),
('Ω', 'Fogo', '#e8724a', 'rgba(232,114,74,.25)', 'Fogo'),
('ζ', 'Luz', '#f0d878', 'rgba(240,216,120,.25)', 'Positiva');

INSERT INTO pocoes (id, nome, raridade, icone, formula, duracao, nucleo, descricao, melhoria) VALUES
('pocao-cura', 'Poção de Cura', 'Comum', '❤️', 'ζ ζ', 'Instantânea',
 '1 maçã vermelha em perfeito estado.',
 'Restaura pontos de vida instantaneamente ao ser consumida.',
 'A cada ζ adicional, aumenta a cura em 1d4.');
