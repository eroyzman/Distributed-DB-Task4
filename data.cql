CREATE KEYSPACE IF NOT EXISTS store WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

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

DROP TABLE IF EXISTS store.orders;
CREATE TABLE IF NOT EXISTS store.orders (
    name text,
    order_date date,
    itemid uuid,
    total_sum int,
    items_id set<uuid>, 
    PRIMARY KEY ((name), order_date)
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Kien Lutz', 850, '2022-01-01',
  {
    9e4240d0-5cd7-48ea-b89f-6f1810e36ed5
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Kien Lutz', 1749, '2022-01-02',
  {
    9e4240d0-5cd7-48ea-b89f-6f1810e36ed5,
    b27b6519-b975-4647-ae12-ab0e06a449ab
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Blossom Reeve', 2748, '2022-01-02',
  {
    9e4240d0-5cd7-48ea-b89f-6f1810e36ed5,
    b27b6519-b975-4647-ae12-ab0e06a449ab,
    03d30b14-f4f3-4aa6-8acc-e7e4e87aecf0
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Blossom Reeve', 3748, '2022-01-03',
  {
    9e4240d0-5cd7-48ea-b89f-6f1810e36ed5,
    b27b6519-b975-4647-ae12-ab0e06a449ab,
    03d30b14-f4f3-4aa6-8acc-e7e4e87aecf0,
    7f9235ed-e5dd-455d-81d4-2c469e54db8f
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Blossom Reeve', 2476, '2022-01-04',
  {
    3c07a8c0-d7b7-4d8a-af98-fd7a24817699,
    4c548d20-bdff-4668-9cda-e8b9f4b5ee3b,
    e14eebe8-84d8-4d76-b13f-5cd1f4272a2b,
    124fbe68-67fb-42b4-93be-84690629fdde,
    c0654e66-e7c6-4f4a-bb40-09444bd42173
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Arion Lees', 5376, '2022-01-04',
  {
    3c07a8c0-d7b7-4d8a-af98-fd7a24817699,
    4c548d20-bdff-4668-9cda-e8b9f4b5ee3b,
    e14eebe8-84d8-4d76-b13f-5cd1f4272a2b,
    124fbe68-67fb-42b4-93be-84690629fdde,
    c0654e66-e7c6-4f4a-bb40-09444bd42173,
    b680b778-25d0-4287-a27c-c9cc5397530b,
    9a716fb1-48d5-4059-b8e6-8eea159ff28c,
    668c98da-e78c-43ca-82a0-c986431f568e,
    4286d789-29ed-401e-8ace-782fecfd30be,
    d3a8b6a3-daea-4c8c-b917-78e08d719963
  }
);

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Arion Lees', 5376, '2022-01-04',
  {
    809e3ff1-64cc-41c3-96d6-2eb4a2049e53,
    fb927668-6579-46b5-b968-0b36441f929e,
    1478b3f2-3aef-43dc-bbd3-3db77145af37
  }
  );

SELECT * FROM store.orders
WHERE name = 'Blossom Reeve'
ORDER BY order_date ASC;

CREATE INDEX IF NOT EXISTS items_id_idx
ON store.orders (items_id);

SELECT * FROM store.orders
WHERE name = 'Blossom Reeve'
AND items_id CONTAINS 03d30b14-f4f3-4aa6-8acc-e7e4e87aecf0;

SELECT itemid FROM store.orders
WHERE name = 'Blossom Reeve'
AND order_date > '2022-01-01' AND order_date < '2022-01-05';

SELECT COUNT(*) FROM store.orders
WHERE name = 'Blossom Reeve'
AND order_date > '2022-01-01' AND order_date < '2022-01-05';

SELECT SUM(total_sum) FROM store.orders
WHERE name = 'Blossom Reeve'
AND order_date > '2022-01-01' AND order_date < '2022-01-05';

SELECT itemid, MAX(total_sum) FROM store.orders
WHERE name = 'Blossom Reeve'
AND order_date > '2022-01-01' AND order_date < '2022-01-05';

UPDATE store.orders
SET items_id = items_id + {124fbe68-67fb-42b4-93be-84690629fdde},  total_sum = 3147
WHERE name = 'Blossom Reeve'
AND order_date = '2022-01-02';

SELECT WRITETIME (total_sum) FROM store.orders 
WHERE name = 'Blossom Reeve'
AND order_date > '2022-01-01' AND order_date < '2022-01-05';

INSERT INTO store.orders 
(itemid, name, total_sum, order_date, items_id) 
VALUES (uuid(), 'Tommy Bee', 5376, '2022-01-06',
{
809e3ff1-64cc-41c3-96d6-2eb4a2049e53,
fb927668-6579-46b5-b968-0b36441f929e,
1478b3f2-3aef-43dc-bbd3-3db77145af37
}
)
USING TTL 200;

SELECT TTL(total_sum) FROM store.orders
WHERE name = 'Tommy Bee'
AND order_date = '2022-01-06';

SELECT json name, order_date, itemid, items_id, total_sum from store.orders;

INSERT INTO store.orders JSON '{
    "name": "Desie Grase", 
    "order_date": "2022-01-01", 
    "itemid": "829aa84a-4bba-411f-a4fb-38167a987cda", 
    "items_id": ["9e4240d0-5cd7-48ea-b89f-6f1810e36ed5"], 
    "total_sum": 850}';





