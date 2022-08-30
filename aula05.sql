CREATE DATABASE IF NOT EXISTS aprenderjoin CHARACTER SET utf8mb4;
USE aprenderjoin;


DROP TABLE IF EXISTS garcom_restaurantes;
DROP TABLE IF EXISTS garcom;
DROP table IF EXISTS restaurantes;
DROP table IF EXISTS cidade;
DROP table IF EXISTS estado;

CREATE TABLE estado (
    id_estado INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    regiao ENUM('SUL','SUDESTE','CENTRO-OESTE','NORDESTE','NORTE')
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
    ('Parana','SUL'),
    ('Sao Paulo','SUDESTE'),
    ('Rio de Janeiro','SUDESTE'),
    ('Bahia','NORDESTE'),
    ('Pernambuco','NORDESTE'),
    ('Para','NORTE'),
    ('Mato Grosso','CENTRO-OESTE');

SET @idParana:=(SELECT id_estado FROM estado WHERE estado.nome = "Parana");
SET @idSaoPaulo:=(SELECT id_estado FROM estado WHERE estado.nome = "Sao Paulo");
SET @idRioDeJaneiro:=(SELECT id_estado FROM estado WHERE estado.nome = "Rio de Janeiro");
SET @idBahia:=(SELECT id_estado FROM estado WHERE estado.nome = "Bahia");
SET @idPernambuco:=(SELECT id_estado FROM estado WHERE estado.nome = "Pernambuco");
SET @idPara:=(SELECT id_estado FROM estado WHERE estado.nome = "Para");
SET @idMatoGrosso:=(SELECT id_estado FROM estado WHERE estado.nome = "Mato Grosso");

INSERT INTO cidade (nome, id_estado) VALUES 
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
    ('Olinda', @idPernambuco),
    ('Petrolina', @idPernambuco),   
    ('Belem', @idPara),
    ('Cuiaba', @idMatoGrosso);


SELECT * FROM cidade;


SELECT nome FROM estado WHERE id_estado = (SELECT id_estado FROM cidade WHERE nome ='Petropolis');

SELECT 
    *
FROM 
    cidade
INNER JOIN 
    estado ON  estado.id_estado = cidade.id_estado 
WHERE
    cidade.nome = 'Petropolis';



CREATE TABLE restaurantes (
    id_restaurante INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao VARCHAR(255),
    id_cidade INTEGER,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

SET @idCuritibaCidade := (SELECT    id_cidade       FROM cidade WHERE nome = 'Curitiba');
SET @idSaoPauloCidade := (SELECT    id_cidade       FROM cidade WHERE nome = 'Sao Paulo');
SET @idRiodeJaneiroCidade := (SELECT id_cidade   FROM cidade WHERE nome = 'Rio de Janeiro');
SET @idPetropolesCidade := (SELECT id_cidade     FROM cidade WHERE nome = 'Petropolis');
SET @idFeiraDeSantanaCidade := (SELECT id_cidade FROM cidade WHERE nome = 'Feira de Santana');

select @idFeiraDeSantanaCidade AS 'cidade';

INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('Comida Mineira','Comida tipica de Minas.',@idCuritibaCidade),
    ('Fogo de Chao','Costela de fogo de chao',@idSaoPauloCidade),
    ('Frangão','Frango',@idRiodeJaneiroCidade),
    ('Pizza Maromba','Pizza com muita proteina',@idPetropolesCidade),
    ('Pertuti','Restaurante',@idFeiraDeSantanaCidade);


SELECT * FROM restaurantes;



SELECT 'restaurantes antes -------------' AS 'INFO';

SELECT 
    *
FROM
    restaurantes
INNER JOIN cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome = 'Comida Mineira';

SELECT 'cidades antes -------------' AS 'INFO';

SELECT 
    *
FROM
    cidade
INNER JOIN restaurantes ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome = 'Comida Mineira';




SELECT 'controlando colunas -------------' AS 'INFO';


SELECT 
    cidade.nome            AS nome_da_cidade,
    restaurantes.nome      AS nome_do_restaurante,
    restaurantes.descricao AS descricao_do_restaurante
FROM
    cidade
INNER JOIN 
    restaurantes 
        ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome = 'Comida Mineira';



SELECT 'com like -------------' AS 'INFO';


SELECT 
    cidade.nome            AS nome_da_cidade,
    restaurantes.nome      AS nome_do_restaurante,
    restaurantes.descricao AS descricao_do_restaurante
FROM
    cidade
INNER JOIN 
    restaurantes 
        ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    restaurantes.nome LIKE '%M%';



SELECT 'transformando em uma tabela -------------' AS 'INFO';

SELECT
    t1.nome_da_cidade,
    t1.nome_do_restaurante
FROM
(
    SELECT 
        cidade.nome            AS nome_da_cidade,
        restaurantes.nome      AS nome_do_restaurante,
        restaurantes.descricao AS descricao_do_restaurante
    FROM
        cidade
    INNER JOIN 
        restaurantes 
            ON restaurantes.id_cidade = cidade.id_cidade
    WHERE
        restaurantes.nome LIKE '%M%'
) as t1  

WHERE
    t1.nome_da_cidade = 'Curitiba'
;



SELECT 'com mais de um INNER JOIN -------------' AS 'INFO';

SELECT 
    cidade.nome AS nome_da_cidade,
    estado.nome AS nome_do_estado,
    restaurantes.nome AS nome_do_restaurante
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





INSERT INTO restaurantes (nome, descricao) VALUES
    ('Sem Cidade','Restaurante que nao pertece a nenhuma cidade');


SELECT 
    "Fazendo busca com cidade na esquerda em registro sem relacao entre ambas tabelas"
AS
    "LOG";

SELECT
    * 
FROM
    cidade
INNER JOIN
    restaurantes
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Sem Cidade';


SELECT 
    "Fazendo busca com restaurante na esquerda em registro sem relacao entre ambas tabelas"
AS
    "LOG";

SELECT
    * 
FROM
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade
WHERE
    restaurantes.nome = 'Sem Cidade';


SELECT 
    "Traga tudo"
AS
    "LOG";

SELECT
    cidade.nome,
    restaurantes.nome 
FROM
    restaurantes
INNER JOIN
    cidade
    ON
        cidade.id_cidade = restaurantes.id_cidade;


INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('Mc Donalds',  'Hambuguer e Batata Frita',             @idCuritibaCidade),
    ('Habbibs',     'Comida Arabe',           @idCuritibaCidade),
    ('Terrazo',     'Restaurante',   @idCuritibaCidade),
    ('Calabouco',   'Restaurante',       @idCuritibaCidade);


SELECT 
    * 
FROM 
    restaurantes
INNER JOIN 
    cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    cidade.nome = 'Curitiba';



INSERT INTO restaurantes (nome, descricao, id_cidade) VALUES
    ('Comida Mineira','Comida tipica de Minas',@idSaoPauloCidade);


SELECT 
    * 
FROM 
    restaurantes
INNER JOIN 
    cidade ON restaurantes.id_cidade = cidade.id_cidade
WHERE
    cidade.nome IN ('Curitiba','Sao Paulo');



CREATE TABLE garcom (
    id_garcom INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    experiencia ENUM('JUNIOR', 'PLENO', 'SENIOR'),
    tipo_documento ENUM('CPF','RG'),
    documento VARCHAR(255)
);

INSERT INTO 
    garcom (nome, experiencia, tipo_documento, documento)
VALUES
    ('Jorge','JUNIOR','CPF',    '10000000000'),
    ('Fernando','PLENO','CPF',  '20000000000'),
    ('Roberto','PLENO','RG',    '100000000'),
    ('Alexandre','PLENO','RG',  '200000000'),    
    ('Odair','PLENO','RG',      '300000000'),
    ('Gerson','SENIOR','CPF',   '30000000000'),
    ('Pedro','SENIOR','CPF',    '40000000000'),
    ('Joao','SENIOR','CPF',     '50000000000');

SELECT * FROM garcom;        



CREATE TABLE garcom_restaurantes (
    id_restaurante INTEGER NOT NULL,
    id_garcom INTEGER NOT NULL,
    dia_semana ENUM('SEGUNDA', 'TERCA', 'QUARTA', 'QUINTA', 'SEXTA', 'SABADO', 'DOMINGO'),
    FOREIGN KEY (id_restaurante) REFERENCES restaurantes(id_restaurante),
    FOREIGN KEY (id_garcom) REFERENCES garcom(id_garcom)        
);

INSERT INTO 
    garcom_restaurantes (id_restaurante, id_garcom, dia_semana)
VALUES
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'SEGUNDA'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'TERCA'
    ),

    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Sem Cidade'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'QUARTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'QUINTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'SEXTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Jorge'),
        'SEGUNDA'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'TERCA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'QUINTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Gerson'),
        'SEXTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'SEGUNDA'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'TERCA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Sem Cidade'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'QUARTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'QUINTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Calabouco'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Odair'),
        'SEXTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pizza Maromba'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'SEGUNDA'         
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Pertuti'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'TERCA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Sem Cidade'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'QUARTA'
    ),
    (
        (SELECT id_restaurante FROM restaurantes WHERE restaurantes.nome = 'Mc Donalds'),
        (SELECT id_garcom FROM garcom WHERE garcom.nome = 'Alexandre'),
        'QUINTA'
    );
    




SELECT
    garcom.nome AS nome_garcom,
    restaurantes.nome AS nome_restaurante,
    garcom_restaurantes.dia_semana AS dia_semana
FROM
    garcom
INNER JOIN
    garcom_restaurantes ON garcom.id_garcom = garcom_restaurantes.id_garcom
INNER JOIN
    restaurantes ON garcom_restaurantes.id_restaurante = restaurantes.id_restaurante
WHERE
    garcom.nome IN ('Jorge', 'Odair', 'Gerson'); 
