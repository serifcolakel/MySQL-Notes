# -- ile satır açıklama satırı olarak,

# USE metodu kullanılacak veri tabanını seçmemize yarar.
USE store; 

# ORDER BY (argüman) -> tablonun argümanına göre sıralamak için,
SELECT *
FROM customers
WHERE customer_id = 1
ORDER BY phone;

# SELECT (argüman) seçilecek table sütünu { info: " (*) ise tüm sütünlar " },
# FROM (argüman) -> argümana göre hangi tablo seçimi,
SELECT customer_id, first_name, points
FROM customers
WHERE customer_id = 1;

# Direkt olarak matematiksel işlemler uygulanabilir. AS ile set name
# AS (argüman) -> değişken (argüman) olarak tanımlanması için, 
	# argüman da boşluk girmek için tırnak içerisinde olmalı,
SELECT 
	customer_id, 
	first_name, 
    points, 
    points + 20 AS "multiple point", 
    points / 5,
    (points + 10 ) * 100 AS discount_factor
FROM customers;

SELECT state FROM customers;

SELECT * FROM store.customers;

# store.customers altındaki id'si 1 olan elemanın city değerinin "Waltham" olarak set et.
UPDATE `store`.`customers` SET `city` = 'Waltham' WHERE (`customer_id` = '1');

# DISTINCT -> ile eşşiz elemanları getirmek için,
SELECT DISTINCT state FROM customers;  

SELECT 
	name, 
	unit_price, 
    unit_price * 1.1 AS calculated_price, 
    quantity_in_stock * 2.55 
FROM products;

# Comparison Opretors -> 
	# > (gt), 
    # >= (gte), 
    # < (lt), 
    # <= (lte), 
    # = (equality),  
    # != (not equal), <> (not equal)
# WHERE (argüman) -> tablonun argümanına göre şartlı seçme için,
SELECT *
FROM customers
WHERE points > 3000;
SELECT *
FROM customers
WHERE state = 'va';
SELECT *
FROM customers
WHERE state != 'va';
SELECT *
FROM customers
WHERE state <> 'va';
SELECT *
FROM customers
WHERE birth_date > '1995-01-01';
SELECT * 
FROM orders 
WHERE order_date >= '2019-01-01';

# AND (Tüm şartlar doğru ise), OR (En az biri doğru ise) & NOT ()
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000;

# AND operator ilk çalışır sonrasında OR çalışır öncelik sırasından dolayı
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

# NOT ile parantez önemli şartı sağlamayanlar gelecek...
SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
# Yukarısı ile aynı NOT parantez içine dağıldı.
SELECT *
FROM customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;

# IN operators -> Birden fazla (veya) sorgu da kullanılır
SELECT *
FROM customers
#WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
WHERE state IN ('VA', 'FL', 'GA');
SELECT *
FROM customers
#WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
WHERE state NOT IN ('VA', 'FL', 'GA');
SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

# BETWEEN OPERATOR -> BETWEEN (GTE) AND (LTE)
SELECT *
FROM customers
WHERE points >= 1000 AND points <= 3000;
SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

# LIKE OPERATOR LIKE (VALUE) {info (%): any number of characters, info (_): single character }
	# VALUE = 'A%' -> string A veya a ile başlayanları,
	SELECT *
	FROM customers
	WHERE last_name LIKE 'b%';
	# VALUE = '%A' -> string A veya a ile bitenleri,
	SELECT *
	FROM customers
	WHERE last_name LIKE '%Y';
	# VALUE = '%A%' -> string A veya a'yı HERHANGİ BİR YERİNDE içerenleri,
	SELECT *
	FROM customers
	WHERE last_name LIKE '%Z%';
	# VALUE = '_A' -> stringin UNDERSCORE kadar elemanları herhangi bir şey olabilir bir sonraki karakteri A veya a olmalı,
	SELECT *
	FROM customers
	WHERE last_name LIKE '_y';
	# VALUE = '___A' -> stringin ilk 4 elemanı herhangi bir şey olabilir bir sonraki karakteri A veya a olmalı,
	SELECT *
	FROM customers
	WHERE last_name LIKE '____y';
	# VALUE = 'b__A' -> stringin ilk elemanı b veya B olurken 2., 3. ve 4. elemanı herhangi bir şey olabilir ve bir sonraki karakteri A veya a olmalı,
	SELECT *
	FROM customers
	WHERE last_name LIKE 'b____y';
	#EXamples
    SELECT * 
    FROM customers
    WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
	SELECT * 
    FROM customers
    WHERE phone LIKE '%9'; # phone number end with 9
	SELECT * 
    FROM customers
    WHERE phone NOT LIKE '%9' # phone number end without 9;











