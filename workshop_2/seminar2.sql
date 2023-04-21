CREATE DATABASE IF NOT EXISTS `seminar2`;

USE seminar2;

--задание 1
CREATE TABLE sales(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_date VARCHAR(10), 
	count_product INT(3)
);

INSERT sales(order_date, count_product) 
VALUES 
	('2022-01-01', 156), 
	('2022-01-02', 180), 
	('2022-01-03', 21), 
	('2022-01-04', 124), 
	('2022-01-05', 341);

--задание 2
SELECT 
id AS 'id заказа',
IF (count_product < 100, 'Маленький заказ',
IF (count_product BETWEEN 100 AND 300, 'Средний заказ', 'Большой заказ')) 
AS 'Тип заказа'
FROM sales;

--задание 3
CREATE TABLE orders(
	id INT PRIMARY KEY AUTO_INCREMENT,
	employee_id VARCHAR(3), 
	amount DECIMAL(5,2),
	order_status VARCHAR(9)
);

INSERT orders(employee_id, amount, order_status) 
VALUES 
	('e03', 15, 'OPEN'), 
	('e01', 25.50, 'OPEN'),
	('e05', 100.70, 'CLOSED'),
	('e02', 22.18, 'OPEN'),
	('e04', 9.50, 'CANCELLED');
	
SELECT *,
CASE
WHEN order_status = 'OPEN' THEN 'Order is in open state'
WHEN order_status = 'CLOSED' THEN 'Order is closed'
WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
END AS full_order_status
FROM orders;
