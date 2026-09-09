CREATE TABLE classes (
    id              VARCHAR(64) PRIMARY KEY,
    nome            VARCHAR(120) NOT NULL,
    subtitulo       VARCHAR(160),
    icone           VARCHAR(16),
    cor             VARCHAR(16),
    dado_de_vida    VARCHAR(8) NOT NULL,
    atributo_chave  VARCHAR(60),
    armadura        VARCHAR(255),
    armas           VARCHAR(500),
    ferramentas     VARCHAR(255),
    resistencias    VARCHAR(255),
    -- VARCHAR com limite (não TEXT ilimitado): evita que um payload gigante
    -- vindo do cliente vire uma negação de serviço no banco.
    pericias        VARCHAR(5000),
    descricao       VARCHAR(5000),
    dificuldade     VARCHAR(40)
);

CREATE TABLE classe_papeis (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id  VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    papel      VARCHAR(60) NOT NULL,
    ordem      INT NOT NULL DEFAULT 0
);

CREATE TABLE classe_subclasses (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id  VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    nome       VARCHAR(120) NOT NULL,
    icone      VARCHAR(16),
    descricao  VARCHAR(500),
    ordem      INT NOT NULL DEFAULT 0
);

CREATE TABLE classe_habilidades_destaque (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id  VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    nome       VARCHAR(160) NOT NULL,
    ordem      INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_classe_papeis_classe ON classe_papeis(classe_id);
CREATE INDEX idx_classe_subclasses_classe ON classe_subclasses(classe_id);
CREATE INDEX idx_classe_habilidades_classe ON classe_habilidades_destaque(classe_id);
