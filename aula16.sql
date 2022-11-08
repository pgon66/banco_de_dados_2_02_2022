USE learn_procedures;

DROP PROCEDURE IF EXISTS SelectCountry;

DELIMITER $$

CREATE PROCEDURE SelectLoopLabel()
BEGIN
    DECLARE ctr INT;
    SET ctr = 0;

    loop_label: LOOP 
        IF ctr > 10 THEN
            LEAVE loop_label;
        END IF;
        SELECT ctr AS 'CTR';
        SET ctr = ctr + 1;
    END LOOP;

END $$

DELIMITER ;

CALL SelectLoopLabel ();