CREATE TABLE IF NOT EXISTS categoria (
    id      SERIAL2     NOT NULL,
    nome    VARCHAR(30) NOT NULL,
    CONSTRAINT pk_categoria PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS produto (
    id              SERIAL          NOT NULL,
    nome            VARCHAR(50)     NOT NULL,
    descricao       VARCHAR(200)    NULL,
    valor_unitario  MONEY           DEFAULT 0,
    qtde            INT             DEFAULT 0,
    imagem          VARCHAR(100)    NULL,
    idcategoria     INT2            NOT NULL,
    CONSTRAINT pk_produto           PRIMARY KEY(id),
    CONSTRAINT fk_produto_categoria FOREIGN KEY(idcategoria) REFERENCES categoria(id)
);

CREATE TABLE IF NOT EXISTS lote (
    id              SERIAL8         NOT NULL,
    data_fabricacao DATE            NOT NULL,
    data_validade   DATE            NOT NULL,
    qtde            INT2            NOT NULL,
    custo           MONEY           DEFAULT 0,
    localizacao     CHAR(1)         DEFAULT 'E',
    idproduto       INT             NOT NULL,
    CONSTRAINT pk_lote              PRIMARY KEY(id),
    CONSTRAINT fk_lote_produto      FOREIGN KEY(idproduto) REFERENCES produto(id)
);