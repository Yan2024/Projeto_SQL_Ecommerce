-- Criação de banco de dados para cenário de E-commerce
create database ecommerce;
use ecommerce;

-- Criação da tabela Cliente
create table Cliente(
	idCliente INT PRIMARY KEY UNIQUE AUTO_INCREMENT,	
    CPF INT(11) UNIQUE NOT NULL,
    Primeiro_Nome VARCHAR(15) NOT NULL, 
    Inicial_Nome_Meio VARCHAR(1),
    Sobrenome VARCHAR(20) NOT NULL,
    Endereço VARCHAR(45) NOT NULL,
    Data_Nascimento DATE);
    
-- Criação da tabela Produto
create table Produto(
	idProduto INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    Nome_Produto VARCHAR(45) NOT NULL,
    Categoria ENUM('Eletrônico','Vestimenta','Brinquedo','Alimento','Móvel') NOT NULL,
    Descrição VARCHAR(45),
    Valor FLOAT NOT NULL);
    
-- Criação da tabela Pedido
create table Pedido(
	idPedido INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    Status_Pedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL,
    Descrição VARCHAR(45),
    Frete FLOAT,
    FOREIGN KEY (Chave_Estrangeira_de_Cliente) REFERENCES Cliente(idCliente));
    
-- Criação da tabela Pagamentos
create table Pagamento(
	idPagamento INT PRIMARY KEY UNIQUE AUTO_INCREMENT,
    Tipo_Pagamento ENUM('Boleto', 'Cartão', 'Dinheiro', 'Pix'),
    FOREIGN KEY (Chave_Estrangeira_de_Cliente) REFERENCES Cliente(idCliente))

-- Recuperações simples com SELECT Statement:

-- Recuperar todos os clientes: 

SELECT * FROM Cliente;

-- Recuperar todos os produtos:

SELECT * FROM Produto;

-- Recuperar todos os pedidos:

SELECT * FROM Pedido;

-- Filtros com WHERE Statement:

-- Recuperar clientes com nome "Yan":

SELECT * FROM Cliente WHERE Nome = 'Yan';

-- Recuperar produtos com preço acima de 200:

SELECT * FROM Produto WHERE Preco > 200;

-- Recuperar pedidos feitos após uma determinada data:

SELECT * FROM Pedido WHERE Data > '2023-08-01';

-- Recuperar o nome completo (concatenando nome e sobrenome) dos clientes:

SELECT CONCAT(Nome, ' ', Sobrenome) AS NomeCompleto FROM Cliente;

-- Recuperar o preço total de cada pedido (somando o preço de todos os produtos do pedido):

SELECT Pedido.ID, SUM(Produto.Preco) AS PrecoTotal
FROM Pedido
JOIN DetalhesPedido ON Pedido.ID = DetalhesPedido.Pedido_ID
JOIN Produto ON DetalhesPedido.Produto_ID = Produto.ID
GROUP BY Pedido.ID;

-- Definição de ordenações dos dados com ORDER BY:

SELECT * FROM Produto ORDER BY Nome;

-- Recuperar todos os pedidos ordenados por data em ordem decrescente:

SELECT * FROM Pedido ORDER BY Data DESC;

-- Recuperar pedidos com um valor total acima de 500:

SELECT Pedido.ID, SUM(Produto.Preco) AS PrecoTotal
FROM Pedido
JOIN DetalhesPedido ON Pedido.ID = DetalhesPedido.Pedido_ID
JOIN Produto ON DetalhesPedido.Produto_ID = Produto.ID
GROUP BY Pedido.ID
HAVING PrecoTotal > 500;