USE SAKILA;

SELECT
    "Movies watched by residents of Caracas, using INNER JOIN." AS 'INFO';

SELECT DISTINCT
    film.title AS Filme,
    film.description AS Descricao
FROM
    city
    INNER JOIN address 
        ON city.city_id = address.city_id
    INNER JOIN customer 
        ON customer.address_id = address.address_id
    INNER JOIN rental 
        ON rental.customer_id = customer.customer_id
    INNER JOIN inventory
        ON inventory.inventory_id = rental.inventory_id
    INNER JOIN film
        ON film.film_id = inventory.film_id
WHERE
    city.city = "Caracas";