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

-- POPULAR TABELAS DO BANCO DE DADOS UTILIZANDO DML 

INSERT INTO tipo_ambiente (nome, descricao)
VALUES 
('Lab de Informática','Laboratório com computadores de uso geral'),
('Sala de Aula','Sala de aula de uso geral com quadro branco'),
('Secretaria','Espaço dos dptos para atendimento ao público'),
('Depósito','Local armazenamento de objetos e equipamentos'),
('Sala Docente','Espaço para trabalho e repouso de professores');

INSERT INTO ambiente (identificacao,descricao,bloco,andar,localizacao,area,capacidade,idtipo_ambiente)
VALUES
('DCOM Lab 01','Para uso de robótica','B',0,NULL,40,35,1),
('DCOM Lab 02',NULL,'B',0,NULL,30,25,1),
('DCOM Lab 03',NULL,'B',0,NULL,35,30,1),
('DCOM Sec','Secretaria do DCOM','B',0,'Ao lado do DCOM Lab 06',40,6,3),
('DOACAO','Equipamentos para doação ou descarte','A',1,NULL,40,0,4),
('A-01',NULL,'A',0,NULL,40,35,2);

INSERT INTO tipo_equipamento (nome, descricao)
VALUES 
('Computador','Computador de mesa'),
('Notebook','Computador portátil'),
('Datashow','Equipamento de projeção'),
('Impressora','Equipamento de impressão'),
('Cadeira','Cadeira');

INSERT INTO usuario (nome)
VALUES
('João'),
('Maria'),
('Pedro');

INSERT INTO equipamento (nome,descricao,valor,patrimoniado,ativo,idtipo_equipamento,idusuario)
VALUES
('Sony RMX3','Resolução 1280x720, 500 nits',1923.44,DEFAULT,DEFAULT,3,2),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Dell latitude Q2','i5 12 geracao, 256GB SSD, 16GB RAM',4522.88,TRUE,TRUE,1,1),
('Lenovo Atitude','i7 14 geracao, 256GB SSD, 16GB RAM',4876.11,TRUE,TRUE,2,3),
('HP Speed2','Laser, 14ppm, preto',3271.49,TRUE,TRUE,4,2);

INSERT INTO lotacao (idambiente,idequipamento,data,idusuario)
VALUES
(2,1,'2025-08-25',2),
(3,2,'2026-01-11',1),
(3,3,'2026-01-11',1),
(3,4,'2026-01-11',1),
(3,5,'2026-01-11',1),
(3,6,'2026-01-11',1),
(3,7,'2026-01-11',1),
(3,8,'2026-01-11',1),
(3,9,'2026-01-11',1),
(3,10,'2026-01-11',1),
(3,11,'2026-01-11',1),
(3,12,'2026-01-11',1),
(4,13,'2026-03-20',3),
(4,14,'2026-08-11',2),
(4,2,'2026-08-20',2);

INSERT INTO manutencao (idequipamento,data_entrada,data_saida,descricao_problema,descricao_manutencao,custo,contato,idusuario)
VALUES
(14,'2026-08-12','2026-08-12','Não liga','Colocar na tomada',DEFAULT,'Ariovaldo (1234-2222)',1),
(4,'2026-08-20',NULL,'Bateria não está carregando',NULL,DEFAULT,'Ariovaldo (1234-2222)',2);

-- Faça uma consulta que exiba todos os equipamentos inativos cujo valor seja menor do que 1000.
SELECT *
FROM equipamento
WHERE ativo=FALSE AND valor<1000;

-- Faça uma consulta que exiba todos os equipamentos ativos que ainda não foram patrimoniados
SELECT *
FROM equipamento
WHERE ativo=TRUE AND patrimoniado=FALSE;

-- Faça uma consulta que liste os equipamentos que tenham a palavra datashow na descrição.
SELECT *
FROM equipamento
WHERE UPPER(descricao) LIKE '%DATASHOW%';

-- Faça uma consulta que lista os equipamentos da categoria "Notebook"
SELECT *
FROM equipamento
WHERE idtipo_equipamento = (SELECT id 
                            FROM tipo_equipamento
                            WHERE UPPER(nome)='NOTEBOOK');

-- Faça uma consulta que liste a lotação atual do equipamento de código 2
SELECT identificacao, bloco, andar
FROM ambiente
WHERE id= (SELECT idambiente
          FROM lotacao
          WHERE idequipamento=2
          ORDER BY data DESC, id DESC
          LIMIT 1);

-- Faça uma consulta que liste a identificação do ambiente e o nome do tipo de ambiente 
-- ordenado por tipo de ambiente
SELECT t.nome AS tipo, a.identificacao, a.bloco, a.andar, a.area, a.capacidade 
FROM tipo_ambiente t INNER JOIN ambiente a ON t.id = a.idtipo_ambiente
ORDER BY t.nome ASC, a.bloco ASC, a.andar ASC;

-- Faça uma consulta que liste os equipamentos (nome, descricao, patrimonio)
-- que se encontram em manutenção
SELECT e.id AS patrimonio, e.nome AS equipamento, e.descricao, m.data_entrada AS manutencao_desde, CURRENT_DATE-m.data_entrada AS qtde_dias  
FROM equipamento e INNER JOIN manutencao m ON e.id=m.idequipamento
WHERE m.data_saida IS NULL;

