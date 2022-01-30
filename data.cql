-- Ops
-- SELECT * FROM store.items
-- ORDER BY price DESC;

-- DROP TABLE store.items;

-- Create a keyspace
CREATE KEYSPACE IF NOT EXISTS store WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

-- DROP TABLE IF EXISTS store.items;
-- CREATE TABLE IF NOT EXISTS store.items (
--     category text, 
--     itemid uuid, 
--     brand text, 
--     model text, 
--     price int,
--     features map<text, text>,
--     PRIMARY KEY (category, itemid, features)
-- );

DROP MATERIALIZED VIEW IF EXISTS store.items_by_name;
CREATE MATERIALIZED VIEW IF NOT EXISTS store.items_by_name AS
  SELECT category, itemid, brand, model, price, features
  FROM store.items
  WHERE brand  IS NOT NULL
    AND category  = 'Tablet'
    AND price IS NOT NULL
  PRIMARY KEY (brand, category, price);

SELECT * FROM store.items_by_name
WHERE brand = 'Apple';

DROP MATERIALIZED VIEW IF EXISTS store.items_by_price_interval;
CREATE MATERIALIZED VIEW IF NOT EXISTS store.items_by_price_interval AS
  SELECT category, itemid, brand, model, price, features
  FROM store.items
  WHERE category = 'Tablet'
    AND price > 700 AND price < 1000
  PRIMARY KEY (category, price);

SELECT * FROM store.items_by_price_interval;

DROP MATERIALIZED VIEW IF EXISTS store.items_by_brand_and_price;
CREATE MATERIALIZED VIEW IF NOT EXISTS store.items_by_brand_and_price AS
  SELECT category, itemid, brand, model, price, features
  FROM store.items
  WHERE brand IS NOT NULL
    AND category = 'Tablet'
    AND price > 500
  PRIMARY KEY (brand, category, price);

SELECT * FROM store.items_by_brand_and_price
WHERE brand = 'SAMSUNG';

DROP MATERIALIZED VIEW IF EXISTS store.items_by_param;
CREATE MATERIALIZED VIEW IF NOT EXISTS store.items_by_param AS
  SELECT category, itemid, brand, model, price, features
  FROM store.items
  WHERE brand IS NOT NULL
  AND category IS NOT NULL
  AND price IS NOT NULL
  PRIMARY KEY (brand, category, price);

SELECT * FROM store.items_by_param;

DROP MATERIALIZED VIEW IF EXISTS store.items_by_param_and_value;
CREATE MATERIALIZED VIEW IF NOT EXISTS store.items_by_param_and_value AS
  SELECT category, itemid, brand, model, price, features
  FROM store.items
  WHERE brand IS NOT NULL
  AND category IS NOT NULL
  AND price = 500
  PRIMARY KEY (brand, category, price);

SELECT * FROM store.items_by_param_and_value;

UPDATE store.items
SET model = 'X2.1'
WHERE category = 'Tablet'
AND price = 500;

SELECT * FROM store.items_by_param_and_value;

ALTER TABLE store.items
ADD comment text;

SELECT * FROM store.items;



-- INSERT INTO store.items
-- (category, itemid, brand, model, price, features)
-- VALUES ('Cell Phone', uuid(), 'AT&T', 'Calypso', 200, 
-- {'manufacturer':'EMBLEM',
--  'memory_capacity': '16 GB',
--  'MPN':'U318AA',
--  'color_category':'Blue'
-- });

-- INSERT INTO store.items
-- (category, itemid, brand, model, price, features)
-- VALUES ('Cell Phone', uuid(), 'AT&T', 'Calypso - 2', 200, 
-- {'manufacturer':'EMBLEM',
--  'memory_capacity': '24 GB',
--  'MPN':'U318AA',
--  'color_category':'Blue'
-- });

-- CREATE INDEX IF NOT EXISTS items_idx
-- ON store.items ( VALUES(features) );

-- SELECT *
-- FROM store.items
-- WHERE features[ 'manufacturer' ] = 'EMBLEM';

-- DROP TABLE IF EXISTS store.items;
-- CREATE TABLE IF NOT EXISTS store.items (
--     category text, 
--     itemid uuid, 
--     brand text, 
--     model text, 
--     price int,
--     features map<text, text>,
--     PRIMARY KEY (category, itemid, price)
-- ) 
-- WITH CLUSTERING ORDER BY (itemid DESC, price DESC);

