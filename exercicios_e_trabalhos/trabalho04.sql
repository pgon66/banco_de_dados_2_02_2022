/*Criação do banco de dados.*/
CREATE DATABASE IF NOT EXISTS trabalhos_bd CHARACTER SET utf8mb4;

/*Informa o banco de dados a ser utilizado.*/
USE trabalhos_bd;

/*Deleta as tabelas, caso elas já existam.*/
DROP table IF EXISTS city;
DROP table IF EXISTS country;

/*Criação da tabela de países.*/
CREATE TABLE IF NOT EXISTS country (
    id_country INTEGER PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(32) NOT NULL
);

/*Cadastro dos países.*/
INSERT INTO country (country_name)
VALUES
('Austria'),
('Belgium'),
('Brazil'),
('England'),
('Germany'),
('Greece'),
('Lithuania'),
('Sweden');

/*Define uma ID para cada país, facilitando a referenciação em outras tabelas durante o cadastro.*/
SET @ID_AUSTRIA = (SELECT id_country FROM country WHERE country_name = 'Austria');
SET @ID_BELGIUM = (SELECT id_country FROM country WHERE country_name = 'Belgium');
SET @ID_BRAZIL = (SELECT id_country FROM country WHERE country_name = 'Brazil');
SET @ID_ENGLAND = (SELECT id_country FROM country WHERE country_name = 'England');
SET @ID_GERMANY = (SELECT id_country FROM country WHERE country_name = 'Germany');
SET @ID_GREECE = (SELECT id_country FROM country WHERE country_name = 'Greece');
SET @ID_LITHUANIA = (SELECT id_country FROM country WHERE country_name = 'Lithuania');
SET @ID_SWEDEN = (SELECT id_country FROM country WHERE country_name = 'Sweden');


/*Criação da tabela de cidades.*/
CREATE TABLE IF NOT EXISTS city (
    id_city INTEGER PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(32) NOT NULL,
    id_country INTEGER NOT NULL,
    FOREIGN KEY (id_country) REFERENCES country(id_country)
);

/*Cadastro das cidades.*/
INSERT INTO city (city_name, id_country)
VALUES
('Graz', @ID_AUSTRIA),
('Linz', @ID_AUSTRIA),
('Vienna', @ID_AUSTRIA),
('Bruxelas', @ID_BELGIUM),
('Mechelen', @ID_BELGIUM),
('Namur', @ID_BELGIUM),
('Curitiba', @ID_BRAZIL),
('Sao Bernardo do Campo', @ID_BRAZIL),
('Sao Paulo', @ID_BRAZIL),
('Dagenham', @ID_ENGLAND),
('Dover', @ID_ENGLAND),
('London', @ID_ENGLAND),
('Berlim', @ID_GERMANY),
('Munique', @ID_GERMANY),
('Stuttgart', @ID_GERMANY),
('Athens', @ID_GREECE),
('Patras', @ID_GREECE),
('Xanthi', @ID_GREECE),
('Alytus', @ID_LITHUANIA),
('Kaunas', @ID_LITHUANIA),
('Vilnius', @ID_LITHUANIA),
('Arboga', @ID_SWEDEN),
('Gothenburg', @ID_SWEDEN),
('Solna', @ID_SWEDEN);


/*Deleta a VIEW caso ela já exista.*/
DROP VIEW IF EXISTS select_all_cities;

/*Criação da VIEW.*/
CREATE 
    VIEW select_all_cities
AS (
    SELECT 
        city.city_name AS Cities,
        country.country_name AS Countries
    FROM 
        city
        INNER JOIN country 
            ON city.id_country = country.id_country
);

/*Faz o uso VIEW.*/
SELECT 'Using VIEW, listing cities and their countries' AS 'LOG';

SELECT * FROM select_all_cities;