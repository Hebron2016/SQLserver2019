CREATE DATABASE SQLEX2T4v1
GO
USE SQLEX2T4v1

CREATE TABLE Estrela(
id			INT			NOT NULL,
nome		VARCHAR(50) NOT NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE Filme(
id			INT			NOT NULL,
titulo		VARCHAR(40) NOT NULL,
ano			INT		    NULL CHECK(ano <= 2021)
PRIMARY KEY (id)
)
GO
CREATE TABLE Cliente(
num_cadastro INT		NOT NULL,
nome		 VARCHAR(70) NOT NULL,
logradouro	 VARCHAR(150) NOT NULL,
num			 INT		NOT NULL CHECK (num > 0),
cep			 CHAR(8)	NULL CHECK (LEN(cep) = 8)
PRIMARY KEY (num_cadastro)
)
GO
CREATE TABLE DVD (
num			 INT		NOT NULL,
data_Fabricacao DATE	NOT NULL CHECK(data_Fabricacao < GETDATE()),
filmeID		 INT		NOT NULL
PRIMARY KEY (num)
FOREIGN KEY (filmeID) REFERENCES Filme(id)
)
GO
CREATE TABLE Filme_Estrela(
filmeID		 INT		NOT NULL,
estrelaID    INT		NOT NULL
PRIMARY KEY (filmeID, estrelaID)
FOREIGN KEY (filmeID) REFERENCES Filme(id),
FOREIGN KEY (estrelaID) REFERENCES Estrela(id)
)
GO
CREATE TABLE Locacao(
dvdNUM		 INT			NOT NULL,
clientenum_cadastro INT NOT NULL,
data_locacao DATE		NOT NULL DEFAULT (GETDATE()),
data_devolucao DATE		NOT NULL,
valor		 DECIMAL (7,2) NOT NULL CHECK(valor > 0),
CONSTRAINT chk_datas
	CHECK (data_devolucao > data_locacao)
)
ALTER TABLE Estrela
ADD nomeReal VARCHAR(50) NULL

ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR (80) NOT NULL

INSERT INTO Filme VALUES
(1001, 'Whiplash', 2015),
(1002, 'Birdman',2015),
(1003, 'Interestelar',2014),
(1004, 'A Culpa é das estrelas', 2014),
(1005,'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
(1006,'Sing',2016)

INSERT INTO Estrela VALUES
(9901, 'Michael Keaton', 'Michael John Douglas'),
(9902, 'Emma Stone', 'Emily Jean Stone'),
(9903, 'Miles Teller', NULL),
(9904, 'Steve Carell', 'Steven John Carell'),
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO Filme_Estrela VALUES
(1002,9901),
(1002,9902),
(1001,9903),
(1005,9904),
(1005,9905)

INSERT INTO DVD VALUES
(10001, '2020-12-02', 1001),
(10002, '2019-10-18', 1002),
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1004),
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002),
(10007, '2020-12-02', 1005),
(10008, '2019-10-18', 1002),
(10009, '2020-04-03', 1003)

INSERT INTO Cliente VALUES
(5501, 'Matilde Luz', 'Rua Síria', 150, '03086040'),
(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
(5503, 'Daniel Ramalho', 'Rua Itajutiba',169,NULL),
(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg',36,NULL),
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235,'02917110')

INSERT INTO Locacao VALUES
(10001, 5502, '2021-02-18', '2021-02-21',3.50),
(10009, 5502, '2021-02-18', '2021-02-21',3.50),
(10002, 5504, '2021-02-18', '2021-02-19',3.50),
(10002, 5505, '2021-02-20', '2021-02-23',3.00),
(10004, 5505, '2021-02-20', '2021-02-23',3.00),
(10005, 5505, '2021-02-20', '2021-02-23',3.00),
(10001, 5501, '2021-02-24', '2021-02-26',3.50),
(10008, 5501, '2021-02-24', '2021-02-26',3.50)


UPDATE Cliente
SET cep = '08411150'
WHERE num_cadastro = 5503

UPDATE Cliente
SET cep = '02919190'
WHERE num_cadastro = 5504

UPDATE Locacao 
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND clientenum_cadastro = 5502

UPDATE DVD
SET data_Fabricacao = '2019-07-14'
WHERE num = 10005

UPDATE Estrela
SET nomeReal = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

DELETE Filme
WHERE titulo = 'Sing'

SELECT cli.num_cadastro, cli.nome, fil.titulo,CONVERT(CHAR(10),midia.data_Fabricacao,103), alo.valor
FROM Cliente cli, Filme fil, DVD midia, Locacao alo
WHERE cli.num_cadastro = alo.clientenum_cadastro
AND alo.dvdNUM = midia.num
AND midia.filmeID = fil.id
AND midia.data_Fabricacao IN
(
	SELECT MAX(midia.data_Fabricacao)
	FROM DVD midia
)

SELECT cli.num_cadastro, cli.nome, CONVERT(CHAR(10),alo.data_locacao,103), COUNT(alo.dvdNUM) AS qtdDVD 
FROM Cliente cli, Locacao alo
WHERE cli.num_cadastro = alo.clientenum_cadastro
AND alo.dvdNUM IN
(
	SELECT alo.dvdNUM
	FROM Locacao alo
)
GROUP BY cli.num_cadastro, cli.nome, alo.data_locacao

SELECT cli.num_cadastro, cli.nome, CONVERT(CHAR(10),alo.data_locacao,103), SUM(alo.valor) AS valorTotal
FROM Cliente cli, Locacao alo
WHERE cli.num_cadastro = alo.clientenum_cadastro
AND alo.valor IN
(
	SELECT alo.valor
	FROM Locacao alo
)
GROUP BY cli.num_cadastro, cli.nome, alo.data_locacao

SELECT cli.num_cadastro, cli.nome, CASE WHEN (COUNT(alo.data_locacao) >= 2) THEN CONVERT(CHAR(10),alo.data_locacao,103) END AS valorTotal
FROM Cliente cli, Locacao alo
WHERE cli.num_cadastro = alo.clientenum_cadastro
AND alo.data_locacao IN
(
	SELECT alo.data_locacao
	FROM Locacao alo
)
GROUP BY cli.num_cadastro, cli.nome, alo.data_locacao

SELECT* FROM Locacao