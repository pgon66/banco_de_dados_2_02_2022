USE aulaview;

DROP TABLE IF EXISTS comp_vend_carro;
DROP TABLE IF EXISTS compradores;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS carros;

DROP VIEW IF EXISTS select_vendas;

CREATE TABLE carros (
    id_carro INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INTEGER NOT NULL
);

INSERT INTO carros (nome, marca, ano) 
VALUES 
('Chevette', 'Chevrolet', 1992),
('Gol', 'Volkswagen', 2010),
('Onix', 'Chevrolet', 2020);

CREATE TABLE vendedores (
    id_vendedor INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(50) NOT NULL
);

INSERT INTO vendedores (nome, sobrenome, cpf) 
VALUES
('Jose', 'Silva', '000.000.000-01'),
('Fabio', 'Lima', '000.000.000-02');

CREATE TABLE compradores (
    id_comprador INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    cpf VARCHAR(50) NOT NULL
);

INSERT INTO compradores (nome, sobrenome, cpf) 
VALUES
('Odair', 'Silveira', '000.000.000-03'),
('Marcos', 'Couto', '000.000.000-04');

CREATE TABLE comp_vend_carro (
    id_comp_vend_carro INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_comprador INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    id_carro INTEGER NOT NULL,
    FOREIGN KEY (id_carro) REFERENCES carros(id_carro),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador)
);

INSERT INTO comp_vend_carro (id_carro, id_vendedor, id_comprador)
VALUES
((SELECT id_carro FROM carros WHERE nome = 'Chevette'), (SELECT id_vendedor FROM vendedores WHERE nome = 'Jose'), (SELECT id_comprador FROM compradores WHERE nome = 'Odair')),
((SELECT id_carro FROM carros WHERE nome = 'Onix'), (SELECT id_vendedor FROM vendedores WHERE nome = 'Jose'), (SELECT id_comprador FROM compradores WHERE nome = 'Marcos')),
((SELECT id_carro FROM carros WHERE nome = 'Gol'), (SELECT id_vendedor FROM vendedores WHERE nome = 'Fabio'), (SELECT id_comprador FROM compradores WHERE nome = 'Odair'));

CREATE 
    VIEW select_vendas
AS (
    SELECT 
        comp_vend_carro.id_carro,
        comp_vend_carro.id_vendedor,
        comp_vend_carro.id_comprador
    FROM 
        comp_vend_carro
    WHERE  
        comp_vend_carro.id_vendedor = (SELECT id_vendedor FROM vendedores WHERE nome = 'Jose')
);

SELECT 'Vendas realizadas pelo vendedor Jose' AS 'LOG';

SELECT * FROM select_vendas;