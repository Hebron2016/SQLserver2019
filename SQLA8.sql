use exercicio13
--1)Apresentar marca e modelo de carro e a soma total da distância percorrida pelos carros,
--em viagens, de uma dada empresa, ordenado pela distância percorrida

SELECT car.marca, car.modelo, SUM(via.distanciaPercorrida) AS somaDistant, emp.nome
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.distanciaPercorrida IN
(
	SELECT via.distanciaPercorrida
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome
ORDER BY somaDistant DESC

--2)Apresentar nome das empresas cuja soma total da distância percorrida pelos carros,
--em viagens, é superior a 50000 km

SELECT car.marca, car.modelo, CASE WHEN (SUM(via.distanciaPercorrida) > 50000) 
THEN emp.nome 
END AS sup50000
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.distanciaPercorrida IN
(
	SELECT via.distanciaPercorrida
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome

--3)Apresentar nome das empresas cuja soma total da distância percorrida pelos carros
--e a media das distâncias percorridas por seus carros em viagens.
--A média deve ser exibida em uma coluna chamada mediaDist e com 2 casas decimais apenas.
--Deve-se ordenar a saída pela média descrescente

SELECT  emp.nome, SUM(via.distanciaPercorrida) AS somaDistant, CAST(AVG(via.distanciaPercorrida) AS DECIMAL(7,2)) AS mediaDist
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.distanciaPercorrida IN
(
	SELECT via.distanciaPercorrida
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome
ORDER BY mediaDist DESC

--4)Apresentar nome das empresas cujos carro percorreram a maior distância dentre as cadastradas
SELECT MAX(via.distanciaPercorrida) AS somaDistant, emp.nome
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.distanciaPercorrida IN
(
	SELECT via.distanciaPercorrida
	FROM viagem via
)
GROUP BY emp.nome
ORDER BY somaDistant DESC

--5)Apresentar nome das empresas e a quantidade de carros cadastrados para cada empresa
--Desde que a empresa tenha 3 ou mais carros
--A saída deve ser ordenada pela quantidade de carros, descrescente

SELECT COUNT(car.id) AS qtdCarro, emp.nome
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND car.id IN
(
	SELECT car.id
	FROM carro car
)
GROUP BY emp.nome
ORDER BY qtdCarro DESC

--6)Consultar Nomes das empresas que não tem carros cadastrados

SELECT emp.nome
FROM empresa emp LEFT OUTER JOIN carro car
ON car.idEmpresa = emp.id
WHERE car.idEmpresa IS NULL

--7)Consultar Marca e modelos dos carros que não fizeram viagens
SELECT car.marca, car.modelo
FROM carro car LEFT OUTER JOIN viagem via
ON car.id = via.idCarro
WHERE via.idCarro IS NULL

--8)Consultar quantas viagens foram feitas por cada carro (marca e modelo) de cada empresa
--em ordem ascendente de nome de empresa e descendente de quantidade

SELECT car.marca, car.modelo, COUNT(via.idCarro) AS qtdViagem, emp.nome
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.idCarro IN
(
	SELECT via.idCarro
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome
ORDER BY emp.nome ASC, qtdViagem DESC

--9) Consultar o nome da empresa, a marca e o modelo do carro, a distância percorrida
--e o valor total ganho por viagem, sabendo que para distâncias inferiores a 1000 km, o valor é R$10,00
--por km e para viagens superiores a 1000 km, o valor é R$15,00 por km.

SELECT emp.nome, car.marca, car.modelo, via.distanciaPercorrida, CASE WHEN(via.distanciaPercorrida < 1000)
THEN 10
WHEN(via.distanciaPercorrida > 1000)
THEN 15
END
AS ValorTotal
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.idCarro IN
(
	SELECT via.idCarro
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome, via.distanciaPercorrida

--10) Apresentar o nome da empresa e a média de distância percorrida por seus carros. A saída da média deve ter até 2 casas decimais e deve ser ordenada pela média da distância percorrida 

SELECT  emp.nome, CAST(AVG(via.distanciaPercorrida) AS DECIMAL(7,2)) AS mediaDist
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.distanciaPercorrida IN
(
	SELECT via.distanciaPercorrida
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome
ORDER BY mediaDist DESC

--11) Apresentar marca e modelo do carro, além do nome da empresa e a data no formato (DD/MM/AAAA) do carro que fez a última viagem dentre os cadastrados

SELECT car.marca, car.modelo, emp.nome,CONVERT(CHAR(10), via.data,103) AS fdate
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.data IN
(
	SELECT MAX(via.data)
	FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome, via.data

--12) Considerando que hoje é 01/01/2023, apresentar a marca e o modelo do carro, além do nome da empresa 
--e a quantidade de dias da viagem, dos carros que tiveram viagens nos últimos 3 meses. Ordenar (todos ascendentes) por quantidade de dias, marca, modelo e nome da empresa.

SELECT car.marca, car.modelo, emp.nome, DATEDIFF(DAY, via.data, '2023-01-01') as qtd
FROM carro car, viagem via, empresa emp
WHERE car.id = via.idCarro
AND car.idEmpresa = emp.id
AND via.idCarro IN
(
SELECT via.idCarro
FROM viagem via
)
GROUP BY car.marca, car.modelo, emp.nome,via.data
HAVING DATEDIFF(MONTH, via.data,'2023-01-01') <= 3
ORDER BY qtd ASC
