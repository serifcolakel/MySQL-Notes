- -- ile satır açıklama satırı olarak nitelendirilebilir.

### USE metodu kullanılacak veri tabanını seçmemize yarar.

```sql
    USE store;
```

### ORDER BY (argüman) -> tablonun argümanına göre sıralamak için,

```sql
    SELECT *
    FROM customers
    WHERE customer_id = 1
    ORDER BY phone;
```

### SELECT (argüman) seçilecek table sütünu { info: " (\*) ise tüm sütünlar " },

### FROM (argüman) -> argümana göre hangi tablo seçimi,

```sql
    SELECT customer_id, first_name, points
    FROM customers
    WHERE customer_id = 1;
```

### Direkt olarak matematiksel işlemler uygulanabilir. AS ile set name

### AS (argüman) -> değişken (argüman) olarak tanımlanması için,

- argüman da boşluk girmek için tırnak içerisinde olmalı,

```sql
    SELECT
    customer_id,
    first_name,
    points,
    points + 20 AS "multiple point",
    points / 5,
    (points + 10 ) * 100 AS discount_factor
    FROM customers;
```

### store.customers altındaki id'si 1 olan elemanın city değerinin "Waltham" olarak set et.

```sql
    SELECT state FROM customers;
    SELECT * FROM store.customers;
    UPDATE `store`.`customers` SET `city` = 'Waltham' WHERE (`customer_id` = '1');
```

### DISTINCT -> ile eşşiz elemanları getirmek için,

```sql
    SELECT DISTINCT state FROM customers;

    SELECT
    name,
    unit*price,
    unit_price * 1.1 AS calculated*price,
    quantity_in_stock * 2.55
    FROM products;
```

### Comparison Opretors ->

- (>) (gt),
- (>=) (gte),
- (<) (lt),
- (<=) (lte),
- (=) (equality),
- (!=) (not equal), <> (not equal)

### WHERE (argüman) -> tablonun argümanına göre şartlı seçme için,

```sql
    SELECT *
    FROM customers
    WHERE points > 3000;
```

```sql
    SELECT *
    FROM customers
    WHERE state = 'va';
```

```sql
    SELECT *
    FROM customers
    WHERE state != 'va';
```

```sql
    SELECT *
    FROM customers
    WHERE state <> 'va';
```

```sql
    SELECT *
    FROM customers
    WHERE birth_date > '1995-01-01';
```

```sql
    SELECT *
    FROM orders
    WHERE order_date >= '2019-01-01';
```

### AND (Tüm şartlar doğru ise), OR (En az biri doğru ise) & NOT ()

```sql
    SELECT *
    FROM customers
    WHERE birth_date > '1990-01-01' AND points > 1000;
```

```sql
    SELECT *
    FROM customers
    WHERE birth_date > '1990-01-01' OR points > 1000;
```

### AND operator ilk çalışır sonrasında OR çalışır öncelik sırasından dolayı

```sql
    SELECT *
    FROM customers
    WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';
```

### NOT ile parantez önemli şartı sağlamayanlar gelecek...

```sql
    SELECT *
    FROM customers
    WHERE NOT (birth_date > '1990-01-01' OR points > 1000);
```

### Yukarısı ile aynı NOT parantez içine dağıldı.

```sql
    SELECT *
    FROM customers
    WHERE birth_date <= '1990-01-01' AND points <= 1000;
    SELECT *
    FROM order_items
    WHERE order_id = 6 AND unit_price * quantity > 30;
```

### IN operators -> Birden fazla (veya) sorgu da kullanılır

```sql
    SELECT *
    FROM customers
* WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
    WHERE state IN ('VA', 'FL', 'GA');
```

```sql
    SELECT *
    FROM customers
* WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
    WHERE state NOT IN ('VA', 'FL', 'GA');
    SELECT *
    FROM products
    WHERE quantity_in_stock IN (49, 38, 72);
```

### BETWEEN OPERATOR -> BETWEEN (GTE) AND (LTE)

```sql
    SELECT *
    FROM customers
    WHERE points >= 1000 AND points <= 3000;
```

```sql
    SELECT *
    FROM customers
    WHERE points BETWEEN 1000 AND 3000;
```

```sql
    SELECT *
    FROM customers
    WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';
```

### LIKE OPERATOR LIKE (VALUE) {info (%): any number of characters, info (\_): single character }

- VALUE = 'A%' -> string A veya a ile başlayanları,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE 'b%';
```

- VALUE = '%A' -> string A veya a ile bitenleri,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE '%Y';
```

- VALUE = '%A%' -> string A veya a'yı HERHANGİ BİR YERİNDE içerenleri,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE '%Z%';

