USE ECOMMERCE;

INSERT INTO CLIENTE (Nome, TipoCliente, Endereco, CPF_CNPJ, DataNascimento) VALUES
('Emily Marli Porto', 'Pessoa Fisica', 'Rua Bambuzinho, 848, Manaus - AM', '687.451.895-01', '1994-05-03'),
('Cauê Iago Santos', 'Pessoa Fisica', 'Rua Bambuzinho, 2348, Araraquara - SP', '738.138.987-84', '1975-02-13'),
('Raul Marcelo Geraldo Rezende', 'Pessoa Fisica', 'Rua Bambuzinho, 28, Campinas - SP', '217.265.140-05', '1984-01-30'),
('Sarah Vanessa Nogueira', 'Pessoa Fisica', 'Rua Bambuzinho, 243, Uberlândia - MG', '235.516.564-52', '1999-10-25'),
('Renato Leonardo Bryan Silva', 'Pessoa Fisica', 'Rua Bambuzinho, 1232, Minas Gerais - MG', '371.014.321-74', '1954-11-23'),
('Lara Alícia Agatha Nogueira', 'Pessoa Fisica', 'Rua Bambuzinho, 345, Rio de Janeiro - RJ', '770.260.048-91', '1988-09-13'),
('Lucas Roberto Silveira', 'Pessoa Fisica', 'Rua Bambuzinho, 823, São Carlos - SP', '328.540.994-00', '1991-01-01');

SELECT * FROM CLIENTE;

INSERT INTO PRODUTO (Categoria, DescricaoProduto) VALUES
('Eletrônicos', 'Notebook Acer'),
('Eletrônicos', 'Robô Aspirador Xiaomi'),
('Eletrônicos', 'Tablet Samsung Tela 10"'),
('Eletrônicos', 'Monitor LG Ultrawide 29"'),
('Eletrônicos', 'Kit Teclado e Mouse Wireless Evolut');

SELECT * FROM produto;
UPDATE PRODUTO SET VALOR = 5000.00 WHERE IDPRODUTO = 1;
UPDATE PRODUTO SET VALOR = 1000.00 WHERE IDPRODUTO = 2;
UPDATE PRODUTO SET VALOR = 1200.00 WHERE IDPRODUTO = 3;
UPDATE PRODUTO SET VALOR = 1800.00 WHERE IDPRODUTO = 4;
UPDATE PRODUTO SET VALOR = 450.90 WHERE IDPRODUTO = 5;


INSERT INTO ESTOQUE (Localizacao, Quantidade) VALUES
('São Carlos-SP', 4521),
('Leme', 1236);

SELECT * FROM ESTOQUE;

INSERT INTO PRODUTO_EM_ESTOQUE (Produto_idProduto, Estoque_idEstoque, Quantidade) VALUES
(1, 1, 45),
(2, 1, 500),
(3, 1, 321),
(4, 2, 27),
(5, 2, 158);

SELECT * FROM PRODUTO_EM_ESTOQUE;

INSERT INTO FORNECEDOR (RazaoSocial, CNPJ_Fornecedor, Contato1) VALUES
('EletroTech LTDA', '71505319000117', '16 99199-9696'),
('Incinebras CO.', '14225369000156', '59 997879897');

SELECT * FROM fornecedor;

INSERT INTO fornecimentoproduto (Fornecedor_idFornecedor, Produto_idProduto) VALUES
(1, 2),
(2, 3);

SELECT * FROM fornecimentoproduto;

INSERT INTO vendedorterceiro (RazaoSocial, CNPJ_Vendedor, NomeFantasia, Contato1, Endereco, UF) VALUES
('VendaMais SP', '123452398745663', 'VendaMais SP', '22 3365-6565', 'Rua da Passarela Torta, 91, CENTRO - Araras', 'SP'),
('Extra Mercadorias LTDA', '87456965874563', 'ExtraTech', '11 98752-6632', 'Avenida Rambo Malaquias, 433, CENTRO - Ibaté', 'SP');

SELECT * FROM vendedorterceiro;

INSERT INTO ProdutoVendedorTerceiro (Produto_idProduto, VendedorTerceiro_idVendedorTerceiro, Quantidade) VALUES
(2, 1, 98),
(5, 2, 42);

