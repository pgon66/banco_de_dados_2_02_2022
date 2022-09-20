USE aprendendoleft;

DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;

CREATE TABLE b (
    id_b INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_b VARCHAR(30) NOT NULL
);

INSERT INTO b (name_b)
VALUES ('q'), ('w'), ('e'), ('r'), ('t'), ('y'), ('u');


CREATE TABLE a (
    id_a INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_a VARCHAR(30) NOT NULL,
    id_b INTEGER,
    FOREIGN KEY (id_b) REFERENCES b(id_b)
);

INSERT INTO a (name_a, id_b)
VALUES  ('a', (SELECT id_b FROM b WHERE name_b = 'q')),
        ('s', (SELECT id_b FROM b WHERE name_b = 'r')),
        ('d', NULL),
        ('f', (SELECT id_b FROM b WHERE name_b = 't')),
        ('g', NULL),
        ('h', NULL),
        ('j', NULL),
        ('k', (SELECT id_b FROM b WHERE name_b = 'u')),
        ('l', NULL);

SELECT
    *
FROM
    b
WHERE
    b.id_b NOT IN (
        SELECT
            b.id_b
        FROM
            b
            INNER JOIN a ON b.id_b = a.id_b
);