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

SET autocommit=1;

/*Cria o Trigger*/
DELIMITER $$
    CREATE TRIGGER trigger_pedro AFTER INSERT ON pedro
        FOR EACH ROW
            BEGIN
                UPDATE
                goncalves
                SET
                cpf = '088.000.999-99'
                WHERE 
                goncalves.id_goncalves = 1;
            END $$
DELIMITER ;

/*Insere um novo registro a tabela.*/
START TRANSACTION;
    INSERT INTO pedro (rg) VALUES ('39.826.352-8');
    INSERT INTO goncalves (cpf, id_pedro) VALUES ('339.163.968-70', (SELECT id_pedro FROM pedro WHERE rg = '39.826.352-8'));

    /*Exibe a tabela com os dados inseridos*/
    SELECT "BEFORE ROLLBACK" AS 'LOG'; 
    SELECT pedro.rg AS RG, goncalves.cpf AS CPF FROM pedro INNER JOIN goncalves ON pedro.id_pedro = goncalves.id_goncalves;
ROLLBACK;

/*Exibe a tabela após o ROLLBACK*/
SELECT "AFTER ROLLBACK" AS 'LOG';
SELECT pedro.rg AS RG, goncalves.cpf AS CPF FROM pedro INNER JOIN goncalves ON pedro.id_pedro = goncalves.id_goncalves;
    
/*Insere um novo registro a tabela.*/
START TRANSACTION;
    INSERT INTO pedro (rg) VALUES ('39.826.352-8');
    INSERT INTO goncalves (cpf, id_pedro) VALUES ('339.163.968-70', (SELECT id_pedro FROM pedro WHERE rg = '39.826.352-8'));
COMMIT;

/*Exibe a tabela após o COMMIT*/
SELECT "BEFORE COMMIT" AS 'LOG'; 
SELECT pedro.rg AS RG, goncalves.cpf AS CPF FROM pedro INNER JOIN goncalves ON pedro.id_pedro = goncalves.id_goncalves;
    
DELIMITER $$

/*Deleta a procedure, caso ela já exista.*/
DROP PROCEDURE IF EXISTS LeftJoinTables;

/*Criação da PROCEDURE.*/
CREATE PROCEDURE LeftJoinTables()
BEGIN
    SELECT "PROCEDURE - LEFT JOIN" AS 'LOG'; 
    SELECT 
        pedro.id_pedro AS ID,
        pedro.rg AS RG,
        goncalves.cpf AS CPF  
    FROM 
        pedro 
    LEFT JOIN goncalves ON 
        pedro.id_pedro = goncalves.id_pedro;
END $$

/*Faz o uso da PROCEDURE.*/
CALL LeftJoinTables();