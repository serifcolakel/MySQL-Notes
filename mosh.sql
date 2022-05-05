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

# THE REGEXP OPERATOR
	# last_name REGEXP 'value' -> last_name içinde herhangi bir yerinde sadece value içerenleri çağıracak.
	SELECT * 
    FROM customers
    WHERE last_name REGEXP 'field';
    # last_name REGEXP '^value' -> last_name must start with value
	SELECT * 
    FROM customers
    WHERE last_name REGEXP '^field';
    # last_name REGEXP 'value$' -> last_name must end with value
	SELECT * 
    FROM customers
    WHERE last_name REGEXP 'field$';
	# last_name REGEXP 'valueFirst|valueSecond' -> last_name must contain one of valueFirst & valueSecond
    # value sayısı daha fazla da olabilir... last_name 'valueFirst|valueSecond|values....'
	SELECT * 
    FROM customers
    WHERE last_name REGEXP 'field|mac';
	SELECT * 
    FROM customers
    WHERE last_name REGEXP '^field|mac|rose';
	SELECT * 
    FROM customers
    WHERE last_name REGEXP 'field$|mac|rose';
	# last_name REGEXP '[gim]e' ->  last_name "ge", "ie", "me" içermelidir. 
    # Yani [] içindeki karakterler (g, i, e) ilk elemanı olurken diğer karakter ise [] dışında kalan karakter (e) olmalıdır.
	SELECT * 
    FROM customers
    WHERE last_name REGEXP '[gim]e';
	# last_name REGEXP 'e[fmq]' ->  last_name "ef", "em", "eq" içermelidir. 
    # Yani ilk karakter [] dışında kalan karakter (e)  olurken  [] içindeki karakterler (f, m, q) ise ikinci elemanı olmalıdır.
	SELECT * 
    FROM customers
    WHERE last_name REGEXP 'e[fmq]';
	# last_name REGEXP '[a-h]e' ->  last_name "ae", "eb", "ec", "ed", "ef", "eh" içermelidir. 
    # Yani ilk karakter [] içinde kalan karakterler (a'dan başlayıp h'a kadar alfabetik)  olurken  
    # [] dışında kalan karakter (e) ise ikinci elemanı olmalıdır.
	SELECT * 
    FROM customers
    WHERE last_name REGEXP '[a-h]e';
# ALL OF 
-- ^ beginning
-- $ end
-- | logical or	
-- [abcd] match any char
-- [a-e] a to e range all char
	# EXERCISE
    SELECT * 
    FROM customers 
    WHERE first_name REGEXP 'elka|ambur';
	SELECT * 
    FROM customers 
    WHERE last_name REGEXP 'ey$|on$';   
	SELECT * 
    FROM customers 
    WHERE last_name REGEXP '^my|se';   
	SELECT * 
    FROM customers 
    WHERE last_name REGEXP 'b[ru]';
	SELECT * 
    FROM customers 
    WHERE last_name REGEXP 'br|bu';
# NULL OPERATOR -> IS NULL mu check ediyorsun
	SELECT *
    FROM customers
    WHERE phone IS NULL;
	SELECT *
    FROM customers
    WHERE phone IS NOT NULL;
	# EXERCISE 
	SELECT *
    FROM orders
    WHERE shipper_id IS NULL;
# THE ORDER BY CLAUSE -> sort column
	SELECT * 
    FROM customers
    ORDER BY first_name;
    # Tersten sıralamak için
	SELECT * 
    FROM customers
    ORDER BY first_name DESC;
    # Ilk olarak state'e göre sonra ise firstname'e göre sıralayacak..
	SELECT * 
    FROM customers
    ORDER BY state,first_name;
	SELECT * 
    FROM customers
    ORDER BY state DESC,first_name;
	SELECT first_name, last_name
    FROM customers
    ORDER BY birth_date;
    # invalid column'a göre sıralama yapılabilir MySQL'de
	SELECT first_name, last_name, 10 AS points
    FROM customers
    ORDER BY points, first_name;
    #AVOID 1,2 yazılırsa 1 column sayısı olduğu için first_name'i ,2 ise last_name gösterir.
	SELECT first_name, last_name
    FROM customers
    ORDER BY 1, 2; 
    # EXERCISE
    SELECT *, quantity * unit_price AS total_price
    FROM order_items
    WHERE order_id = 2
    ORDER BY total_price DESC;
# LIMIT CLAUSE 
	# ILK 3 ADET customers table'sından veri gelecek.
	SELECT * 
    FROM customers 
    LIMIT 3;
    # LIMIT x, y -> Örnek olarak sayfamıda kullanıcıları listeliyoruz ve her bir sayfada
    # 3 customers old var sayalım. 7. customers'a yani sayfa 3'te bulunan customers'a gitmek
    # için x ile kaç adet geçeceğimizi seçiyoruz ve y ile sonrasında kaç adet alacağımızı belirliyoruz.
	SELECT * 
    FROM customers 
    LIMIT 6, 3; # 6. 7. ve 8. customers
	SELECT * 
    FROM customers 
    LIMIT 6, 1; # 7. customers
	# EXERCISE 
    SELECT *
    FROM customers
    ORDER BY points DESC
    LIMIT 3;
