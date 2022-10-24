/*Criação do banco de dados.*/
CREATE DATABASE IF NOT EXISTS trabalhos_bd CHARACTER SET utf8mb4;

/*Informa o banco de dados a ser utilizado.*/
USE trabalhos_bd;

/*Deleta as tabelas, caso elas já existam.*/
DROP TABLE IF EXISTS goncalves;
DROP TABLE IF EXISTS pedro;

/*Criação da primeira tabela.*/
CREATE TABLE IF NOT EXISTS pedro (
    id_pedro INTEGER PRIMARY KEY AUTO_INCREMENT,
    rg VARCHAR(255) NOT NULL
);

/*Criação da segunda tabela.*/
CREATE TABLE IF NOT EXISTS goncalves (
    id_goncalves INTEGER PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(255) NOT NULL,
    id_pedro INTEGER,
    FOREIGN KEY (id_pedro) REFERENCES pedro(id_pedro)
);

/*Cadastro dos RG's.*/
INSERT INTO pedro (rg) 
VALUES
('32.532.402-5'),
('35.281.492-5'),
('37.246.375-7'),
('45.907.169-5');

/*Define uma ID para cada RG, facilitando a referenciação em outras tabelas durante o cadastro.*/
SET @ID_RG1 = (SELECT id_pedro FROM pedro WHERE rg = '32.532.402-5');
SET @ID_RG2 = (SELECT id_pedro FROM pedro WHERE rg = '35.281.492-5');
SET @ID_RG3 = (SELECT id_pedro FROM pedro WHERE rg = '37.246.375-7');
SET @ID_RG4 = (SELECT id_pedro FROM pedro WHERE rg = '45.907.169-5');

/*Cadastro dos CPF's.*/
INSERT INTO goncalves (cpf, id_pedro) 
VALUES
('401.482.090-41', @ID_RG1),
('295.296.240-50', @ID_RG2),
('450.722.970-71', @ID_RG3),
('662.072.650-09', @ID_RG4);

SET autocommit=0;

/*Inicia o TRANSACTION, e deleta o CPF selecionado*/
START TRANSACTION;
DELETE FROM goncalves WHERE cpf = '662.072.650-09';

/*Mostra a tabela antes do ROLLBACK*/
SELECT "BEFORE ROLLBACK" AS 'LOG';
SELECT * FROM goncalves;

/*Realiza o ROLLBACK*/
ROLLBACK;

/*Mostra a tabela depois do ROLLBACK*/
SELECT "AFTER ROLLBACK" AS 'LOG';
SELECT * FROM goncalves;

SET autocommit=1;

/*Cria o Trigger*/
DELIMITER $$
    CREATE TRIGGER trigger_pedro AFTER INSERT ON pedro
        FOR EACH ROW
            BEGIN
                UPDATE
                goncalves
                SET
                cpf = '401.482.090-40'
                WHERE 
                goncalves.id_goncalves = 1;
            END $$
DELIMITER ;

/*Insere um novo registro a tabela.*/
INSERT INTO pedro (rg) 
VALUES
('32.532.999-9');

/*Exibe os dados.*/
SELECT * FROM pedro;
SELECT * FROM goncalves;