DROP TABLE IF EXISTS store.items;
CREATE TABLE IF NOT EXISTS store.items (
    category text,
    price int, 
    itemid uuid, 
    brand text, 
    model text, 
    features map<text, text>,
    PRIMARY KEY (category, price)
);

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'AT&T', 'Calypso', 200, 
{'manufacturer':'EMBLEM',
 'memory_capacity': '16 GB',
 'MPN':'U318AA',
 'color_category':'Blue'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'AT&T', 'Motivate', 233, 
{'manufacturer':'EMBLEM',
 'memory_capacity': '16 GB',
 'MPN':'V341U',
 'color_category':'Blue'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'Apple', '13', 700, 
{'manufacturer':'Apple Ltd.',
 'memory_capacity': '128 GB',
 'RAM': '6 GB',
 'virtual_assistant': 'Siri',
 'MPN':'MLML3LL/A',
 'color_category':'Black'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'Apple', '13 Pro Max', 900, 
{'manufacturer':'Apple Ltd.',
 'memory_capacity': '128 GB',
 'RAM': '8 GB',
 'virtual_assistant': 'Siri',
 'MPN':'GPAPI13PMC128GDP',
 'color_category':'Gold'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'SAMSUNG', 'Galaxy A10e', 399, 
{'manufacturer':'SAMSUNG',
 'memory_capacity': '32 GB',
 'CNT': 'CDMA',
 'MPN':'a10e',
 'color_category':'Gray'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Cell Phone', uuid(), 'SAMSUNG', 'Galaxy A01', 444, 
{'manufacturer':'SAMSUNG',
 'memory_capacity': '16 GB',
 'CNT': 'CDMA',
 'MPN':'a10eff',
 'color_category':'Black'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'SAMSUNG', 'UN65TU7000BXZA', 999, 
{'manufacturer':'SAMSUNG',
 'display_technology': 'HDR',
 'resolution': '4K UHD',
 'MPN':'UN65TU7000BXZA',
 'series': '7 Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'SAMSUNG', '65PFL5766/F7', 899, 
{'manufacturer':'SAMSUNG',
 'display_technology': 'LED',
 'resolution': '4K UHD',
 'MPN':'65PFL5766/F7',
 'series': '5700 Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'SAMSUNG', 'UN55TU7000BXZA', 1000, 
{'manufacturer':'SAMSUNG',
 'display_technology': 'Crystal UHD',
 'resolution': '4K UHD',
 'MPN':'UN55TU7000BXZA',
 'series': 'SP Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'Philips', '65PFL5766/F7', 1200, 
{'manufacturer':'Philips',
 'display_technology': 'LED',
 'resolution': '4K UHD',
 'MPN':'65PFL5766/F7',
 'series': '5700 Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'Philips', '65PFL5766222', 1000, 
{'manufacturer':'Philips',
 'display_technology': 'LED',
 'resolution': '4K UHD',
 'MPN':'65PFL5766222',
 'series': '5200 Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('TV & Video', uuid(), 'Philips', '65PFL5766222', 850, 
{'manufacturer':'Philips',
 'display_technology': 'LED',
 'resolution': '4K',
 'MPN':'65PFL5766222',
 'series': '5656 Series',
 'refresh_rate': '60 Hz'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'Apple', 'Mini', 450, 
{'manufacturer':'Apple Ltd.',
 'OS': 'iPadOS',
 'APW': '7.1 Ounces',
 'MPN':'MK2K3LL/A',
 'color': 'Gray'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'Apple', 'Mini Pro', 750, 
{'manufacturer':'Apple Ltd.',
 'OS': 'iPadOS',
 'APW': '8.5 Ounces',
 'MPN':'MK2K3LL2365',
 'color': 'Black'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'Apple', 'Mini Super Pro', 950, 
{'manufacturer':'Apple Ltd.',
 'OS': 'iPadOS',
 'APW': '12 Ounces',
 'MPN':'MK2K3LFFJF5',
 'color': 'White'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'SAMSUNG', 'X1', 350, 
{'manufacturer':'SAMSUNG',
 'OS': 'Android',
 'MPN':'FGKL786YUGH',
 'color': 'Gray'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'SAMSUNG', 'X2', 500, 
{'manufacturer':'SAMSUNG',
 'OS': 'Android',
 'MPN':'HFDJUFHN90874',
 'color': 'Red'
});

INSERT INTO store.items
(category, itemid, brand, model, price, features)
VALUES ('Tablet', uuid(), 'SAMSUNG', 'X3', 600, 
{'manufacturer':'SAMSUNG',
 'OS': 'Android',
 'MPN':'NFJKNDKJN',
 'color': 'Crey'
});

