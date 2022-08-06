SELECT "USE MySQL database" AS "INFO";

USE mysql;

SELECT "Drop database aula01 if exist" AS "INFO";

DROP DATABASE IF EXISTS aula01;

SELECT "The creation of database" AS "INFO";

SELECT "USE MySQL database" AS "INFO";

CREATE DATABASE aula01;

SELECT "Create table alunos" AS "INFO";

USE aula01;

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id_student          INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    first_name          VARCHAR(255) NOT NULL,
    last_name           VARCHAR(255) NOT NULL,
    gender ENUM         ('MA', 'FE'),
    code_registration   INTEGER UNIQUE,
    status              BOOLEAN DEFAULT true,
    created_at          DATETIME DEFAULT NOW(),
    deleted_at          DATETIME
);

DESCRIBE students;

INSERT INTO students (first_name, last_name, gender, code_registration) 
VALUES ('Brunno', 'Oliveira', 'MA', 1),
       ('Douglas', 'Arving', 'MA', 2),
       ('Ernane', 'Paz', 'MA', 3);

SELECT * FROM students;