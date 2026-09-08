CREATE TABLE essencias (
    simbolo     VARCHAR(8)   PRIMARY KEY,
    nome        VARCHAR(60)  NOT NULL,
    cor         VARCHAR(20)  NOT NULL,
    cor_fundo   VARCHAR(40)  NOT NULL,
    elemento    VARCHAR(60)  NOT NULL
);

CREATE TABLE pocoes (
    id          VARCHAR(64)  PRIMARY KEY,
    nome        VARCHAR(120) NOT NULL,
    raridade    VARCHAR(30)  NOT NULL,
    icone       VARCHAR(20),
    formula     VARCHAR(120) NOT NULL,
    duracao     VARCHAR(60),
    nucleo      TEXT,
    descricao   TEXT,
    melhoria    TEXT
);