INSERT INTO FormaPagamento (FormaPagamentoDescricao) VALUES
('Pix'),
('Boleto'),
('Cartão de Crédito'),
('Cartão de Débito'),
('Dinheiro');

INSERT INTO Pedido (StatusPedido, DescricaoPedido, Cliente_idCliente, FreteValor, FormaPagamento_idFormaPagamento) VALUES
('Confirmado', 'Realizado através do site', 1, 39.85, 1),
('Pendente', 'Verificando estoque', 2, 10.89, 3),
('Em Processamento', 'Compra via Vendedor Terceiro', 4, 24.54, 4);

SELECT * FROM pedido;

INSERT INTO ProdutoPedido (Produto_idProduto, Pedido_idPedido, Quantidade) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 11);

INSERT INTO ENTREGA (StatusEntrega, CodigoRastreio) VALUES
('Em rota', 'SA15685241BR'),
('Entregue ao Destinatário', 'ED1452152112BR'),
('No centro de distribuição', 'PO1234513215BR');

INSERT INTO PedidoEntrega (Pedido_idPedido, Entrega_idEntrega) VALUES
(1, 1),
(2, 2),
(3, 3);

-- PEDIDO E NOME DO CLIENTE
SELECT P.idPedido, C.Nome, C.CPF_CNPJ, P.StatusPedido, P.FreteValor, P.FormaPagamento_idFormaPagamento FROM Pedido AS P
INNER JOIN Cliente as C ON C.idCliente = P.Cliente_idCliente;

-- NUMERO DE PEDIDOS POR CLIENTES
SELECT COUNT(*) AS NumeroPedidosPorCliente, P.idPedido, C.Nome, C.CPF_CNPJ, P.StatusPedido, P.FreteValor, P.FormaPagamento_idFormaPagamento FROM Pedido AS P
INNER JOIN Cliente as C ON C.idCliente = P.Cliente_idCliente GROUP BY P.idPedido;
    
    
-- VALOR TOTAL DO PEDIDO
SELECT SUM(ValorTotal) FROM (SELECT Pedido_idPedido, Quantidade AS QtdProduto, DescricaoProduto, Valor as ValUnitario, Valor*Quantidade as ValorTotal
FROM produtopedido, produto WHERE Produto_idProduto = idProduto) AS A WHERE Pedido_idPedido = 2;

-- VALOR TOTAL DO PEDIDO COM GROUP BY
SELECT Pedido_idPedido, SUM(ValorTotal) FROM (SELECT Pedido_idPedido, Quantidade AS QtdProduto, DescricaoProduto, Valor as ValUnitario, Valor*Quantidade as ValorTotal
FROM produtopedido, produto WHERE Produto_idProduto = idProduto) AS A GROUP BY Pedido_idPedido;

	-- VALOR TOTAL DO PEDIDO COM GROUP BY
SELECT PP.Pedido_idPedido, SUM(ValorTotal) FROM (SELECT PP.Pedido_idPedido, PP.Quantidade AS QtdProduto, DescricaoProduto, P.Valor as ValUnitario, P.Valor*PP.Quantidade as ValorTotal
FROM produtopedido AS PP , produto AS P WHERE PP.Produto_idProduto = P.idProduto) AS A GROUP BY PP.Pedido_idPedido;

-- CONSULTA COM NOME, PEDIDO, VALOR UNITARIO E VALOR SOMADO DOS ITENS
SELECT A.Cliente_idCliente, AC.Nome, PP.Pedido_idPedido, PP.Quantidade AS QtdProduto, P.DescricaoProduto, P.Valor as ValUnitario, P.Valor*PP.Quantidade as ValorTotal
FROM produtopedido AS PP
INNER JOIN produto AS P ON PP.Produto_idProduto = P.idProduto
INNER JOIN pedido AS A ON A.idPedido = PP.Pedido_idPedido
INNER JOIN CLIENTE AS AC ON A.Cliente_idCliente = AC.idCliente;


-- CONSULTA DE VALOR TOTAL DE TODOS OS ITENS DO PEDIDO APRESENTANDO NOME DO CLIENTE
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
   
   -- CONSULTA DE VALOR TOTAL DE TODOS OS ITENS DO PEDIDO APRESENTANDO NOME DO CLIENTE UTILIZANDO HAVING
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




