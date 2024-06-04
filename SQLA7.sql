USE ex05
/*1. Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.*/
SELECT cli.nome, pd.quantidade, (pr.valor_unitario * pd.quantidade) AS ValorTotal, 
CAST(((pr.valor_unitario * pd.quantidade)-(pr.valor_unitario * pd.quantidade)*0.25) AS DECIMAL(5,2)) AS ValorTotal25P
FROM cliente cli, pedido pd, produto pr
WHERE cli.codigo = pd.cod_cli
AND pr.codigo = pd.cod_prod
AND cli.nome = 'Maria Clara'

SELECT pr.nome
FROM produto pr LEFT OUTER JOIN fornecedor fr
ON fr.codigo = pr.cod_forn
WHERE pr.qtd_estoque = 0
AND fr.atividade LIKE 'Brinquedo%'

SELECT pr.nome, pr.descricao
FROM produto pr LEFT OUTER JOIN pedido pd
ON pr.codigo = pd.cod_prod
WHERE pd.cod_prod IS NULL

UPDATE produto
SET qtd_estoque = 10
WHERE nome = 'Faqueiro'

SELECT COUNT(cli.codigo) AS qtd_40
FROM cliente cli
WHERE cli.codigo IN(
	SELECT CASE WHEN (DATEDIFF(YEAR, cli.data_nasc, GETDATE()) >= 40)THEN cli.codigo END
	FROM cliente cli
)

SELECT forn.nome, SUBSTRING (forn.telefone, 1, 4)+'-'+SUBSTRING(forn.telefone, 4, 8) AS  tel
FROM fornecedor forn
WHERE forn.atividade LIKE 'Brinquedo%'
OR forn.atividade LIKE 'Chocolate%'

SELECT pr.nome, CASE WHEN (pr.valor_unitario < 50.0)THEN
CAST(((pr.valor_unitario)-(pr.valor_unitario)*0.25) AS DECIMAL(5,2)) ELSE
pr.valor_unitario
END
AS Valor
FROM produto pr

SELECT pr.nome, CASE WHEN (pr.valor_unitario > 100.0)THEN
CAST(((pr.valor_unitario)+(pr.valor_unitario)*0.10) AS DECIMAL(5,2)) ELSE
pr.valor_unitario
END
AS Valor
FROM produto pr

SELECT (pr.valor_unitario * pd.quantidade) AS ValorTotal, 
CAST(((pr.valor_unitario * pd.quantidade)-(pr.valor_unitario * pd.quantidade)*0.15) AS DECIMAL(5,2)) AS ValorTotal10P
FROM produto pr, pedido pd
WHERE pr.codigo = pd.cod_prod
AND pd.codigo = 99001

SELECT pd.codigo, cli.nome, DATEDIFF(YEAR, cli.data_nasc, GETDATE()) AS idade
FROM pedido pd, cliente cli
WHERE pd.cod_cli = cli.codigo

SELECT forn.nome
FROM fornecedor forn, produto pr
WHERE forn.codigo = pr.cod_forn
	AND pr.valor_unitario IN
(
 SELECT MAX(pr.valor_unitario)
 FROM produto pr
)

SELECT CAST (AVG(pr.valor_unitario)AS DECIMAL(5,2)) AS MEDIA
FROM produto pr
WHERE pr.qtd_estoque > 0

/*13. Consultar o nome do cliente, endereço composto por logradouro e número, o valor unitário do produto, o valor total (Quantidade * valor unitario) da compra do cliente de nome Maria Clara */
SELECT cli.nome,cli.logradouro +' '+ CAST(cli.numero AS VARCHAR(5)) AS EndereçoComposto,pr.valor_unitario, pd.quantidade, (pr.valor_unitario * pd.quantidade) AS ValorTotal
FROM cliente cli, pedido pd, produto pr
WHERE cli.codigo = pd.cod_cli
AND pr.codigo = pd.cod_prod
AND cli.nome = 'Maria Clara'

SELECT cli.nome, DATEDIFF(DAY, pd.previsao_ent,'2023-03-15') AS atraso
FROM cliente cli, pedido pd
WHERE cli.codigo = pd.cod_cli
AND	cli.nome = 'Maria Clara'

SELECT DATEADD(DAY, 9, pd.previsao_ent) AS novaData
FROM cliente cli, pedido pd
WHERE cli.codigo = pd.cod_cli
AND cli.nome LIKE 'Alberto%'


SELECT * FROM produto
SELECT * FROM pedido
SELECT * FROM fornecedor
SELECT * FROM cliente


