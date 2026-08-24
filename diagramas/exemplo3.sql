CREATE TABLE IF NOT EXISTS ambiente
(
  id              serial       NOT NULL,
  identificacao   varchar(30)  NOT NULL,
  descricao       varchar(100),
  bloco           varchar(20) ,
  andar           int2        ,
  localizacao     varchar(30) ,
  area            decimal(7,2) NOT NULL,
  capacidade      int2        ,
  idtipo_ambiente int2      NOT NULL,
  CONSTRAINT pk_ambiente PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS equipamento
(
  id                 serial       NOT NULL,
  nome               varchar(60)  NOT NULL,
  descricao          varchar(300) NOT NULL,
  valor              money        NOT NULL DEFAULT 0,
  patrimoniado       bool         NOT NULL DEFAULT false,
  ativo              bool         NOT NULL DEFAULT true,
  idtipo_equipamento int2         NOT NULL,
  idusuario          int2         NOT NULL,
  CONSTRAINT pk_equipamento PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS lotacao
(
  id            serial NOT NULL,
  idambiente    int    NOT NULL,
  idequipamento int    NOT NULL,
  data          date   NOT NULL,
  idusuario     int    NOT NULL,
  CONSTRAINT pk_lotacao PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS manutencao
(
  id                   serial       NOT NULL,
  idequipamento        int          NOT NULL,
  data_entrada         date         NOT NULL DEFAULT CURRENT_DATE,
  data_saida           date        ,
  descricao_problema   varchar(300) NOT NULL,
  descricao_manutencao varchar(300),
  custo                money        NOT NULL DEFAULT 0,
  contato              varchar(60) ,
  idusuario            int          NOT NULL,
  CONSTRAINT pk_manutencao PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tipo_ambiente
(
  id        serial2     NOT NULL,
  nome      varchar(20) NOT NULL,
  descricao varchar(60),
  CONSTRAINT pk_tipo_ambiente PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tipo_equipamento
(
  id        serial2     NOT NULL,
  nome      varchar(30) NOT NULL,
  descricao varchar(60),
  CONSTRAINT pk_tipo_equipamento PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS usuario
(
  id   serial      NOT NULL,
  nome varchar(60) NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id)
);

ALTER TABLE ambiente
  ADD CONSTRAINT FK_tipo_ambiente_TO_ambiente
    FOREIGN KEY (idtipo_ambiente)
    REFERENCES tipo_ambiente (id);

ALTER TABLE equipamento
  ADD CONSTRAINT FK_tipo_equipamento_TO_equipamento
    FOREIGN KEY (idtipo_equipamento)
    REFERENCES tipo_equipamento (id);

ALTER TABLE lotacao
  ADD CONSTRAINT FK_ambiente_TO_lotacao
    FOREIGN KEY (idambiente)
    REFERENCES ambiente (id);

ALTER TABLE lotacao
  ADD CONSTRAINT FK_equipamento_TO_lotacao
    FOREIGN KEY (idequipamento)
    REFERENCES equipamento (id);

ALTER TABLE manutencao
  ADD CONSTRAINT FK_equipamento_TO_manutencao
    FOREIGN KEY (idequipamento)
    REFERENCES equipamento (id);

ALTER TABLE lotacao
  ADD CONSTRAINT FK_usuario_TO_lotacao
    FOREIGN KEY (idusuario)
    REFERENCES usuario (id);

ALTER TABLE equipamento
  ADD CONSTRAINT FK_usuario_TO_equipamento
    FOREIGN KEY (idusuario)
    REFERENCES usuario (id);

ALTER TABLE manutencao
  ADD CONSTRAINT FK_usuario_TO_manutencao
    FOREIGN KEY (idusuario)
    REFERENCES usuario (id);
