CREATE TABLE classes (
    id                   VARCHAR(64) PRIMARY KEY,
    nome                 VARCHAR(120) NOT NULL,
    subtitulo            VARCHAR(160),
    icone                VARCHAR(16),
    cor                  VARCHAR(16),
    dado_de_vida         VARCHAR(8) NOT NULL,
    dificuldade          VARCHAR(40),
    descricao_intro      TEXT,
    -- Dump bruto e verbatim das tabelas originais (progressão + espaços de
    -- magia) — preservado à parte da reconstrução estruturada em
    -- classe_niveis, pra nenhuma informação da fonte se perder.
    tabelas_texto_bruto  TEXT
);

CREATE TABLE classe_papeis (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id  VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    papel      VARCHAR(60) NOT NULL,
    ordem      INT NOT NULL DEFAULT 0
);

CREATE TABLE classe_niveis (
    id                  BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id           VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    nivel               INT NOT NULL,
    bonus_proficiencia  VARCHAR(8),
    caracteristicas     TEXT
);

CREATE TABLE classe_caracteristicas (
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id  VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    titulo     VARCHAR(160) NOT NULL,
    corpo      TEXT,
    -- HABILIDADE = característica própria da classe, ganha num nível
    -- específico (usada pela ficha pra trazer as habilidades corretas
    -- conforme o nível do personagem). FUNDAMENTO = regra fixa que toda
    -- classe tem (Pontos de Vida, Proficiências, Equipamento, Incrementos
    -- de Habilidade) — não é "ganha" num nível, por isso nivel fica nulo.
    -- CONJURACAO = regras de conjuração de magia da classe — não é uma
    -- habilidade nomeada e concedida, só existe pra quem tem magia.
    tipo       VARCHAR(20) NOT NULL DEFAULT 'HABILIDADE',
    nivel      INT,
    ordem      INT NOT NULL DEFAULT 0
);

CREATE TABLE classe_subclasses (
    id           BIGINT AUTO_INCREMENT PRIMARY KEY,
    classe_id    VARCHAR(64) NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
    nome         VARCHAR(120) NOT NULL,
    icone        VARCHAR(16),
    intro_texto  TEXT,
    magias_texto TEXT,
    ordem        INT NOT NULL DEFAULT 0
);

CREATE TABLE classe_subclasse_caracteristicas (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    subclasse_id  BIGINT NOT NULL REFERENCES classe_subclasses(id) ON DELETE CASCADE,
    titulo        VARCHAR(160) NOT NULL,
    corpo         TEXT,
    -- Nível em que a subclasse concede essa característica (sempre é uma
    -- habilidade — subclasse não tem "fundamento" próprio).
    nivel         INT,
    ordem         INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_classe_papeis_classe ON classe_papeis(classe_id);
CREATE INDEX idx_classe_niveis_classe ON classe_niveis(classe_id);
CREATE INDEX idx_classe_caracteristicas_classe ON classe_caracteristicas(classe_id);
CREATE INDEX idx_classe_subclasses_classe ON classe_subclasses(classe_id);
CREATE INDEX idx_classe_subclasse_caract_subclasse ON classe_subclasse_caracteristicas(subclasse_id);
