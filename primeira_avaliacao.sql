/*Criação do banco de dados.*/
CREATE DATABASE IF NOT EXISTS primeira_avaliacao CHARACTER SET utf8mb4;

/*Informa o banco de dados a ser utilizado.*/
USE primeira_avaliacao;

/*Deleta as tabelas, caso elas já existam.*/
DROP TABLE IF EXISTS usuarios_produtos;
DROP TABLE IF EXISTS clientes_produtos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS fornecedores;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS cargos;

/*Criação da tabela de cargos.*/
CREATE TABLE IF NOT EXISTS cargos (
    id_cargo INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cargo_nome VARCHAR(255) NOT NULL
);

/*Cadastro dos cargos.*/
INSERT INTO cargos (cargo_nome)
VALUES
('Estoquista'),
('Vendedor'),
('Secretario'),
('Gerente'),
('Diretor');

/*Define uma ID para cada cargo, facilitando a referenciação em outras tabelas durante o cadastro.*/
SET @ID_ESTOQUISTA = (SELECT id_cargo FROM cargos WHERE cargo_nome = 'Estoquista');
SET @ID_VENDEDOR = (SELECT id_cargo FROM cargos WHERE cargo_nome = 'Vendedor');
SET @ID_SECRETARIO = (SELECT id_cargo FROM cargos WHERE cargo_nome = 'Secretario');
SET @ID_GERENTE = (SELECT id_cargo FROM cargos WHERE cargo_nome = 'Gerente');
SET @ID_DIRETOR = (SELECT id_cargo FROM cargos WHERE cargo_nome = 'Diretor');


/*Criação da tabela de usuarios/funcionários.*/
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cargo_usuario INTEGER NOT NULL,
    FOREIGN KEY (cargo_usuario) REFERENCES cargos(id_cargo)
);

/*Cadastro dos funcionários, utilizando as ID's geradas.*/
INSERT INTO usuarios (nome, endereco, cargo_usuario) 
VALUES
('Marcos Silveira', 'Rua 2 de Fevereiro, 1605', @ID_DIRETOR),
('Joao da Silva', 'Rua 24 de Novembro, 345', @ID_GERENTE),
('Fatima Alves', 'Avenida Doutor Vicente, 45', @ID_SECRETARIO),
('Telmo Falcao', 'Rua Brito Borges, 522', @ID_VENDEDOR),
('Luisa Assis', 'Rua Severino Teixeira, 72', @ID_VENDEDOR),
('Laudemar Pacheco', 'Rua Roraima, 500', @ID_ESTOQUISTA);


