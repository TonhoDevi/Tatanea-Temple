-- ============================================================
-- Campos que faltavam para bater com a ficha real (ddt-character-sheet.html)
-- ============================================================
ALTER TABLE personagens ADD COLUMN antecedente VARCHAR(120);
ALTER TABLE personagens ADD COLUMN tendencia VARCHAR(60);
ALTER TABLE personagens ADD COLUMN ponto_heroico BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE personagens ADD COLUMN moeda_pc INT NOT NULL DEFAULT 0;
ALTER TABLE personagens ADD COLUMN moeda_pp INT NOT NULL DEFAULT 0;
ALTER TABLE personagens ADD COLUMN moeda_po INT NOT NULL DEFAULT 0;
ALTER TABLE personagens ADD COLUMN moeda_pe INT NOT NULL DEFAULT 0;
ALTER TABLE personagens ADD COLUMN moeda_pl INT NOT NULL DEFAULT 0;

ALTER TABLE personagens ADD COLUMN desloc_nadar VARCHAR(20);
ALTER TABLE personagens ADD COLUMN desloc_voar VARCHAR(20);
ALTER TABLE personagens ADD COLUMN desloc_escalar VARCHAR(20);
ALTER TABLE personagens ADD COLUMN salto VARCHAR(20);

ALTER TABLE personagens ADD COLUMN idiomas TEXT;
ALTER TABLE personagens ADD COLUMN historia TEXT;
ALTER TABLE personagens ADD COLUMN anotacoes TEXT;

-- ============================================================
-- Resistências e vulnerabilidades (tags unificadas, como no site atual)
-- ============================================================
CREATE TABLE personagem_tags (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    tipo           VARCHAR(20) NOT NULL,
    texto          VARCHAR(120) NOT NULL,
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_tags_personagem ON personagem_tags(personagem_id);
