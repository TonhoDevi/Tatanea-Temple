-- ============================================================
-- Autenticação (substitui Supabase Auth)
-- ============================================================
CREATE TABLE usuarios (
    id           VARCHAR(36) PRIMARY KEY,
    email        VARCHAR(180) NOT NULL UNIQUE,
    senha_hash   VARCHAR(255) NOT NULL,
    nome         VARCHAR(120),
    criado_em    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Núcleo do personagem (ficha completa, bate com ddt-character-sheet.html)
-- ============================================================
CREATE TABLE personagens (
    id                   VARCHAR(36) PRIMARY KEY,
    usuario_id           VARCHAR(36) NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    nome                 VARCHAR(120) NOT NULL,
    tipo                 VARCHAR(20) NOT NULL DEFAULT 'dnd',
    nome_jogador         VARCHAR(120),
    raca_id              BIGINT REFERENCES racas(id),
    classe_id            VARCHAR(64) REFERENCES classes(id),
    nivel                INT NOT NULL DEFAULT 1,
    imagem_url           VARCHAR(500),

    forca                INT NOT NULL DEFAULT 10,
    destreza             INT NOT NULL DEFAULT 10,
    constituicao         INT NOT NULL DEFAULT 10,
    inteligencia         INT NOT NULL DEFAULT 10,
    sabedoria            INT NOT NULL DEFAULT 10,
    carisma              INT NOT NULL DEFAULT 10,

    pv_atual             INT NOT NULL DEFAULT 0,
    pv_maximo            INT NOT NULL DEFAULT 0,
    pv_temporario        INT NOT NULL DEFAULT 0,
    ca                   INT NOT NULL DEFAULT 10,
    deslocamento         VARCHAR(20),
    iniciativa_bonus     INT NOT NULL DEFAULT 0,
    atributo_magia       VARCHAR(20),
    bonus_magia_extra    INT NOT NULL DEFAULT 0,
    inspiracao           BOOLEAN NOT NULL DEFAULT FALSE,
    dados_vida_gastos    INT NOT NULL DEFAULT 0,

    antecedente          VARCHAR(120),
    tendencia            VARCHAR(60),
    ponto_heroico        BOOLEAN NOT NULL DEFAULT FALSE,

    moeda_pc             INT NOT NULL DEFAULT 0,
    moeda_pp             INT NOT NULL DEFAULT 0,
    moeda_po             INT NOT NULL DEFAULT 0,
    moeda_pe             INT NOT NULL DEFAULT 0,
    moeda_pl             INT NOT NULL DEFAULT 0,

    desloc_nadar         VARCHAR(20),
    desloc_voar          VARCHAR(20),
    desloc_escalar       VARCHAR(20),
    salto                VARCHAR(20),

    -- VARCHAR com limite (não TEXT ilimitado): evita que um payload gigante
    -- vindo do cliente vire uma negação de serviço no banco.
    idiomas              VARCHAR(5000),
    historia             VARCHAR(5000),
    anotacoes            VARCHAR(5000),

    bonus_proficiencia         INT NOT NULL DEFAULT 2,
    limite_sincronizados       INT NOT NULL DEFAULT 3,
    detalhe_idade              INT,
    detalhe_altura             INT,
    detalhe_peso               INT,
    detalhe_caracteristicas    VARCHAR(2000),
    personalidade_tracos       VARCHAR(2000),
    personalidade_ideais       VARCHAR(2000),
    personalidade_vinculos     VARCHAR(2000),
    personalidade_defeitos     VARCHAR(2000),
    salvaguarda_forca          BOOLEAN NOT NULL DEFAULT FALSE,
    salvaguarda_destreza       BOOLEAN NOT NULL DEFAULT FALSE,
    salvaguarda_constituicao   BOOLEAN NOT NULL DEFAULT FALSE,
    salvaguarda_inteligencia   BOOLEAN NOT NULL DEFAULT FALSE,
    salvaguarda_sabedoria      BOOLEAN NOT NULL DEFAULT FALSE,
    salvaguarda_carisma        BOOLEAN NOT NULL DEFAULT FALSE,

    criado_em            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_personagens_usuario ON personagens(usuario_id);

-- ============================================================
-- Perícias (proficiência / expertise por perícia)
-- ============================================================
CREATE TABLE personagem_pericias (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    pericia       VARCHAR(60) NOT NULL,
    proficiente   BOOLEAN NOT NULL DEFAULT FALSE,
    expertise     BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_personagem_pericias_personagem ON personagem_pericias(personagem_id);

-- ============================================================
-- Ataques
-- ============================================================
CREATE TABLE personagem_ataques (
    id                 BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id      VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome               VARCHAR(120) NOT NULL,
    bonus_atributo     VARCHAR(20),
    bonus_proficiente  BOOLEAN NOT NULL DEFAULT FALSE,
    bonus_extra        INT NOT NULL DEFAULT 0,
    descricao          VARCHAR(1000),
    ordem              INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_ataques_personagem ON personagem_ataques(personagem_id);

-- Um ataque pode ter mais de um dano (ex: espada flamejante = cortante + fogo).
CREATE TABLE personagem_ataque_danos (
    ataque_id       BIGINT NOT NULL REFERENCES personagem_ataques(id) ON DELETE CASCADE,
    ordem           INT NOT NULL,
    dano_quantidade INT NOT NULL DEFAULT 1,
    dano_dado       VARCHAR(4),
    dano_bonus      INT NOT NULL DEFAULT 0,
    tipo_dano       VARCHAR(30)
);

CREATE INDEX idx_personagem_ataque_danos_ataque ON personagem_ataque_danos(ataque_id);

-- ============================================================
-- Inventário
-- ============================================================
CREATE TABLE personagem_inventario (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(160) NOT NULL,
    quantidade     INT NOT NULL DEFAULT 1,
    peso           DOUBLE PRECISION,
    descricao      VARCHAR(500),
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_inventario_personagem ON personagem_inventario(personagem_id);

-- ============================================================
-- Itens mágicos
-- ============================================================
CREATE TABLE personagem_itens_magicos (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(160) NOT NULL,
    descricao      VARCHAR(1000),
    sincronizado   BOOLEAN NOT NULL DEFAULT FALSE,
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_itens_magicos_personagem ON personagem_itens_magicos(personagem_id);

-- ============================================================
-- Habilidades (raciais/de classe anotadas na ficha)
-- ============================================================
CREATE TABLE personagem_habilidades (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(160) NOT NULL,
    descricao      VARCHAR(1000),
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_habilidades_personagem ON personagem_habilidades(personagem_id);

-- ============================================================
-- Magias (truques + níveis 1-9)
-- ============================================================
CREATE TABLE personagem_magias (
    id                BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id     VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nivel             INT NOT NULL DEFAULT 0,
    nome              VARCHAR(160) NOT NULL,
    preparada         BOOLEAN NOT NULL DEFAULT FALSE,
    tempo_conjuracao  VARCHAR(120),
    descricao         VARCHAR(2000),
    ordem             INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_magias_personagem ON personagem_magias(personagem_id);

-- ============================================================
-- Unidades/Criaturas individuais (familiares, montarias, invocações)
-- ============================================================
CREATE TABLE personagem_unidades (
    id                BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id     VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome              VARCHAR(160) NOT NULL,
    tipo              VARCHAR(80),
    dados_extra_json  VARCHAR(5000),
    ordem             INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_unidades_personagem ON personagem_unidades(personagem_id);

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

-- ============================================================
-- Talentos escolhidos pelo personagem
-- ============================================================
CREATE TABLE personagem_talentos (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    talento_id     BIGINT NOT NULL REFERENCES talentos(id),
    ordem          INT NOT NULL DEFAULT 0,
    UNIQUE (personagem_id, talento_id)
);

CREATE INDEX idx_personagem_talentos_personagem ON personagem_talentos(personagem_id);

-- ============================================================
-- Peças de armadura (detalhamento da CA) e modificadores de iniciativa
-- ============================================================
CREATE TABLE personagem_armadura_pecas (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(120),
    bonus          INT NOT NULL DEFAULT 0,
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_armadura_pecas_personagem ON personagem_armadura_pecas(personagem_id);

CREATE TABLE personagem_iniciativa_modificadores (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(120),
    bonus          INT NOT NULL DEFAULT 0,
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_iniciativa_modificadores_personagem ON personagem_iniciativa_modificadores(personagem_id);

-- ============================================================
-- Tesouro (valores em peças de bronze)
-- ============================================================
CREATE TABLE personagem_tesouro (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id   VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome            VARCHAR(160),
    quantidade      INT NOT NULL DEFAULT 1,
    valor_unitario  DOUBLE PRECISION NOT NULL DEFAULT 0,
    descricao       VARCHAR(500),
    ordem           INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_tesouro_personagem ON personagem_tesouro(personagem_id);

-- ============================================================
-- Componentes de PV máximo (detalhamento, mesmo esquema da CA)
-- ============================================================
CREATE TABLE personagem_pv_maximo_componentes (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nome           VARCHAR(120),
    bonus          INT NOT NULL DEFAULT 0,
    ordem          INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_pv_maximo_componentes_personagem ON personagem_pv_maximo_componentes(personagem_id);

-- ============================================================
-- Slots de magia por nível (0 = truques, 1-9 = níveis de magia)
-- ============================================================
CREATE TABLE personagem_slots_magia (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    personagem_id  VARCHAR(36) NOT NULL REFERENCES personagens(id) ON DELETE CASCADE,
    nivel          INT NOT NULL,
    total          INT NOT NULL DEFAULT 0,
    restantes      INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_personagem_slots_magia_personagem ON personagem_slots_magia(personagem_id);
