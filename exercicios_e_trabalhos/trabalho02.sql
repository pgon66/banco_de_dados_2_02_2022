/* Alunos:  
Ernani da Paz
Pedro Tenchena Gonçalves       
 */
USE sakila;

SET
    @ID_CUSTOMER = (
        SELECT
            customer.customer_id
        FROM
            customer
        WHERE
            customer.address_id IN (
                SELECT
                    address_id
                FROM
                    address
                WHERE
                    city_id IN (
                        SELECT
                            city_id
                        FROM
                            city
                        WHERE
                            city = 'Caracas'
                    )
            )
    );

SELECT
    "Movies watched by residents of Caracas." AS 'INFO';

SELECT
    title AS 'Films',
    description AS 'Description'
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
                SELECT
                    rental.inventory_id
                FROM
                    rental
                WHERE
                    rental.customer_id = @ID_CUSTOMER
            )
    );