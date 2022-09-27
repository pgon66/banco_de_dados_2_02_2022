USE sakila;

DROP TABLE editora;

CREATE TABLE IF NOT EXISTS editora (
    editora_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

INSERT INTO
    editora (nome, endereco)
VALUES
    ('Abril', 'Rua Abcd 111'),
    ('Madras', 'Rua Dcb 222'),
    ('Globo', 'Rua Xsg 222');

    /* SHOW INDEX FROM editora; */
    /* EXPLAIN SELECT * FROM editora WHERE nome = 'Globo'; */

    CREATE INDEX idx_editora ON editora(nome);
    SHOW INDEX FROM editora;

    /*SELECIONA O TITULO E DESCRICAO DO FILME ALUGADO*/

    CREATE INDEX idx_customer ON customer(email);

    EXPLAIN SELECT 
        film.title
    FROM
        customer
    INNER JOIN rental ON
        customer.customer_id = rental.customer_id
    INNER JOIN inventory ON
        inventory.inventory_id = rental.inventory_id
    INNER JOIN film ON
        film.film_id = inventory.film_id
    WHERE
        customer.email = 'JENNIFER.DAVIS@sakilacustomer.org';

    CREATE INDEX idx_film_title ON film(title);

    EXPLAIN SELECT 
        film.title
    FROM
        customer
    INNER JOIN rental ON
        customer.customer_id = rental.customer_id
    INNER JOIN inventory ON
        inventory.inventory_id = rental.inventory_id
    INNER JOIN film ON
        film.film_id = inventory.film_id
    WHERE
        customer.email = 'JENNIFER.DAVIS@sakilacustomer.org';
