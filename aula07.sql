DROP DATABASE IF EXISTS aprendendoleft;
CREATE DATABASE aprendendoleft;

USE aprendendoleft;

DROP TABLE IF EXISTS classe;
DROP TABLE IF EXISTS alunos;

CREATE TABLE classe (
    id_classe INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_classe VARCHAR(100) NOT NULL,
    ano VARCHAR(4) NOT NULL,
    descricao TEXT
);

CREATE TABLE alunos (
    id_aluno INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
);

CREATE TABLE professores (
    id_professor INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    documento VARCHAR(255) NOT NULL,
    id_classe INTEGER,
    FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
);

INSERT INTO classe (nome_classe, descricao, ano) 
VALUES
('A', 'Turma que entrou no inicio do ano', '2021'),
('B', 'Turma que entrou no meio do ano', '2021');

INSERT INTO alunos (nome, sobrenome, documento, id_classe) VALUES
('Brunno', 'Sobrenome do Brunno', 'XXX.XXX.XXX-XX', 1),
('Alexandre', 'Sobrenome do Alexandre', 'XXX.XXX.XXX-XX', 1),
('Bryan', 'Sobrenome do Bryan', 'XXX.XXX.XXX-XX', 1),
('Leandro', 'Sobrenome do Leandro', 'XXX.XXX.XXX-XX', 1),
('Lucas', 'Sobrenome do Lucas', 'XXX.XXX.XXX-XX', 2),
('Aryon', 'Sobrenome do Aryon', 'XXX.XXX.XXX-XX', 2),
('Raphael', 'Sobrenome do Raphael', 'XXX.XXX.XXX-XX', 2),
('Leticia', 'Sobrenome do Leticia', 'XXX.XXX.XXX-XX', 2),
('Pedro', 'Sobrenome do Pedro', 'XXX.XXX.XXX-XX', 2),
('Guilherme', 'Sobrenome do Guilherme', 'XXX.XXX.XXX-XX', 2);

INSERT INTO alunos (nome, sobrenome, documento) VALUES
('Ernani', 'Sobrenome do Ernani', 'XXX.XXX.XXX-XX');

SELECT 'ALUNOS - INNER JOIN' AS 'LOG';
 
SELECT 
    alunos.nome 
FROM 
    alunos
INNER JOIN 
    classe 
        ON alunos.id_classe = classe.id_classe;

SELECT 'ALUNOS - LEFT JOIN' AS 'LOG';
 
SELECT 
    alunos.nome 
FROM 
    alunos
LEFT JOIN 
    classe 
        ON alunos.id_classe = classe.id_classe;

SELECT 'ALUNOS - RIGHT JOIN' AS 'LOG';
 
SELECT 
    alunos.nome 
FROM 
    classe
RIGHT JOIN 
    alunos 
        ON alunos.id_classe = classe.id_classe;

INSERT INTO professores (
    nome,
    sobrenome,
    documento,
    id_classe
) VALUES
('Professor A', 'Sobrenome o Professor A', 'XXX.XXX.XXX-XX', 1),
('Professor B', 'Sobrenome o Professor B', 'XXX.XXX.XXX-XX', 1),
('Professor C', 'Sobrenome o Professor C', 'XXX.XXX.XXX-XX', 2),
('Professor D', 'Sobrenome o Professor D', 'XXX.XXX.XXX-XX', 2);

INSERT INTO professores (
    nome,
    sobrenome,
    documento
) VALUES
('Professor E', 'Sobrenome o Professor E', 'XXX.XXX.XXX-XX');

SELECT 'PROFESSORES - INNER JOIN' AS 'LOG';
 
SELECT 
    professores.nome 
FROM 
    professores
INNER JOIN 
    classe 
        ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES - LEFT JOIN' AS 'LOG';

SELECT professores.nome
FROM
    professores
    LEFT JOIN
        classe 
            ON professores.id_classe = classe.id_classe;

SELECT 'PROFESSORES - RIGHT JOIN' AS 'LOG';

SELECT professores.nome
FROM
    professores
    RIGHT JOIN
        classe 
            ON professores.id_classe = classe.id_classe;