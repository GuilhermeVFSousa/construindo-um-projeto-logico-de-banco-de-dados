-- CRIAÇÃO DO BANCO DE DADOS PARA O CENÁRIO DE E-COMMERCE
CREATE DATABASE IF NOT EXISTS ECOMMERCE;
USE ECOMMERCE;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(45) NOT NULL,
  TipoCliente ENUM('Pessoa Fisica', 'Pessoa Juridica'),
  Endereco VARCHAR(45) NOT NULL,
  CPF_CNPJ VARCHAR(45) NOT NULL,
  DataNascimento DATE NOT NULL,
  PRIMARY KEY (idCliente),
  CONSTRAINT UNIQUE CPF_CNPJ_UNIQUE (CPF_CNPJ)
  );
  
  ALTER TABLE CLIENTE AUTO_INCREMENT = 1;
  
  DESC Cliente;

-- -----------------------------------------------------
-- Table Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Produto (
  idProduto INT NOT NULL AUTO_INCREMENT,
  Categoria VARCHAR(45),
  DescricaoProduto VARCHAR(45),
  PRIMARY KEY (idProduto)
  );
  
ALTER TABLE PRODUTO AUTO_INCREMENT = 1;

DESC Produto;

-- -----------------------------------------------------
-- Table FormaPagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS FormaPagamento (
  idFormaPagamento INT NOT NULL AUTO_INCREMENT,
  FormaPagamentoDescricao VARCHAR(45),
  PRIMARY KEY (idFormaPagamento)
    );
    
      ALTER TABLE FormaPagamento AUTO_INCREMENT = 1;

	DESC FormaPagamento;

-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL AUTO_INCREMENT,
  StatusPedido ENUM('Pendente', 'Confirmado', 'Cancelado', 'Em processamento') DEFAULT 'Em processamento',
  DescricaoPedido VARCHAR(45),
  Cliente_idCliente INT NOT NULL,
  FreteValor FLOAT DEFAULT 10.00,
  FormaPagamento_idFormaPagamento INT NOT NULL,
  PRIMARY KEY (idPedido, Cliente_idCliente, FormaPagamento_idFormaPagamento),
  CONSTRAINT fk_Pedido_Cliente
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente),
  CONSTRAINT fk_Pedido_FormaPagamento
    FOREIGN KEY (FormaPagamento_idFormaPagamento)
    REFERENCES FormaPagamento (idFormaPagamento)
    );
      ALTER TABLE Pedido AUTO_INCREMENT = 1;

    DESC Pedido;


-- -----------------------------------------------------
-- Table ProdutoPedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ProdutoPedido (
  Produto_idProduto INT NOT NULL,
  Pedido_idPedido INT NOT NULL,
  Quantidade INT DEFAULT 1,
  PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
  CONSTRAINT fk_Produto_Pedido_Produto
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_Produto_Pedido_Pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido)
    );

  ALTER TABLE ProdutoPedido AUTO_INCREMENT = 1;

DESC ProdutoPedido;

-- -----------------------------------------------------
-- Table Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Estoque (
  idEstoque INT NOT NULL AUTO_INCREMENT,
  Localizacao VARCHAR(45),
  Quantidade INT DEFAULT 0,
  PRIMARY KEY (idEstoque)
  );
  
  ALTER TABLE Estoque AUTO_INCREMENT = 1;

DESC Estoque;

-- -----------------------------------------------------
-- Table Produto_Em_Estoque
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Produto_Em_Estoque (
  Produto_idProduto INT NOT NULL,
  Estoque_idEstoque INT NOT NULL,
  Quantidade INT NULL,
  PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
  CONSTRAINT fk_Produto_Estoque_Produto
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_Produto_Estoque_Estoque
    FOREIGN KEY (Estoque_idEstoque)
    REFERENCES Estoque (idEstoque)
    );
DESC Produto_Em_Estoque;

-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  RazaoSocial VARCHAR(45),
  CNPJ_Fornecedor CHAR(15) UNIQUE,
  Contato1 VARCHAR(45),
  Contato2 VARCHAR(45),
  PRIMARY KEY (idFornecedor)
  );
  
    ALTER TABLE Fornecedor AUTO_INCREMENT = 1;

DESC Fornecedor;

-- -----------------------------------------------------
-- Table FornecimentoProduto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS FornecimentoProduto (
  Fornecedor_idFornecedor INT NOT NULL,
  Produto_idProduto INT NOT NULL,
  PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
  CONSTRAINT fk_Fornecedor_Produto_Fornecedor
    FOREIGN KEY (Fornecedor_idFornecedor)
    REFERENCES Fornecedor (idFornecedor),
  CONSTRAINT fk_Fornecedor_Produto_Produto
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto)
    );
DESC FornecimentoProduto;


-- -----------------------------------------------------
-- Table VendedorTerceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS VendedorTerceiro (
  idVendedorTerceiro INT NOT NULL AUTO_INCREMENT,
  RazaoSocial VARCHAR(45) NOT NULL,
  CNPJ_Vendedor CHAR(15) UNIQUE DEFAULT NULL,
  CPF_Vendedor CHAR(9) UNIQUE DEFAULT NULL,
  NomeFantasia VARCHAR(45) DEFAULT NULL,
  Contato1 VARCHAR(45),
  Contato2 VARCHAR(45),
  Endereco VARCHAR(45) NOT NULL,
  UF ENUM('SP') NOT NULL,
  PRIMARY KEY (idVendedorTerceiro)
  );
  
  ALTER TABLE VendedorTerceiro AUTO_INCREMENT = 1;

  DESC VendedorTerceiro;


-- -----------------------------------------------------
-- Table ProdutoVendedorTerceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ProdutoVendedorTerceiro (
  Produto_idProduto INT NOT NULL,
  VendedorTerceiro_idVendedorTerceiro INT NOT NULL,
  Quantidade INT DEFAULT 1,
  PRIMARY KEY (Produto_idProduto, VendedorTerceiro_idVendedorTerceiro),
  CONSTRAINT fk_Produto_VendedorTerceiro_Produto
    FOREIGN KEY (Produto_idProduto)
    REFERENCES Produto (idProduto),
  CONSTRAINT fk_Produto_VendedorTerceiro_VendedorTerceiro
    FOREIGN KEY (VendedorTerceiro_idVendedorTerceiro)
    REFERENCES VendedorTerceiro (idVendedorTerceiro)
    );
DESC ProdutoVendedorTerceiro;

-- -----------------------------------------------------
-- Table Entrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Entrega (
  idEntrega INT NOT NULL AUTO_INCREMENT,
  StatusEntrega VARCHAR(45),
  CodigoRastreio VARCHAR(45),
  PRIMARY KEY (idEntrega)
  );
  
  ALTER TABLE Entrega AUTO_INCREMENT = 1;

  DESC Entrega;


-- -----------------------------------------------------
-- Table PedidoEntrega
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PedidoEntrega (
  Pedido_idPedido INT NOT NULL,
  Entrega_idEntrega INT NOT NULL,
  PRIMARY KEY (Pedido_idPedido, Entrega_idEntrega),
  CONSTRAINT fk_Pedido_Entrega_Pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_Pedido_Entrega_Entrega
    FOREIGN KEY (Entrega_idEntrega)
    REFERENCES Entrega (idEntrega)
    );
DESC PedidoEntrega;