# INNER JOINS
	# join ile birden fazla tabloyu ON'dan sonra gelen şarta göre birleştirecek.
	SELECT *
    FROM orders
    JOIN customers 
		ON orders.customer_id = customers.customer_id;
	# Sadece order_id, first_nameü last_name'e göre seçilirse.
	SELECT order_id, first_name, last_name
    FROM orders
    JOIN customers 
		ON orders.customer_id = customers.customer_id;
	# customer_id'yi yazamıyoruz sutuna çünkü birden fazla aynı şey olduğu için 
    # order_id = customer_id olduğu için önüne nereden alındığını belirtmemiz gerekir.
	SELECT order_id, orders.customer_id, first_name, last_name
    FROM orders
    JOIN customers 
		ON orders.customer_id = customers.customer_id;
	# Birden fazla yerde orders ve customers'ı kullandık kısaltma ile göstermek için
    # orders o, customers c ile göstermek için böyle yazabiliyoruz.(syntax -> table shortcut)
	SELECT order_id, o.customer_id, first_name, last_name
    FROM orders o
    JOIN customers c
		ON o.customer_id = c.customer_id;
	# EXERCISE
    SELECT order_id, oi.product_id, quantity, oi.unit_price
    FROM order_items oi 
    JOIN products p 
		ON oi.product_id = p.product_id;
    
    # JOINING ACROSS DATABASES
    # Kullanılan veri tabanı ile birleştirilen veri tabanı farklı ise aşağıdaki 
    # gibi işlem yapılır.
    USE sql_store;
    SELECT * 
    FROM sql_store.order_items oi
    JOIN sql_inventory.products p
		ON oi.product_id = p.product_id;
    
    # SELF JOINS
    ## Kendisi ile birleşme
    USE sql_hr;
    SELECT * 
    FROM employees e
    JOIN employees m
		ON e.reports_to = m.employee_id;
    ## Neden e yada m olarak kısaltmalar olarak adlandırdık 
    ## çünkü bu itemler 2 tabloda da mevcut
    ## Başkası ile birleştirme ile tamamen aynı sadece takma adlar farklı olmalı...
    USE sql_hr;
    SELECT 
		e.employee_id,
        e.first_name,
        m.first_name AS manager_name
    FROM employees e 
    JOIN employees m
		ON e.reports_to = m.employee_id;
    # JOINING MULTIPLE TABLES
    USE sql_store;
    SELECT 
		o.order_id,
        o.order_date,
        c.first_name,
        c.last_name,
        os.name AS status
    FROM orders o
    JOIN customers c
		ON o.customer_id = c.customer_id
	JOIN order_statuses os
		ON o.status = os.order_status_id;
    ## EXERCISE
	USE sql_invoicing;
    SELECT 
		p.date,
        p.invoice_id,
        p.amount,
        c.name,
        pm.name
    FROM payments p
    JOIN clients c
		ON p.client_id = c.client_id
	JOIN payment_methods pm
		ON p.payment_method = pm.payment_method_id;
    # COMPOUND JOIN CONDITIONS
    ## Burada ise şartlı olarak birden fazla veri tabanı birleştirme yapıyoruz.
	USE sql_store;
    SELECT *
    FROM order_items oi
    JOIN order_item_notes oin
		ON oi.order_id = oin.order_Id
        AND oi.product_id = oin.product_id;
    # IMPLICIT JOIN SYNTAX
    ### YOL - 1
    USE sql_store;
    SELECT * 
    FROM orders o
    JOIN customers c
		ON o.customer_id = c.customer_id;
	### YOL - 2 -> implicit join syntax
    SELECT * 
    FROM orders o, customers c
    WHERE o.customer_id = c.customer_id;
    # OUTER JOINS
    ## left join seçilirse joinden sonraki customers tablosuna ON'da bulunan şarta bakılmadan döndürülür.
    ## right join seçilirse joinden sonraki orders tablosuna ON'da bulunan şarta bakılmadan döndürülür.
    USE sql_store;
	SELECT 
		c.customer_id,
        c.first_name,
        o.order_id
    from customers c #Left table ilk ile son gibiler left ile right
    left join orders o #right table ilk ile son gibiler left ile right
    # Right ile aynı sonuç için
    # from orders o
	# right join customers c
		on c.customer_id = o.customer_id
    order by c.customer_id;
    # EXERCISE
	USE sql_store;
    SELECT 
		p.product_id,
        p.name,
        oi.quantity
    FROM products p
    LEFT JOIN order_items oi
		ON p.product_id = oi.product_id;
	# OUTER JOIN BETWEEN MULTİPLE TABLES
    USE sql_store;
	SELECT 
		c.customer_id,
        c.first_name,
        o.order_id, 
        sh.name AS shipper
    FROM customers c #Left table ilk ile son gibiler left ile right
    LEFT JOIN orders o #right table ilk ile son gibiler left ile right
    # Right ile aynı sonuç için
    # from orders o
	# right join customers c 
    #yazorders
		ON c.customer_id = o.customer_id
	# kod okunurluğu için inner join yerine left joini kullanmak yada 
    # tek olarak left / right join kullanmak okunurluğu arttırırken karmaşıklığı azaltır.
    LEFT JOIN shippers sh
		ON o.shipper_id = sh.shipper_id
	ORDER BY c.customer_id;
    # EXERCISE
	USE sql_store;
	SELECT o.order_id,
		o.order_date,
        c.first_name AS customer,
        sh.name AS shipper,
        os.name AS status
    FROM orders o 
    JOIN customers c # her orders'ın customers'ı olduğı için inner join kullanıldı
		ON o.customer_id = c.customer_id
    LEFT JOIN shippers sh
		ON o.shipper_id = sh.shipper_id
	#ORDER BY c.customer_id;
    JOIN order_statuses os 
		ON o.status = os.order_status_id;
        
	# SELF OUTER JOIN 
    USE sql_hr;
    SELECT 
		e.employee_id,
        e.first_name,
        m.first_name AS manager
    FROM employees e
    JOIN employees m 
		ON e.reports_to = m.employee_id
	ORDER BY e.first_name;
    
    
        

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

		