```

- VALUE = '\_A' -> stringin UNDERSCORE kadar elemanları herhangi bir şey olabilir bir sonraki karakteri A veya a olmalı,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE '_y';
```

- VALUE = '\_\_\_A' -> stringin ilk 4 elemanı herhangi bir şey olabilir bir sonraki karakteri A veya a olmalı,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE '____y';
```

- VALUE = 'b\_\_A' -> stringin ilk elemanı b veya B olurken 2., 3. ve 4. elemanı herhangi bir şey olabilir ve bir sonraki karakteri A veya a olmalı,

```sql
    SELECT *
    FROM customers
    WHERE last_name LIKE 'b____y';
```

\*EXamples

```sql
    SELECT *
    FROM customers
    WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
```

```sql
    SELECT *
    FROM customers
    WHERE phone LIKE '%9'; # phone number end with 9
```

# THE REGEXP OPERATOR

- last_name REGEXP 'value' -> last_name içinde herhangi bir yerinde sadece value içerenleri çağıracak.

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'field';
```

- last_name REGEXP '^value' -> last_name must start with value

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP '^field';
```

- last_name REGEXP 'value$' -> last_name must end with value

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'field$';
```

- last_name REGEXP 'valueFirst|valueSecond' -> last_name must contain one of valueFirst & valueSecond
- value sayısı daha fazla da olabilir... last_name 'valueFirst|valueSecond|values....'

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'field|mac';
```

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP '^field|mac|rose';
```

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'field$|mac|rose';
```

- last_name REGEXP '[gim]e' -> last_name "ge", "ie", "me" içermelidir.
- Yani [] içindeki karakterler (g, i, e) ilk elemanı olurken diğer karakter ise [] dışında kalan karakter (e) olmalıdır.

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP '[gim]e';
```

- last_name REGEXP 'e[fmq]' -> last_name "ef", "em", "eq" içermelidir.
- Yani ilk karakter [] dışında kalan karakter (e) olurken [] içindeki karakterler (f, m, q) ise ikinci elemanı olmalıdır.

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'e[fmq]';
```

- last_name REGEXP '[a-h]e' -> last_name "ae", "eb", "ec", "ed", "ef", "eh" içermelidir.
- Yani ilk karakter [] içinde kalan karakterler (a'dan başlayıp h'a kadar alfabetik) olurken
- [] dışında kalan karakter (e) ise ikinci elemanı olmalıdır.

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP '[a-h]e';
```

# ALL OF

> - ^ beginning
> - $ end
> - | logical or
> - [abcd] match any char
> - [a-e] a to e range all char

# EXERCISE

```sql
    SELECT *
    FROM customers
    WHERE first_name REGEXP 'elka|ambur';
```

```sql
    SELECT *
    FROM customers
    WHERE last*name REGEXP 'ey$|on$';
```

```sql
    SELECT *
    FROM customers
    WHERE last*name REGEXP '^my|se';
```

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'b[ru]';
```

```sql
    SELECT *
    FROM customers
    WHERE last_name REGEXP 'br|bu';
```

# NULL OPERATOR -> IS NULL mu check ediyorsun

```sql
    SELECT *
    FROM customers
    WHERE phone IS NULL;
```

```sql
    SELECT *
    FROM customers
    WHERE phone IS NOT NULL;
```

# EXERCISE

```sql
    SELECT *
    FROM orders
    WHERE shipper_id IS NULL;
```

# THE ORDER BY CLAUSE -> sort column

```sql
    SELECT *
    FROM customers
    ORDER BY first_name;
```

- Tersten sıralamak için

```sql
    SELECT *
    FROM customers
    ORDER BY first_name DESC;
```

- Ilk olarak state'e göre sonra ise firstname'e göre sıralayacak..

```sql
    SELECT *
    FROM customers
    ORDER BY state,first_name;
```

```sql
    SELECT *
    FROM customers
    ORDER BY state DESC,first_name;
```

```sql
    SELECT first_name, last_name
    FROM customers
    ORDER BY birth_date;
```

- invalid column'a göre sıralama yapılabilir MySQL'de

```sql
    SELECT first_name, last_name, 10 AS points
    FROM customers
    ORDER BY points, first_name;
```

- AVOID 1,2 yazılırsa 1 column sayısı olduğu için first_name'i ,2 ise last_name gösterir.

```sql
    SELECT first_name, last_name
    FROM customers
    ORDER BY 1, 2;
```

# EXERCISE

```sql
    SELECT *, quantity _ unit_price AS total_price
    FROM order_items
    WHERE order_id = 2
    ORDER BY total_price DESC;
```

# LIMIT CLAUSE

- ILK 3 ADET customers table'sından veri gelecek.

```sql
    SELECT *
    FROM customers
    LIMIT 3;