/*Criação da tabela de forncedores.*/
CREATE TABLE IF NOT EXISTS fornecedores (
    id_fornecedor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(50) NOT NULL,
    cnpj_fornecedor VARCHAR(18) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

/*Cadastro dos fornecedores.*/
INSERT INTO fornecedores (nome_fornecedor, cnpj_fornecedor, endereco)
VALUES
('Nescau', '00.000.000/0000-01','Rua Capitao Airton Araujo, SN'),
('Caboclo', '00.000.000/0000-02','Avenida Jose Benassi, 1000'),
('Ouro Fino', '00.000.000/0000-03','Estrada de Ouro Fino, SN');

/*Define uma ID para cada fornecedor, facilitando a referenciação em outras tabelas durante o cadastro.*/
SET @ID_NESCAU = (SELECT id_fornecedor FROM fornecedores WHERE nome_fornecedor = 'Nescau');
SET @ID_CABOCLO = (SELECT id_fornecedor FROM fornecedores WHERE nome_fornecedor = 'Caboclo');
SET @ID_OURO_FINO = (SELECT id_fornecedor FROM fornecedores WHERE nome_fornecedor = 'Ouro Fino');


/*Criação da tabela de produtos.*/
CREATE TABLE IF NOT EXISTS produtos (
    id_produto INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(50) NOT NULL,
    preco_compra DECIMAL(5,2) NOT NULL,
    preco_venda DECIMAL(5,2) NOT NULL,
    quantidade INTEGER NOT NULL,
    id_fornecedor INTEGER NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

/*Cadastro dos produtos, utilizando as ID's geradas.*/
INSERT INTO produtos (nome_produto, preco_compra, preco_venda, quantidade, id_fornecedor)
VALUES
('Achocolatado em Po', '6.09', '7.19', 360, @ID_NESCAU),
('Chocolate Nescau', '5.27', '6.99', 126, @ID_NESCAU),
('Nescau Cereal', '20.13', '23.57', 64, @ID_NESCAU),
('Cafe Tradicional', '12.06', '14.99', 80, @ID_CABOCLO),
('Garrafa de Agua 6L', '8.90', '10.89', 48, @ID_OURO_FINO),
('Garrafa de Agua 300ml', '1.62', '2.45', 96, @ID_OURO_FINO);

/*Define uma ID para cada produto, facilitando a referenciação em outras tabelas durante o cadastro.*/
SET @ID_ACHOCOLATADO = (SELECT id_produto FROM produtos WHERE nome_produto = 'Achocolatado em Po');
SET @ID_CHOCOLATE = (SELECT id_produto FROM produtos WHERE nome_produto = 'Chocolate Nescau');
SET @ID_CEREAL = (SELECT id_produto FROM produtos WHERE nome_produto = 'Nescau Cereal');
SET @ID_CAFE = (SELECT id_produto FROM produtos WHERE nome_produto = 'Cafe Tradicional');
SET @ID_AGUA_6L = (SELECT id_produto FROM produtos WHERE nome_produto = 'Garrafa de Agua 6L');
SET @ID_AGUA_300ML = (SELECT id_produto FROM produtos WHERE nome_produto = 'Garrafa de Agua 300ml');

/*Criação da tabela de clientes.*/
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    documento VARCHAR(18) NOT NULL,
    telefone VARCHAR(14) NOT NULL
);

/*Cadastro dos clientes.*/
INSERT INTO clientes (nome, endereco, documento, telefone)
VALUES
('Fernando Lucas', 'Rua Jose Menezes, 64', '000.000.000-01', '(41)90000-0000'),
('Lucilene Lopez', 'Rua Alfredo Schramm, 87', '000.000.000-02', '(41)91000-0000'),
('Rosangela Camelo', 'Rua Santa Rosa, 2240', '000.000.000-03', '(41)92000-0000');

/*Criação da tabela de compras realizadas pelos clientes.*/
CREATE TABLE IF NOT EXISTS clientes_produtos (
    id_cliente INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

/*Cadastra os produtos adquiridos pelos cliente.*/
INSERT INTO clientes_produtos (id_cliente, id_produto)
VALUES
((SELECT id_cliente FROM clientes WHERE nome = 'Fernando Lucas'), @ID_CAFE),
((SELECT id_cliente FROM clientes WHERE nome = 'Fernando Lucas'), @ID_AGUA_300ML),
((SELECT id_cliente FROM clientes WHERE nome = 'Fernando Lucas'), @ID_CEREAL),
((SELECT id_cliente FROM clientes WHERE nome = 'Rosangela Camelo'), @ID_CAFE),
((SELECT id_cliente FROM clientes WHERE nome = 'Rosangela Camelo'), @ID_CHOCOLATE);

/*Criação da tabela das vendas realizadas pelos funcionários.*/
CREATE TABLE IF NOT EXISTS usuarios_produtos (
    id_usuario INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

/*Cadastra os produtos vendidos pelos funcionários.*/
INSERT INTO usuarios_produtos (id_usuario, id_produto)
VALUES
((SELECT id_usuario FROM usuarios WHERE nome = 'Luisa Assis'), @ID_CAFE),
((SELECT id_usuario FROM usuarios WHERE nome = 'Luisa Assis'), @ID_AGUA_300ML),
((SELECT id_usuario FROM usuarios WHERE nome = 'Luisa Assis'), @ID_CEREAL),
((SELECT id_usuario FROM usuarios WHERE nome = 'Luisa Assis'), @ID_CAFE),
((SELECT id_usuario FROM usuarios WHERE nome = 'Luisa Assis'), @ID_CHOCOLATE);

/*SUBSELECT - Exercicio 1*/

SELECT
    "Compras Realizadas - SUBSELECT" AS "Exercicio 1";

SELECT
    (SELECT clientes.nome FROM clientes WHERE id_cliente IN (SELECT id_cliente FROM clientes_produtos WHERE clientes_produtos.id_produto = produtos.id_produto) LIMIT 1) as Cliente,
    (SELECT clientes.telefone FROM clientes WHERE id_cliente IN (SELECT id_cliente FROM clientes_produtos WHERE clientes_produtos.id_produto = produtos.id_produto) LIMIT 1) as Telefone,
    produtos.nome_produto AS Produto,
    (SELECT fornecedores.nome_fornecedor FROM fornecedores WHERE id_fornecedor IN (SELECT id_fornecedor FROM fornecedores WHERE produtos.id_fornecedor = fornecedores.id_fornecedor) LIMIT 1) as Fornecedor,
    produtos.quantidade AS Estoque
FROM
    produtos
WHERE
    id_produto IN (
        SELECT
            id_produto
        FROM
            clientes_produtos
    )
LIMIT 3;

/*SUBSELECT ORDER BY - Exercicio 2*/


SELECT
    "Compras Realizadas - ORDER BY" AS "Exercicio 2";

SELECT
    (SELECT clientes.nome FROM clientes WHERE id_cliente IN (SELECT id_cliente FROM clientes_produtos WHERE clientes_produtos.id_produto = produtos.id_produto) LIMIT 1) as Cliente,
    (SELECT clientes.telefone FROM clientes WHERE id_cliente IN (SELECT id_cliente FROM clientes_produtos WHERE clientes_produtos.id_produto = produtos.id_produto) LIMIT 1) as Telefone,
    produtos.nome_produto AS Produto,
    (SELECT fornecedores.nome_fornecedor FROM fornecedores WHERE id_fornecedor IN (SELECT id_fornecedor FROM fornecedores WHERE produtos.id_fornecedor = fornecedores.id_fornecedor) LIMIT 1) as Fornecedor,
    produtos.quantidade AS Estoque
FROM
    produtos
WHERE
    id_produto IN (
        SELECT
            id_produto
        FROM
            clientes_produtos
    )
ORDER BY
    produtos.quantidade DESC
LIMIT 3 ;


/*INNER JOIN - Exercicio 3*/

SELECT
    "Compras Realizadas - INNER JOIN" AS "Exercicio 3";

SELECT
    clientes.nome AS Cliente,
    clientes.telefone AS Telefone,
    produtos.nome_produto AS Produto,
    fornecedores.nome_fornecedor AS Fornecedor,
    produtos.quantidade AS Estoque,
    produtos.preco_compra AS Preco_de_Compra
FROM
    clientes
INNER JOIN  
    clientes_produtos
    ON clientes.id_cliente = clientes_produtos.id_cliente
INNER JOIN
    produtos
    ON clientes_produtos.id_produto = produtos.id_produto
INNER JOIN
    fornecedores
    ON produtos.id_fornecedor = fornecedores.id_fornecedor
ORDER BY
    produtos.preco_compra DESC;


/*LEFT JOIN - Exercicio 4*/

SELECT
    "Compras Realizadas - LEFT JOIN" AS "Exercicio 4";

SELECT
    clientes.nome AS Cliente,
    clientes.telefone AS Telefone,
    produtos.nome_produto AS Produto,
    fornecedores.nome_fornecedor AS Fornecedor,
    produtos.quantidade AS Estoque,
    produtos.preco_compra AS Preco_de_Compra
FROM
    clientes
LEFT JOIN  
    clientes_produtos
    ON clientes.id_cliente = clientes_produtos.id_cliente
LEFT JOIN 
    produtos
    ON clientes_produtos.id_produto = produtos.id_produto
LEFT JOIN 
    fornecedores
    ON produtos.id_fornecedor = fornecedores.id_fornecedor
ORDER BY
    produtos.preco_compra DESC;