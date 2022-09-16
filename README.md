
# Projeto Lógico de Banco de Dados

Projeto realizado durante o Bootcamp Database Experience da Digital Innovation One (DIO).

## Objetivos


- Replicar a modelagem do projeto lógico de banco de dados para o cenário de e-commerce;
- Recuperações simples com SELECT Statement;
- Filtros com WHERE Statement;
- Criar expressões para gerar atributos derivados;
- Definir ordenações dos dados com ORDER BY;
- Condições de filtros aos grupos – HAVING Statement;
- Criar junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;


### Consultas elaboradas

#### PEDIDO E NOME DO CLIENTE
```sql
SELECT P.idPedido, C.Nome, C.CPF_CNPJ, P.StatusPedido, P.FreteValor, P.FormaPagamento_idFormaPagamento FROM Pedido AS P
INNER JOIN Cliente as C ON C.idCliente = P.Cliente_idCliente;
```

#### NUMERO DE PEDIDOS POR CLIENTES
```sql
SELECT COUNT(*) AS NumeroPedidosPorCliente, P.idPedido, C.Nome, C.CPF_CNPJ, P.StatusPedido, P.FreteValor, P.FormaPagamento_idFormaPagamento FROM Pedido AS P
INNER JOIN Cliente as C ON C.idCliente = P.Cliente_idCliente GROUP BY P.idPedido;
```

#### VALOR TOTAL DO PEDIDO
```sql
SELECT SUM(ValorTotal) FROM (SELECT Pedido_idPedido, Quantidade AS QtdProduto, DescricaoProduto, Valor as ValUnitario, Valor*Quantidade as ValorTotal
FROM produtopedido, produto WHERE Produto_idProduto = idProduto) AS A WHERE Pedido_idPedido = 2;
```

#### VALOR TOTAL DO PEDIDO COM GROUP BY
```sql
SELECT Pedido_idPedido, SUM(ValorTotal) FROM (SELECT Pedido_idPedido, Quantidade AS QtdProduto, DescricaoProduto, Valor as ValUnitario, Valor*Quantidade as ValorTotal
FROM produtopedido, produto WHERE Produto_idProduto = idProduto) AS A GROUP BY Pedido_idPedido;
```

#### CONSULTA COM NOME, PEDIDO, VALOR UNITARIO E VALOR SOMADO DOS ITENS
```sql
SELECT A.Cliente_idCliente, AC.Nome, PP.Pedido_idPedido, PP.Quantidade AS QtdProduto, P.DescricaoProduto, P.Valor as ValUnitario, P.Valor*PP.Quantidade as ValorTotal
FROM produtopedido AS PP
INNER JOIN produto AS P ON PP.Produto_idProduto = P.idProduto
INNER JOIN pedido AS A ON A.idPedido = PP.Pedido_idPedido
INNER JOIN CLIENTE AS AC ON A.Cliente_idCliente = AC.idCliente;
```
#### CONSULTA DE VALOR TOTAL DE TODOS OS ITENS DO PEDIDO APRESENTANDO NOME DO CLIENTE
```sql
SELECT Pedido_idPedido, Nome, SUM(ValorTotal) AS VALOR_TOTAL_PEDIDO FROM
	(SELECT
		A.Cliente_idCliente,
		AC.Nome,
		PP.Pedido_idPedido,
		PP.Quantidade AS
		QtdProduto,
		P.DescricaoProduto,
		P.Valor AS ValUnitario,
		P.Valor*PP.Quantidade AS ValorTotal
	FROM produtopedido AS PP
	INNER JOIN produto AS P ON PP.Produto_idProduto = P.idProduto
	INNER JOIN pedido AS A ON A.idPedido = PP.Pedido_idPedido
	INNER JOIN CLIENTE AS AC ON A.Cliente_idCliente = AC.idCliente) AS AA
	GROUP BY Pedido_idPedido;
```

#### CONSULTA DE VALOR TOTAL DE TODOS OS ITENS DO PEDIDO APRESENTANDO NOME DO CLIENTE UTILIZANDO HAVING
```sql
SELECT Pedido_idPedido, Nome, SUM(ValorTotal) AS VALOR_TOTAL_PEDIDO FROM
	(SELECT
		A.Cliente_idCliente,
		AC.Nome,
		PP.Pedido_idPedido,
		PP.Quantidade AS
		QtdProduto,
		P.DescricaoProduto,
		P.Valor AS ValUnitario,
		P.Valor*PP.Quantidade AS ValorTotal
	FROM produtopedido AS PP
	INNER JOIN produto AS P ON PP.Produto_idProduto = P.idProduto
	INNER JOIN pedido AS A ON A.idPedido = PP.Pedido_idPedido
	INNER JOIN CLIENTE AS AC ON A.Cliente_idCliente = AC.idCliente) AS AA
	GROUP BY Pedido_idPedido
    HAVING VALOR_TOTAL_PEDIDO > 5000;
    ```