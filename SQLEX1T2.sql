CREATE DATABASE SQLEX1T2 
GO
USE SQLEX1T2

CREATE TABLE mae (
ID_Mae		INT				NOT NULL IDENTITY (1001,1),
nome		VARCHAR(60)		NOT NULL,
logradouro	VARCHAR(100)	NOT NULL,
numero		INT				NOT NULL CHECK(numero >0),
cep			CHAR(8)			NOT NULL CHECK (LEN(cep) = 8),
complemento	VARCHAR(200)	NOT NULL,
telefone	CHAR(10)		NOT NULL CHECK (LEN(telefone) = 10),
data_nasc	DATE			NOT NULL
PRIMARY KEY (ID_Mae)
)
GO
CREATE TABLE medico (
CRM_numero		INT				NOT NULL,
CRM_UF			CHAR(2)			NOT NULL,
nome			VARCHAR(60)		NOT NULL,
celular			CHAR(11)		NULL  UNIQUE CHECK (LEN (celular) = 11),
especialidade	VARCHAR(30)		NOT NULL
PRIMARY KEY(CRM_numero, CRM_UF)
)
GO
CREATE TABLE bebe (
ID_Bebe			INT				NOT NULL IDENTITY (1,1),
nome			VARCHAR(60)		NOT NULL,
data_nasc		DATE			NOT NULL DEFAULT (GETDATE()),
altura			DECIMAL(7,2)	NOT NULL CHECK (altura > 0),
peso			DECIMAL(7,2)	NOT NULL CHECK (altura > 0),
ID_Mae			INT				NOT NULL
PRIMARY KEY (ID_Bebe)
FOREIGN KEY (ID_Mae) REFERENCES mae(ID_Mae)
)
GO
CREATE TABLE bebe_medico (
ID_Bebe			INT				NOT NULL,
CRM_numero		INT				NOT NULL,
CRM_UF			CHAR(2)			NOT NULL
PRIMARY KEY (ID_Bebe, CRM_Numero, CRM_UF)
FOREIGN KEY (ID_Bebe) REFERENCES bebe(ID_Bebe),
FOREIGN KEY (CRM_numero, CRM_UF) REFERENCES
	medico(CRM_numero, CRM_UF)
)