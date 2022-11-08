DROP DATABASE IF EXISTS calendars;
CREATE DATABASE calendars;

USE calendars;

DROP TABLE IF EXISTS calendars;

CREATE TABLE calendars (
    id INT AUTO_INCREMENT,
    fulldate DATE UNIQUE,
    day TINYINT NOT NULL,
    month TINYINT NOT NULL,
    quarter TINYINT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY(id)
);

DELIMITER $$

CREATE PROCEDURE InsertCalendar(dt DATE)
BEGIN
    INSERT INTO calendars(fulldate, day, month, quarter, year)
    VALUES(
    dt, 
    EXTRACT(DAY FROM dt), 
    EXTRACT(MONTH FROM dt), 
    EXTRACT(QUARTER FROM dt), 
    EXTRACT(YEAR FROM dt)
    );

END $$

DELIMITER ;

CALL InsertCalendar("2022-11-07");

DELIMITER $$

CREATE PROCEDURE LoadCalendars(
    starDate DATE,
    day INT
)
BEGIN

    DECLARE counter INT DEFAULT 1;
    DECLARE dt DATE DEFAULT starDate;

    WHILE counter <= day DO 
        CALL InsertCalendar(dt);
        SET counter = counter + 1;
        SET dt = DATE_ADD(dt, INTERVAL 1 day);
    END WHILE;

END $$

DELIMITER ;

CALL LoadCalendars("2021-11-07", 08);

DELIMITER $$

CREATE PROCEDURE RepeatDemo()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';

    REPEAT 
        SET result = CONCAT(result, counter, ',');
        SET counter = counter + 1;
    UNTIL counter >= 10
    END REPEAT;

    SELECT result;
END $$

DELIMITER ;
 
 CALL RepeatDemo();
