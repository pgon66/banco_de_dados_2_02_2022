USE sakila;

/*SETA A ID DO USUÁRIO INFORMADO*/
SET
    @ID_CUSTOMER_SELECTED = (
        SELECT
            customer.customer_id
        FROM
            customer
        WHERE
            customer.email = 'KIM.CRUZ@sakilacustomer.org'
    );

/*SELECIONA A ID DO USUÁRIO INFORMADO*/
SELECT
    @ID_CUSTOMER_SELECTED AS 'ID_CUSTOMER_SELECTED';

/*SELECIONA O TITULO E DESCRICAO DO FILME ALUGADO*/
SELECT
    film.title,
    film.description
FROM
    film
WHERE
    film_id IN (
        SELECT
            inventory.film_id
        FROM
            inventory
        WHERE
            inventory.inventory_id IN (
                (
                    SELECT
                        rental.inventory_id
                    FROM
                        rental
                    WHERE
                        rental.customer_id = @ID_CUSTOMER_SELECTED
                )
            )
    );

/*SELECIONA O ID DOS ATORES DOS FILMES*/
SELECT
    DISTINCT film_actor.film_id
FROM
    film_actor
WHERE
    film_id IN (
        SELECT
            inventory.film_id
        FROM
            inventory
        WHERE
            inventory.inventory_id IN (
                (
                    SELECT
                        rental.inventory_id
                    FROM
                        rental
                    WHERE
                        rental.customer_id = @ID_CUSTOMER_SELECTED
                )
            )
    );

/*SELECIONA E MOSTRA O NOME DOS ATORES DOS FILMES*/
SELECT
    actor.first_name,
    actor.last_name
FROM
    actor
WHERE
    actor_id IN (
        SELECT
            actor_id
        FROM
            film
        WHERE
            film_id IN (
                SELECT
                    inventory.film_id
                FROM
                    inventory
                WHERE
                    inventory.inventory_id IN (
                        (
                            SELECT
                                rental.inventory_id
                            FROM
                                rental
                            WHERE
                                rental.customer_id = @ID_CUSTOMER_SELECTED
                        )
                    )
            )
    )