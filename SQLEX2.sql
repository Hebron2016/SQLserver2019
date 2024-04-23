CREATE DATABASE SQLEX2
GO
USE SQLEX2


CREATE TABLE editora (
ID_editora int NOT NULL IDENTITY (491,16),
Nome varchar(70) NOT NULL UNIQUE,
Telefone varchar(11) NOT NULL CHECK(LEN(TELEFONE)=10),
Logradouro_Endereco varchar(200) NOT NULL,
Numero_Endereco int NOT NULL CHECK (Numero_Endereco>0),
CEP_Endereco char(8) NOT NULL CHECK (LEN(CEP_Endereco) = 8),
Complemento_Endereco varchar(255) NOT NULL
PRIMARY KEY (ID_editora)
)

CREATE TABLE livro (
Codigo	int	NOT NULL IDENTITY (100001, 100),
Nome varchar(200) NOT NULL,
Lingua varchar(10)  NOT NULL DEFAULT('PT-BR'),
Ano int NOT NULL CHECK(Ano >1990)
PRIMARY KEY (Codigo)
)

CREATE TABLE autor (
ID_Autor int NOT NULL IDENTITY (2351, 1),
Nome varchar(100) NOT NULL UNIQUE,
Date_Nasc date NOT NULL,
Pais_Nasc varchar(100) NOT NULL CHECK ((Pais_Nasc = 'Brasil') OR (Pais_Nasc ='Alemanha') OR (Pais_Nasc ='Inglaterra') OR (Pais_Nasc ='Estados Unidos')),
Biogragia varchar (100) NOT NULL
PRIMARY KEY (ID_Autor)
)
CREATE TABLE edicao (
ISBN char(13) NOT NULL CHECK(LEN(ISBN)=13),
Preco decimal(4,2) NOT NULL CHECK (Preco > 0),
Ano int NOT NULL CHECK (Ano>1993),
Numero_Paginas int NOT NULL CHECK (Numero_Paginas > 15), 
Qtd_Estoque int NOT NULL, 
PRIMARY KEY (ISBN)
)

CREATE TABLE editora_edicao_livro (
EditoraID_Editora int NOT NULL,
EdicaoISBN char(13) NOT NULL,
LivroCodigo int NOT NULL
PRIMARY KEY (EditoraID_Editora, EdicaoISBN, LivroCodigo)
FOREIGN KEY (EditoraID_Editora) REFERENCES Editora(ID_Editora),
FOREIGN KEY (EdicaoISBN) REFERENCES edicao (ISBN),
FOREIGN KEY (LivroCodigo) REFERENCES livro (Codigo)
)
CREATE TABLE Livro_Autor (
LivroCodigo int NOT NULL,
AutorID_Autor int NOT NULL
PRIMARY KEY (LivroCodigo, AutorID_Autor)
FOREIGN KEY (LivroCodigo) REFERENCES livro (Codigo),
FOREIGN KEY (AutorID_Autor) REFERENCES Autor (ID_Autor)
)
