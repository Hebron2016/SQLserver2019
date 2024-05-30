USE ex9

/*1) Consultar nome, valor unitário, nome da editora e nome do autor dos livros do estoque que foram vendidos. Não podem haver repetições.*/
SELECT DISTINCT est.nome, CAST((est.valor / quantidade) AS DECIMAL (7,2)) AS valorUnitario, edi.nome, au.nome
FROM autor au, estoque est, editora edi, compra com
WHERE au.codigo = est.codAutor
AND est.codEditora = edi.codigo
AND com.codEstoque = est.codigo

/*2) Consultar nome do livro, quantidade comprada e valor de compra da compra 15051 */
SELECT est.nome,com.codigo 
FROM estoque est, compra com
WHERE est.codigo = com.codEstoque
AND com.codigo = 15051

/*3) Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site tenha mais de 10 dígitos, remover o www.). */
SELECT est.nome, CASE WHEN(LEN(edi.site) > 10) 
	THEN SUBSTRING(edi.site, 5,35) 
	END AS siteN
FROM estoque est, editora edi
WHERE est.codEditora = edi.codigo
AND edi.nome = 'Makron books'

/*4) Consultar nome do livro e Breve Biografia do David Halliday */
SELECT est.nome, au.biografia
FROM estoque est, autor au
WHERE est.codAutor = au.codigo
AND au.nome = 'David Halliday'

/*5) Consultar código de compra e quantidade comprada do livro Sistemas Operacionais Modernos */
SELECT com.codigo, com.qtdComprada
FROM compra com, estoque est
WHERE com.codEstoque = est.codigo
AND est.nome ='Sistemas Operacionais Modernos'

/*6) Consultar quais livros não foram vendidos */
SELECT est.nome
FROM estoque est LEFT OUTER JOIN compra com
ON com.codEstoque = est.codigo
WHERE com.codigo IS NULL

/*7) Consultar quais livros foram vendidos e não estão cadastrados. Caso o nome dos livros terminem com espaço, fazer o trim apropriado. */
SELECT LTRIM(est.nome) AS nome
FROM compra com  LEFT OUTER JOIN estoque est
ON com.codEstoque = est.codigo
WHERE est.codigo IS NULL

/*8) Consultar Nome e site da editora que não tem Livros no estoque (Caso o site tenha mais de 10 dígitos, remover o www.)	 */
SELECT edi.nome, edi.site
FROM editora edi LEFT OUTER JOIN estoque est
ON edi.codigo = est.codEditora
WHERE est.codigo IS NULL

/*9) Consultar Nome e biografia do autor que não tem Livros no estoque (Caso a biografia inicie com Doutorado, substituir por Ph.D.) */
SELECT au.nome, CASE WHEN (au.biografia LIKE ('Doutorado')) 
	THEN 'Ph. D.' + SUBSTRING(au.biografia, 9, LEN(au.biografia))
	ELSE
	au.biografia
	END
AS biografia
FROM autor au LEFT OUTER JOIN estoque est
ON au.codigo = est.codAutor
WHERE est.codigo IS NULL

/*10) Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente */
SELECT au.nome, MAX(est.valor) AS valor
FROM autor au,estoque est
WHERE au.codigo = est.codAutor
AND est.valor IN 
(
	SELECT est.valor 
	FROM estoque est
)
GROUP BY au.nome
ORDER BY valor DESC

/*11) Consultar o código da compra, o total de livros comprados e a soma dos valores gastos. Ordenar por Código da Compra ascendente. */
SELECT com.codigo, SUM(com.qtdComprada), SUM(com.valor)
FROM compra com
WHERE com.qtdComprada IN
(
	SELECT com.qtdComprada
	FROM compra com
)
AND com.valor IN
(
	SELECT com.valor
	FROM compra com
)
GROUP BY com.codigo
ORDER BY com.codigo ASC

/*12) Consultar o nome da editora e a média de preços dos livros em estoque.Ordenar pela Média de Valores ascendente.	 */
SELECT edi.nome, CAST(AVG(est.valor) AS DECIMAL (5,2)) AS media
FROM editora edi, estoque est
WHERE edi.codigo = est.codEditora
AND est.valor IN 
(
	SELECT est.valor
	FROM editora edi, estoque est
	WHERE edi.codigo = est.codEditora 
)
GROUP BY edi.nome
ORDER BY media ASC

/*13) Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora (Caso o site tenha mais de 10 dígitos, remover o www.), criar uma coluna status onde:	
	Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido
	Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando
	Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente
	A Ordenação deve ser por Quantidade ascendente */
SELECT est.nome, est.quantidade,CASE WHEN(LEN(edi.site) > 10) 
	THEN SUBSTRING(edi.site, 5,35) 
	END AS siteN,
	CASE WHEN (est.quantidade < 5) THEN
	'Produto em Ponto de Pedido'
	 WHEN (est.quantidade >= 5 and est.quantidade <= 10) THEN
	'Produto Acabando'
	WHEN (est.quantidade > 10) THEN
	'ESTOQUE SUFICIENTE'
	END
	AS Status
FROM estoque est, editora edi
WHERE est.codEditora = edi.codigo
ORDER BY est.quantidade ASC

/*14) Para montar um relatório, é necessário montar uma consulta com a seguinte saída: Código do Livro, Nome do Livro, Nome do Autor, Info Editora (Nome da Editora + Site) de todos os livros	
	Só pode concatenar sites que não são nulos */
SELECT est.codigo, au.nome, CASE WHEN (edi.site IS NOT NULL) 
	THEN edi.nome + ' ' + edi.site 
	ELSE edi.nome END AS infoEditora
FROM estoque est, autor au, editora edi
WHERE est.codAutor = au.codigo 
AND est.codEditora = edi.codigo

/*15) Consultar Codigo da compra, quantos dias da compra até hoje e quantos meses da compra até hoje */
SELECT DATEDIFF(DAY,dataCompra, GETDATE()) AS qtdDias, DATEDIFF(MONTH,dataCompra, GETDATE()) AS qtdMes
FROM compra

/*16) Consultar o código da compra e a soma dos valores gastos das compras que somam mais de 200.00 */
SELECT SUM(com.valor) AS valor, com.codigo
FROM compra com
WHERE com.valor IN 
(
	SELECT com.valor
	FROM compra com
)
GROUP BY com.codigo
HAVING SUM(com.valor) > 200



SELECT * FROM compra
SELECT * FROM estoque
SELECT * FROM editora
SELECT * FROM autor