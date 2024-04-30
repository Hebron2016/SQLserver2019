CREATE DATABASE SQLEX2T2
GO
USE SQLEX2T2

CREATE TABLE Cliente(
id			int				NOT NULL IDENTITY (3401,15),
nome		varchar(100)    NOT NULL,
logradouro  varchar(200)    NOT NULL,
numero		int				NOT NULL CHECK (numero > 0),
cep			char(8)			NOT NULL CHECK (LEN(cep) = 8),
complemento varchar(255)	NOT NULL,
PRIMARY KEY (id)
)

CREATE TABLE Peca(
id			int				NOT NULL IDENTITY (3411,7) UNIQUE,
nome		varchar(30)		NOT NULL,
preco		decimal(4,2)    NOT NULL CHECK(preco > 0),
estoque     int				NOT NULL CHECK(estoque >=10),
PRIMARY KEY (id)
)

CREATE TABLE Categoria(
id			int				NOT NULL IDENTITY (1,1),
categoria	varchar(10)		NOT NULL CHECK (categoria = 'estagiário'OR categoria ='nível 1'  OR categoria ='nível 2' OR categoria ='nível 3'),
valor_Hora  decimal(4,2)    NOT NULL CHECK(valor_Hora > 0 AND ((categoria = 'estagiário' AND valor_hora = 15.00) 
				OR (categoria ='nível 1' AND valor_hora = 25.00 )OR(categoria ='nível 2' AND valor_hora = 35.00 )
				OR (categoria ='nível 3' AND valor_hora = 50.00 ))),
PRIMARY KEY (id),
)

CREATE TABLE Funcionario(
id			 int			NOT NULL IDENTITY(101,1),
nome		 varchar(100)	NOT NULL,
logradouro   varchar(200)   NOT NULL,
numero		 int			NOT NULL,
telefone	 char(11)		NOT NULL CHECK (LEN(telefone)>=10),
categoria_habilitacao varchar(2) NOT NULL CHECK(categoria_habilitacao = 'A' OR categoria_habilitacao = 'B' OR 
					categoria_habilitacao = 'C' OR categoria_habilitacao = 'D' OR categoria_habilitacao = 'E'), 
categoriaID  int			NOT NULL
PRIMARY KEY (id)
FOREIGN KEY (CategoriaID) REFERENCES Categoria(id) 
)

CREATE TABLE Telefone_Cliente(
clienteID	 int			NOT NULL,
telefone	 varchar(11)	NOT NULL CHECK (LEN(telefone)>=10)
PRIMARY KEY (clienteID, telefone) 
FOREIGN KEY (clienteID) REFERENCES Cliente (id)
)
CREATE TABLE Veiculo(
placa		 char(7)		NOT NULL CHECK (LEN(placa)=7),
marca		 varchar(30)	NOT NULL,
modelo		 varchar(30)	NOT NULL,
cor			 varchar(15)	NOT NULL,
anoFabricacao int			NOT NULL CHECK(anoFabricacao > 1977),
anoModelo	 int			NOT NULL CHECK(anoModelo > 1977 AND anoModelo >= anoFabricacao),
dataAquisicao date			NOT NULL,
clienteID	 int			NOT NULL
PRIMARY KEY (placa)
FOREIGN KEY (clienteID) REFERENCES Cliente (id)
)

CREATE TABLE Reparo(
veiculoPlaca char(7)		NOT NULL,
funcionarioID int			NOT NULL,
pecaID		 int			NOT NULL,
dataReparo	 date			NOT NULL DEFAULT (GETDATE()),
custoTotal   decimal(4,2)	NOT NULL CHECK(custoTotal > 0),
tempo		 int			NOT NULL CHECK(tempo > 0)
PRIMARY KEY (veiculoPlaca, funcionarioID, pecaID, dataReparo)
FOREIGN KEY (veiculoPlaca) REFERENCES Veiculo (placa),
FOREIGN KEY (funcionarioID) REFERENCES funcionario (id),
FOREIGN KEY (pecaID) REFERENCES peca (id),
)