```

- LIMIT x, y -> Örnek olarak sayfamıda kullanıcıları listeliyoruz ve her bir sayfada 3 customers old var sayalım. 7. customers'a yani sayfa 3'te bulunan customers'a gitmek için x ile kaç adet geçeceğimizi seçiyoruz ve y ile sonrasında kaç adet alacağımızı belirliyoruz.

```sql
    SELECT *
    FROM customers
    LIMIT 6, 3; # 6. 7. ve 8. customers
    SELECT *
    FROM customers
    LIMIT 6, 1; # 7. customers
```

# EXERCISE

```sql
    SELECT *
    FROM customers
    ORDER BY points DESC
    LIMIT 3;
```

# INNER JOINS

- join ile birden fazla tabloyu ON'dan sonra gelen şarta göre birleştirecek.

```sql
    SELECT *
    FROM orders
    JOIN customers
    	ON orders.customer_id = customers.customer_id;
```

- Sadece order_id, first_nameü last_name'e göre seçilirse.

```sql
    SELECT order_id, first_name, last_name
    FROM orders
    JOIN customers
    	ON orders.customer_id = customers.customer_id;
```

- customer_id'yi yazamıyoruz sutuna çünkü birden fazla aynı şey olduğu için order_id = customer_id olduğu için önüne nereden alındığını belirtmemiz gerekir.

```sql
    SELECT order_id, orders.customer_id, first_name, last_name
    FROM orders
    JOIN customers
    	ON orders.customer_id = customers.customer_id;
```

- Birden fazla yerde orders ve customers'ı kullandık kısaltma ile göstermek için orders o, customers c ile göstermek için böyle yazabiliyoruz.(syntax -> table shortcut)

```sql
    SELECT order_id, o.customer_id, first_name, last_name
    FROM orders o
    JOIN customers c
    	ON o.customer_id = c.customer_id;
```

# EXERCISE

```sql
    SELECT order_id, oi.product_id, quantity, oi.unit_price
    FROM order_items oi
    JOIN products p
    	ON oi.product_id = p.product_id;
```

# JOINING ACROSS DATABASES

- Kullanılan veri tabanı ile birleştirilen veri tabanı farklı ise aşağıdaki gibi işlem yapılır.

```sql
    USE sql_store;
    SELECT *
    FROM sql_store.order_items oi
    JOIN sql_inventory.products p
    	ON oi.product_id = p.product_id;
```

# SELF JOINS

- Kendisi ile birleşme

```sql
    USE sql_hr;
    SELECT *
    FROM employees e
    JOIN employees m
    	ON e.reports_to = m.employee_id;
```

- Neden e yada m olarak kısaltmalar olarak adlandırdık çünkü bu itemler 2 tabloda da mevcut Başkası ile birleştirme ile tamamen aynı sadece takma adlar farklı olmalı...

```sql
    USE sql_hr;
    SELECT
    	e.employee_id,
        e.first_name,
        m.first_name AS manager_name
    FROM employees e
    JOIN employees m
    	ON e.reports_to = m.employee_id;
```

# JOINING MULTIPLE TABLES

```sql
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
```

# EXERCISE

```sql
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
```

# COMPOUND JOIN CONDITIONS

- Burada ise şartlı olarak birden fazla veri tabanı birleştirme yapıyoruz.

```sql
    USE sql_store;
    SELECT *
    FROM order_items oi
    JOIN order_item_notes oin
    ON oi.order_id = oin.order_Id
    AND oi.product_id = oin.product_id;
```

# IMPLICIT JOIN SYNTAX

- YOL - 1

```sql
    USE sql_store;
    SELECT *
    FROM orders o
    JOIN customers c
    ON o.customer_id = c.customer_id;
```

### YOL - 2 -> implicit join syntax

```sql
    SELECT *
    FROM orders o, customers c
    WHERE o.customer_id = c.customer_id;
```

# OUTER JOINS

- left join seçilirse joinden sonraki customers tablosuna ON'da bulunan şarta bakılmadan döndürülür. right join seçilirse joinden sonraki orders tablosuna ON'da bulunan şarta bakılmadan döndürülür.

```sql
  USE sql_store;
  SELECT
    c.customer_id,
    c.first_name,
    o.order_id
  from customers c #Left table ilk ile son gibiler left ile right
  left join orders o #right table ilk ile son gibiler left ile right
  # Right ile aynı sonuç için aşağıdaki açıklamayı uygularız.
  # from orders o
  # right join customers c
  on c.customer_id = o.customer_id
  order by c.customer_id;
```

# EXERCISE

```sql
  USE sql_store;
  SELECT
  p.product_id,
  p.name,
  oi.quantity
  FROM products p
  LEFT JOIN order_items oi
  ON p.product_id = oi.product_id;
```
