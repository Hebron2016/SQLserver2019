CREATE DATABASE SQLEX1

USE SQLEX1

CREATE TABLE paciente (
Num_Beneficiario int NOT NULL,
Nome varchar(100) NOT NULL,
Logradouro varchar(200) NOT NULL,
Numero int NOT NULL,
CEP char(8) NOT NULL,
Complemento varchar(255) NOT NULL,
Telefone varchar(11) NOT NULL,
PRIMARY KEY (Num_Beneficiario)
)
GO
CREATE TABLE especialidade ( 
ID int NOT NULL,
Especialidade varchar (100) NOT NULL,
PRIMARY KEY (ID)
)
GO
CREATE TABLE medico (
Codigo int NOT NULL,
Nome varchar(100) NOT NULL,
Logradouro varchar(200) NOT NULL,
Numero int NOT NULL,
CEP char(8) NOT NULL,
Complemento varchar(255) NOT NULL,
Contato varchar (11) NOT NULL,
EspecialidadeID int NOT NULL
PRIMARY KEY (Codigo)
FOREIGN KEY (EspecialidadeID) REFERENCES especialidade(ID)
)
GO
CREATE TABLE consulta (
PacienteNum_Beneficiario int NOT NULL,
MedicoCodigo int NOT NULL,
Data_Hora varchar(20) NOT NULL,
Observacao timestamp NOT NULL
PRIMARY KEY (Data_Hora, MedicoCodigo,PacienteNum_Beneficiario)
FOREIGN KEY (MedicoCodigo) REFERENCES medico(Codigo),
FOREIGN KEY (PacienteNum_Beneficiario) REFERENCES paciente(Num_Beneficiario)
)

INSERT INTO paciente VALUES
 (99901, 'WashingtonSilva', 'R.Anhaia', 150, 02345000, 'Casa', 922229999),
 (99902, 'Luis Ricardo ', 'R.Voluntarios da Pátria', 2251, 03254010,'Bloco B. Apto 25',923450987),
 (99903, 'Maria Elisa', 'Av.Aguia de Haia', 1188,06987020,'Apto 1208', 912348765),
 (99904,'José Araujo', 'R. XV de Novembro',18,03678000,'Casa',945674312),
 (99905,'Joana Paula', 'R. 7 de Abril', 97,01214000,'Conjunto 3 - Apto801',912095673)

 INSERT INTO medico VALUES
 (100001,'Ana Paula','R.7 de setembro', 256, 03698000, 'Casa',915689456,1),
 (100002, 'Maria Aparecida', 'Av.Brasil', 32, 02145070, 'Casa',923235454,1),
 (100003, 'Lucas Borges', 'Av. do Estado', 3210, 05241000, 'Apto 205', 963698585,2),
 (100004, 'Gabriel Oliveira', 'Av.DomHelder Camara', 350, 03145000, 'Apto 602',932458745,3)

 INSERT INTO especialidade VALUES
 (1,'Otorrinolaringologista'),
 (2,'Urologista'),
 (3,'Geriatra'),
 (4,'Pediatra')



 INSERT INTO consulta (PacienteNum_Beneficiario,Data_Hora, MedicoCodigo,Data_Hora, Observacao) VALUES 
 (99901, 100002,'2021-09-04 13:40','Infecção Urina'),
 (99902, 100003,'2021-09-04 13:15','Gripe'),
 (99901, 100001,'2021-09-04 12:30','Infecção Garganta')



 ALTER TABLE medico
 ADD dia_Atendimento varchar (30) NOT NULL

 INSERT INTO medico(dia_Atendimento) VALUES
 ('Passa a atender na 2ªFeira'),
 ('Passa a atender na 4ªFeira'),
 ('Passa a atender na 2ªFeira'),
 ('Passa a atender na 5ªFeira')

DELETE especialidade
WHERE ID = 4

UPDATE medico
SET Logradouro ='Av. Bras Leme', Numero =876, CEP=0212200,Complemento='Apto 504'
WHERE Codigo = 100003

ALTER TABLE consulta 
ALTER COLUMN Observacao VARCHAR(200) NULL