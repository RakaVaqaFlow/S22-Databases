DROP TABLE IF EXISTS ex1;
DROP TABLE IF EXISTS orderItems;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS items;

--1nf (in ex1.1.png)
CREATE TABLE ex1(
	orderId INT NOT NULL,
	date DATE,
	customerId INT NOT NULL,
	customerName VARCHAR(255),
	city VARCHAR(255),
	itemId INT NOT NULL,
	itemName VARCHAR(255),
	quant INT,
	price REAL,
	
	PRIMARY KEY (orderId, customerId, itemId)
);

INSERT INTO ex1 (orderId, date, customerId, customerName, city, itemId, itemName, quant, price)
VALUES 
(2301, TO_DATE('23/02/2011', 'DD/MM/YYYY'), 101, 'Martin', 'Prague', 3786, 'Net', 3, 35.00),
(2301, TO_DATE('23/02/2011', 'DD/MM/YYYY'), 101, 'Martin', 'Prague', 4011, 'Racket', 6, 65.00),
(2301, TO_DATE('23/02/2011', 'DD/MM/YYYY'), 101, 'Martin', 'Prague', 9132, 'Pack-3', 8, 4.75),
(2302, TO_DATE('25/02/2011', 'DD/MM/YYYY'), 107, 'Herman', 'Madrid', 5794, 'Pack-6', 4, 5.00),
(2303, TO_DATE('27/02/2011', 'DD/MM/YYYY'), 110, 'Pedro', 'Moscow', 4011, 'Racket', 2, 65.00),
(2303, TO_DATE('27/02/2011', 'DD/MM/YYYY'), 110, 'Pedro', 'Moscow', 3141, 'Cover', 2, 10.00);

--2nf in ex1.2.png
--3nf (in ex1.3.png)
CREATE TABLE orderItems AS (SELECT DISTINCT orderId, itemId, quant FROM ex1);
CREATE TABLE customers AS (SELECT DISTINCT customerId, customerName, city FROM ex1);
CREATE TABLE orders AS (SELECT DISTINCT orderId, customerId, date FROM ex1);
CREATE TABLE items AS (SELECT DISTINCT itemId, itemName, price FROM ex1);


--Calculate the total number of items per order and the total amount to
--pay for the order.

SELECT orderId, SUM(quant) AS total_number, SUM(i.price*quant) AS total_amount FROM orderItems AS oi, items AS i
WHERE oi.itemId = i.itemId  
GROUP BY orderId;

--Obtain the customer whose purchase in terms of money has been
--greater than the others

SELECT DISTINCT customers.customerId, customers.customerName, SUM(items.price*quant) AS total_amount FROM orderItems, items, customers, orders
WHERE orderItems.orderId = orders.orderId 
   AND orders.customerId = customers.customerId
   AND orderItems.itemId = items.itemId
GROUP BY customers.customerId, customers.customerName
ORDER BY total_amount DESC LIMIT 1;   