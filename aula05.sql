CREATE DATABASE IF NOT EXISTS aprenderjoin CHARACTER SET utf8mb4;
USE aprenderjoin;

DROP table IF EXISTS restaurantes;
DROP table IF EXISTS cidade;
DROP table IF EXISTS estado;

CREATE TABLE estado (
    id_estado INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    regiao ENUM('sul','sudeste','centro-oeste','nordeste','norte')
);


CREATE TABLE cidade (
    id_cidade INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    id_estado INTEGER NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);


INSERT INTO
    estado (nome, regiao)
VALUES
    ('Parana','sul'),
    ('Sao Paulo','sudeste'),
    ('Rio de Janeiro','sudeste'),
    ('Bahia','nordeste'),
    ('Pernambuco','nordeste'),
    ('Para','norte'),
    ('Mato Grosso','centro-oeste');

SET @idParana:=(SELECT id_estado FROM estado WHERE estado.nome = "Parana");
SET @idSaoPaulo:=(SELECT id_estado FROM estado WHERE estado.nome = "Sao Paulo");
SET @idRioDeJaneiro:=(SELECT id_estado FROM estado WHERE estado.nome = "Rio de Janeiro");
SET @idBahia:=(SELECT id_estado FROM estado WHERE estado.nome = "Bahia");
SET @idPernambuco:=(SELECT id_estado FROM estado WHERE estado.nome = "Pernambuco");
SET @idPara:=(SELECT id_estado FROM estado WHERE estado.nome = "Para");
SET @idMatoGrosso:=(SELECT id_estado FROM estado WHERE estado.nome = "Mato Grosso");

INSERT INTO
    cidade (nome, id_estado) VALUES
    ('Curitiba', @idParana),
    ('Londrina', @idParana),
    ('Paranagua', @idParana),
    ('Sao Paulo', @idSaoPaulo),
    ('Sorocaba', @idSaoPaulo),
    ('Rio de Janeiro', @idRioDeJaneiro),
    ('Niteroi', @idRioDeJaneiro),
    ('Mage', @idRioDeJaneiro),
    ('Porto Real', @idRioDeJaneiro),
    ('Petropolis', @idRioDeJaneiro),
    ('Salvador', @idBahia),
    ('Feira de Santana', @idBahia),
    ('Recife', @idPernambuco),
    ('Olinda', @idBahia),
    ('Petrolina', @idBahia),
    ('Belem', @idPara),
    ('Cuiaba', @idMatoGrosso);

SELECT * FROM cidade;

SELECT
    *
FROM
    cidade
INNER JOIN
    estado ON cidade.id_estado = estado.id_estado
where
    cidade.nome = 'Petropolis';

CREATE TABLE restaurantes (
    id_restaurante INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao VARCHAR(255),
    id_cidade INTEGER NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

SET @idCuritibaCidade := (SELECT id_cidade FROM cidade WHERE cidade.nome = 'Curitiba');
SET @idSaoPauloCidade := (SELECT id_cidade FROM cidade WHERE cidade.nome = 'Sao Paulo');
SET @idRiodeJaneiroCidade := (SELECT id_cidade FROM cidade WHERE cidade.nome = 'Rio de Janeiro');
SET @idPetropolesCidade := (SELECT id_cidade FROM cidade WHERE cidade.nome = 'Petropolis');
SET @idFeiraDeSantanaCidade := (SELECT id_cidade FROM cidade WHERE cidade.nome = 'Feira de Santana');

SELECT @idFeiraDeSantanaCidade AS 'cidade';

INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('Comida Mineira', 'Comida tipica de Minas', @idCuritibaCidade),
    ('Fogo de chao', 'Costela de fogo de chao', @idSaoPauloCidade),
    ('Frangao', 'Frango', @idRiodeJaneiroCidade),
    ('Pizza Maromba', 'Pizza com muita proteina', @idPetropolesCidade),
    ('Pertuti', 'Restaurante', @idFeiraDeSantanaCidade);

SELECT * FROM restaurantes;

SELECT 
    * 
FROM 
    restaurantes
INNER JOIN cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE  
    restaurantes.nome = 'Comida Mineira';

SELECT 'Cidades antes -----------' AS 'INFO';

SELECT
    *
FROM
    cidade
INNER JOIN restaurantes ON restaurantes.id_cidade = cidade.id_cidade
WHERE  
    restaurantes.nome = 'Comida Mineira';

SELECT 
    cidade.nome             as nome_da_cidade,
    restaurantes.nome       as nome_do_restaurante,
    restaurantes.descricao  as descricao_do_restaurante
FROM
    cidade
INNER JOIN
    restaurantes
        ON restaurantes.id_cidade = cidade.id_cidade
WHERE   
    restaurantes.nome = 'Comida Mineira';

SELECT 'Com LIKE -----------' AS 'INFO';

SELECT 
    cidade.nome             as nome_da_cidade,
    restaurantes.nome       as nome_do_restaurante,
    restaurantes.descricao  as descricao_do_restaurante
FROM
    cidade
INNER JOIN
    restaurantes
        ON restaurantes.id_cidade = cidade.id_cidade
WHERE   
    restaurantes.nome LIKE '%M%';

SELECT 'Transformando em uma tabela -----------' AS 'INFO';

SELECT
    t1.nome_da_cidade,
    t1.nome_do_restaurante
FROM
(
    SELECT 
        cidade.nome             as nome_da_cidade,
        restaurantes.nome       as nome_do_restaurante,
        restaurantes.descricao  as descricao_do_restaurante
    FROM
        cidade
    INNER JOIN
        restaurantes
            ON restaurantes.id_cidade = cidade.id_cidade
    WHERE   
        restaurantes.nome LIKE '%M%'
) as t1

WHERE
    t1.nome_da_cidade = 'Curitiba';

SELECT 'Com mais de um INNER JOIN -----------' AS 'INFO';

SELECT
        cidade.nome             as nome_da_cidade,
        estado.nome             as nome_do_estado,
        restaurantes.nome       as nome_do_restaurante
FROM    
    restaurantes
INNER JOIN
    cidade
        ON restaurantes.id_cidade = cidade.id_cidade
INNER JOIN 
    estado
        ON cidade.id_estado = estado.id_estado
WHERE
    restaurantes.nome LIKE "Comida M%";