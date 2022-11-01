DROP DATABASE IF EXISTS learn_procedures;
CREATE DATABASE learn_procedures;
SET NAMES utf8mb4;

USE learn_procedures;

CREATE TABLE country (
    id_country INTEGER PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(255),
    continent VARCHAR(255)
);

INSERT INTO
    country (country_name, continent)
VALUES 
    ('Brazil', 'South America'),
    ('Paraguay', 'South America'),
    ('Uruguay', 'South America'),
    ('Peru', 'South America'),
    ('Lebanon', 'Asia'),
    ('United States of America', 'North America');

SHOW PROCEDURE STATUS;

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountry;
DROP PROCEDURE IF EXISTS SelectCountrySouthAmerica;
DROP PROCEDURE IF EXISTS SelectCountryArgRecive;

/* PROCEDURE que retorna todos os paises. */
CREATE PROCEDURE SelectCountry()
BEGIN
    SELECT * FROM country;
END $$

/* PROCEDURE que retorna todos os paises da America do Sul. */
CREATE PROCEDURE SelectCountrySouthAmerica()
BEGIN
    SELECT 'PROCEDURE - South America Countries' AS 'LOG';
    SELECT * FROM country WHERE continent = 'South America';
END $$

/* PROCEDURE que retorna o pais cujo o nome foi informado. */
CREATE PROCEDURE SelectCountryArgReceive(CountryName VARCHAR(255))
BEGIN 
    SELECT * FROM country WHERE country.country_name = CountryName;
END $$

DELIMITER ;

CALL SelectCountry;
CALL SelectCountrySouthAmerica;
CALL SelectCountryArgReceive ('Brazil');

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryInternArg;

/* PROCEDURE que retorna o pais cujo o nome foi informado internamente. */
CREATE PROCEDURE SelectCountryInternArg() 
BEGIN 
    DECLARE CountryName VARCHAR(255);
    SET CountryName = 'Brazil';

    SELECT * FROM country WHERE country.country_name = CountryName;
END $$

DELIMITER ;

CALL SelectCountryInternArg;

DELIMITER $$

DROP PROCEDURE IF EXISTS SelectCountryUsingIf;

CREATE PROCEDURE SelectCountryUsingIf(InputNumber INTEGER) 
BEGIN
    DECLARE CountryName VARCHAR(255);

    IF InputNumber = 1 THEN
       SET CountryName = 'Brazil';
    ELSEIF InputNumber = 2 THEN
       SET CountryName = 'Paraguay';
    ELSEIF InputNumber = 3 THEN
       SET CountryName = 'Uruguay';
    ELSEIF InputNumber = 4 THEN
       SET CountryName = 'Peru';
    ELSEIF InputNumber = 5 THEN
       SET CountryName = 'Lebanon';
    ELSEIF InputNumber = 6 THEN
       SET CountryName = 'United States of America';
    END IF;

    SELECT CountryName AS 'Country Selected';

    SELECT * FROM country WHERE country.country_name = CountryName;

END $$

DELIMITER ;

CALL SelectCountryUsingIf (6);

DELIMITER $$

CREATE PROCEDURE SelectCountryCase(InputNumber INTEGER)
BEGIN
    DECLARE CountryName VARCHAR(255);

    CASE
        WHEN InputNumber = 1 THEN 
            SET CountryName = 'Brazil';
        WHEN InputNumber =  2 THEN 
            SET CountryName = 'Paraguay';
        WHEN InputNumber =  3 THEN 
            SET CountryName = 'Uruguay';
        WHEN InputNumber =  4 THEN 
            SET CountryName = 'Peru';
        WHEN InputNumber =  5 THEN 
            SET CountryName = 'Lebanon';
        WHEN InputNumber =  6 THEN 
            SET CountryName = 'United States of America';
    END CASE;

    SELECT CountryName AS 'Country Selected';

    SELECT * FROM country WHERE country.country_name = CountryName;
END $$

DELIMITER ;

CALL SelectCountryCase (2);