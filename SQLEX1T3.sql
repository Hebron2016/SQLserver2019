CREATE DATABASE SQLEX1T3v1
GO
USE SQLEX1T3v1

CREATE TABLE Projects (
id			INT			NOT NULL IDENTITY(10001,1),
nome		VARCHAR(45) NOT NULL,
descricao   VARCHAR(45) NOT NULL,
dataProject DATE		NOT NULL CHECK(dataProject > '2014-09-01')
PRIMARY KEY (id)
)
GO
CREATE TABLE Users(
id			INT			NOT NULL IDENTITY (1,1),
nome		VARCHAR(45) NOT NULL,
username	VARCHAR(45) NOT NULL UNIQUE,
senha		VARCHAR(45) NOT NULL DEFAULT('123mudar'),
email		VARCHAR(45) NOT NULL
PRIMARY KEY (id)
)

CREATE TABLE user_has_project(
users_id	INT			NOT NULL,
projects_id INT			NOT NULL
PRIMARY KEY(users_id, projects_id)
FOREIGN KEY(users_id) REFERENCES Users(id),
FOREIGN KEY(projects_id)REFERENCES Projects(id) 
)

ALTER TABLE Users
ALTER COLUMN username VARCHAR(10) 
/*Poderia usar drop CONSTRAINS mas eu não aprendi*/

ALTER TABLE Users
ALTER COLUMN senha VARCHAR(8) NOT NULL

INSERT INTO Users VALUES
('Maria', 'Rh_maria', '', 'maria@empresa.com'),
('Paulo', 'Ti_paulo','123@456','paulo@empresa.com'),
('Ana', 'Rh_ana', '','ana@empresa.com'),
('Clara', 'Ti_Clara', '','clara@empresa.com'),
('Aparecido','Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO Projects VALUES
('Re-folha','Refatoração de folhas','2014-09-05'),
('Manutenção PCs', 'Manutenção PCs','2014-09-06'),
('Auditoria', '', '2014-09-07')

INSERT INTO user_has_project VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)

UPDATE Projects
SET dataProject = 2014-09-12
WHERE nome = 'Manutenção PCs'

UPDATE Users
SET username = 'Rh_cido'
WHERE username = 'Rh_apareci'

UPDATE Users
SET senha = '888@*' 
WHERE username = 'Rh_maria' AND senha = '123mudar'

DELETE user_has_project
WHERE users_id = 2

EXEC sp_help Users