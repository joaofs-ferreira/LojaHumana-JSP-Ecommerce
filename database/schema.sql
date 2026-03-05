## Base de Dados (mySql)

CREATE DATABASE loja_humana;
USE loja_humana;

CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE Loja (
    loja_id INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(100) NOT NULL
);

CREATE TABLE Categoria (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Produto (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL,
    categoria_id INT,
    loja_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id),
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);

CREATE TABLE Pedido (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE NOT NULL,
    total_pedido DECIMAL(10,2),
    cliente_id INT,
    loja_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);

CREATE TABLE ItensPedido (
    itenspedido_id INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    pedido_id INT,
    produto_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);
