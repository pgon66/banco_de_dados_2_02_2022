CREATE DATABASE IF NOT EXISTS trabalhos_bd CHARACTER SET utf8mb4;

USE trabalhos_bd;

DROP table IF EXISTS pet;

/*CRIA A TABELA PET*/
CREATE TABLE pet (
    id_pet INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL,
    type ENUM('DOG', 'CAT'),
    breed VARCHAR(32),
    created_at DATETIME DEFAULT NOW()
);

DESCRIBE pet;

SELECT
    "Insert new pets in a table" AS "INFO";

/*CADASTRA OS PETS NA TABELA*/
INSERT INTO
    pet (name, type, breed)
VALUES
    ('Luck', 'DOG', 'Shih-tzu'),
    ('Bella', 'DOG', 'Labrador'),
    ('Zeus', 'DOG', 'Golden'),
    ('Thor', 'DOG', 'Pug'),
    ('Layla', 'DOG', 'Poodle'),
    ('Oscar', 'DOG', 'Husky'),
    ('Chico', 'DOG', 'SRD'),
    ('Bidu', 'DOG', 'Bulldogue'),
    ('Pingo', 'DOG', 'Chihuahua'),
    ('Buddy', 'DOG', 'Terrier'),
    ('Frajola', 'CAT', 'SRD'),
    ('Magali', 'CAT', 'Siames'),
    ('Bito', 'CAT', 'Angora'),
    ('Bonny', 'CAT', 'Persa'),
    ('Duda', 'CAT', 'Ragdoll'),
    ('Nico', 'CAT', 'Siberiano'),
    ('Pituca', 'CAT', 'Kinkalow'),
    ('Snow', 'CAT', 'Korat'),
    ('Popo', 'CAT', 'Thai'),
    ('Nina', 'CAT', 'Cymric');

/*MOSTRA TODOS OS PETS CADASTRADOS*/
SELECT
    "Select pets" AS "INFO";

SELECT
    pet.name,
    pet.type,
    pet.breed,
    pet.created_at
FROM
    pet;

/*MOSTRA OS PETS DE ACORDO COM A ORDEM DE INSERÇÃO*/
SELECT
    "Select pets in order of insertion" AS "INFO";

SELECT
    pet.name,
    pet.type,
    pet.breed,
    pet.created_at
FROM
    pet
ORDER BY
    pet.created_at ASC;

/*MOSTRA 3 PETS DE ACORDO COM A ORDEM DE INSERÇÃO*/
SELECT
    "Select three pets in order of insertion" AS "INFO";

SELECT
    pet.name,
    pet.type,
    pet.breed,
    pet.created_at
FROM
    pet
ORDER BY
    pet.created_at DESC
LIMIT
    3;