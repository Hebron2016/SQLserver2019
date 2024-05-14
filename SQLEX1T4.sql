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

SELECT id, nome, email, username, 
	CASE WHEN (senha != '123mudar')
	THEN'********'
	ELSE
		senha
	END
 FROM Users

SELECT nome, descricao, dataProject, DATEADD(DAY,15,dataProject) AS data_Final FROM Projects
WHERE  id  IN
 (
	SELECT projects_id FROM user_has_project
	WHERE users_id IN
	(
		SELECT  id FROM Users
		WHERE email LIKE 'apar%'
	)
)

SELECT nome, email FROM Users
WHERE id IN
(
	SELECT users_id FROM user_has_project
	WHERE projects_id IN
	(
		SELECT  id FROM Projects
		WHERE nome LIKE 'Audito%'
	)
)

SELECT nome, descricao,dataProject,('2014-09-16') as datafinal, (DATEDIFF(DAY,dataProject,'2014-09-16')*79.85) AS custoTotal  FROM Projects
WHERE nome = 'Manutenção PCs'

EXEC sp_help Users
EXEC sp_help user_has_project
SELECT * FROM user_has_project