-- Faça uma consulta que liste a lotação atual do equipamento de código 2.
-- No resultado deverá ser apresentado o nome do tipo de equipamento, 
-- a identificaçõ do ambiente, bem como o tipo de ambiente e o nome do usuário
-- que realizou a lotação
SELECT e.nome AS equipamento, te.nome AS tipo_equipamento, a.identificacao AS ambiente,
       ta.nome AS tipo_ambiente, u.nome AS lotado_por, l.data as em
FROM tipo_equipamento te
INNER JOIN equipamento e      ON te.id = e.idtipo_equipamento
INNER JOIN lotacao l          ON e.id = l.idequipamento
INNER JOIN ambiente a         ON a.id = l.idambiente
INNER JOIN tipo_ambiente ta   ON ta.id = a.idtipo_ambiente
INNER JOIN usuario u          ON u.id = l.idusuario
WHERE e.id = 2
ORDER BY l.data DESC
LIMIT 1;

-- Faça uma consulta que apresente o menor e o maior valor de equipamento já adquirido
SELECT MIN(valor)::MONEY, MAX(valor)::MONEY
FROM equipamento;

-- Faça uma consulta que apresente o nome, a descrição e o tipo de equipamento de maior valor
SELECT e.nome, e.descricao, te.nome AS tipo, e.valor
FROM tipo_equipamento te
INNER JOIN equipamento e ON te.id = e.idtipo_equipamento
WHERE e.valor = (SELECT MAX(valor) FROM equipamento);

-- Faça uma consulta que apresente a área total do bloco A
SELECT SUM(area) AS TOTAL_BLOCO_A
FROM ambiente
WHERE bloco = 'A';

-- Faça uma consulta que apresente a qtde de ambientes do bloco A
SELECT COUNT(*) AS TOTAL_AMBIENTE_A
FROM ambiente
WHERE bloco = 'A';

-- Faça uma consulta que apresente a média de dias que os equipamentos ficam em manutenção
SELECT AVG(data_saida-data_entrada) AS MEDIA_DIAS_EM_MANUTENCAO
FROM manutencao
WHERE data_saida IS NOT NULL;

-- Faça uma consulta que apresente a qtde de ambientes por bloco
SELECT bloco, COUNT(bloco) AS qtde_ambientes
FROM ambiente
GROUP BY bloco
ORDER BY bloco;

-- Faça uma consulta que apresente a qtde de equipamentos por 
-- tipo de equipamento.
EXPLAIN ANALYZE SELECT te.nome AS tipo, e.qtde
FROM tipo_equipamento te
INNER JOIN 
    (SELECT idtipo_equipamento, COUNT(idtipo_equipamento) AS qtde
    FROM equipamento
    GROUP BY idtipo_equipamento) e ON te.id = e.idtipo_equipamento;

EXPLAIN ANALYZE SELECT te.nome, COUNT(te.nome) AS qtde
FROM tipo_equipamento te
INNER JOIN equipamento e ON te.id = e.idtipo_equipamento
GROUP BY te.nome;

-- Faça uma consulta que apresente a qtde de manutenções mês a mês
SELECT EXTRACT(YEAR FROM data_entrada) AS ano,
       EXTRACT(MONTH FROM data_entrada) AS mes,
       COUNT(*) AS qtde
FROM manutencao
GROUP BY EXTRACT(YEAR FROM data_entrada), EXTRACT(MONTH FROM data_entrada)
ORDER BY EXTRACT(YEAR FROM data_entrada), EXTRACT(MONTH FROM data_entrada);

SELECT ano, mes, COUNT(*) AS qtde
FROM
  (SELECT EXTRACT(YEAR FROM data_entrada) AS ano,
          EXTRACT(MONTH FROM data_entrada) AS mes
  FROM manutencao)
GROUP BY ano,mes
ORDER BY ano,mes;

-- Faça uma consulta que apresente a qtde de equipamentos por ambiente
SELECT a.identificacao, COUNT(a.identificacao) AS qtde_equipamentos
FROM lotacao lBACKUP DE TODOS OS DATABASES

INNER JOIN 
  (SELECT idequipamento, MAX(data) as data
  FROM lotacao
  GROUP BY idequipamento) l2 ON l.idequipamento = l2.idequipamento AND l.data = l2.data
INNER JOIN ambiente a ON l.idambiente = a.id
GROUP BY a.identificacao
ORDER BY a.identificacao;

-- Faça uma consulta que apresente a qtde de operações (lotacao e manutencao)
-- de cada usuário em um determinado ano/mês.
SELECT o.ano, o.mes, u.nome, COUNT(*) AS qtde_operacoes
FROM
  (SELECT idusuario, EXTRACT(YEAR FROM data) AS ano, EXTRACT(MONTH FROM data) AS mes
  FROM lotacao
  UNION ALL
  SELECT idusuario, EXTRACT(YEAR FROM data_entrada) AS ano, EXTRACT(MONTH FROM data_entrada) AS mes
  FROM manutencao) o
INNER JOIN usuario u ON u.id = o.idusuario
GROUP BY o.ano, o.mes, u.nome
ORDER BY o.ano, o.mes, u.nome;