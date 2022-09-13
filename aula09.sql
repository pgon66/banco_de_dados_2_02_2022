USE sakila;

SELECT 'Creating a view' as 'LOG';

DROP VIEW IF EXISTS select_all_actors;

CREATE 
    VIEW select_all_actors
AS (
    SELECT 
        actor.first_name,
        actor.last_name,
        actor.last_update
    FROM 
        actor
    WHERE  
        actor.first_name LIKE "C%"
);

SELECT 'Using' AS 'LOG';

SELECT * FROM select_all_actors;