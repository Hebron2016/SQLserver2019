CREATE DATABASE SQLEX1T4v1
GO
USE SQLEX1T4v1

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
GO
CREATE TABLE user_has_project(
users_id	INT			NOT NULL,
projects_id INT			NOT NULL
PRIMARY KEY(users_id, projects_id)
FOREIGN KEY(users_id) REFERENCES Users(id),
FOREIGN KEY(projects_id)REFERENCES Projects(id) 
)

ALTER TABLE Users
DROP CONSTRAINT UQ__Users__F3DBC57278EEE4C0;
GO
ALTER TABLE Users
ALTER COLUMN username VARCHAR(10) NOT NULL;

ALTER TABLE Users
ALTER COLUMN senha VARCHAR(8) NOT NULL

INSERT INTO Users VALUES
('Maria', 'Rh_maria', DEFAULT, 'maria@empresa.com'),
('Paulo', 'Ti_paulo','123@456','paulo@empresa.com'),
('Ana', 'Rh_ana', DEFAULT,'ana@empresa.com'),
('Clara', 'Ti_Clara', DEFAULT,'clara@empresa.com'),
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
SET dataProject = '2014-09-12'
WHERE nome = 'Manutenção PCs'

UPDATE Users
SET username = 'Rh_cido'
WHERE username = 'Rh_apareci'

UPDATE Users
SET senha = '888@*' 
WHERE username = 'Rh_maria' AND senha = '123mudar'

DELETE user_has_project
WHERE users_id = 2

INSERT INTO Users VALUES
('Joao','Ti_joao', DEFAULT, 'joao@empresa.com')

INSERT INTO Projects VALUES
('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PCs','2014-09-12')

SELECT us.id, us.nome, us.email,
	pr.id, pr.nome, pr.descricao, pr.dataProject
FROM Users us, user_has_project uhp, Projects pr
Where us.id = uhp.users_id 
  AND uhp.projects_id = pr.id
  AND pr.nome = 'Re-folha' 

SELECT pr.nome, pr.id
FROM Projects pr LEFT OUTER JOIN user_has_project uhp
ON uhp.projects_id = pr.id
WHERE uhp.users_id IS NULL

SELECT us.nome, us.id
FROM Users us LEFT OUTER JOIN user_has_project uhp
ON uhp.users_id = us.id
WHERE uhp.projects_id IS NULL

EXEC sp_help Users
EXEC sp_help user_has_project

SELECT *  FROM Users
SELECT *  FROM Projects
SELECT * FROM user_has_project

