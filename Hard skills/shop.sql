DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS products;
CREATE TABLE products(
	product_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_product VARCHAR(100),
	quantity BIGINT,
	price DECIMAL (10,2),
	description TEXT,
	brand VARCHAR(100),
	INDEX(name_product)
);

INSERT INTO products VALUES ('1', 'гречка', '10', '50.23', '....', 'мистраль'),
('2', 'гречка', '5', '60.99', '....', 'агро-холдинг'),
('3', 'гречка', '7', '55.99', '....', 'злата'),
('4', 'хлеб', '10', '50.23', '....', 'московский хлебокомбинат'),
('5', 'мука', '20', '99.99', '....', 'мукомол'),
('6', 'яйца', '10', '69.99', '....', 'птичка'),
('7', 'молоко', '10', '79.99', '....', 'зеленое село'),
('8', 'масло подсолнечное', '10', '70.99', '....', 'злата'),
('9', 'сахар', '10', '22.99', '....', 'мистраль'),
('10', 'соль', '10', '19.99', '....', 'дубрава');


DROP TABLE IF EXISTS buyers;
CREATE TABLE buyers(
 	buyer_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
  	phone BIGINT UNSIGNED UNIQUE,
 	gender CHAR(1),
 	birthday DATE,
  	created_at DATETIME DEFAULT NOW(),
  	INDEX(firstname,lastname)
);
INSERT INTO buyers VALUES ('1', 'Иван', 'Иванов', 'king.iva@example.net', '89102542363', 'm', '2000-04-25','2007-07-12 22:16:30'),
('2', 'Ирина', 'Кузьмина', 'ira@example.net', '89162542363', 'f', '2000-05-25','2000-07-12 22:16:30'),
('3', 'Иван', 'Петров', 'petrov@example.net', '89152542363', 'm', '1999-06-25','2007-07-12 22:16:30'),
('4', 'Антон', 'Семенов', 'anton.iva@example.net', '89262542363', 'm', '1998-07-25','2007-07-12 22:16:30'),
('5', 'Петр', 'Петров', 'petrov.iva@example.net', '89102528363', 'm', '2001-08-25','2007-07-12 22:16:30'),
('6', 'Петр', 'Смирнов', 'petr.iva@example.net', '89102500363', 'm', '2002-08-25','2007-07-12 22:16:30');

DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
	sales_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bought_at DATETIME DEFAULT NOW(),
	payment_method ENUM ('наличный расчет', 'банковская карта'),
	buyer BIGINT UNSIGNED NOT NULL,
	total_summ DECIMAL (10,2),
	FOREIGN KEY (buyer) REFERENCES buyers(buyer_id)
);
INSERT INTO sales VALUES ('1', '2020-05-17', 'наличный расчет', '1', '2145.25'),
('2', '2020-06-17', 'наличный расчет', '1', '3785.25'),
('3', '2020-06-16', 'наличный расчет', '1', '6895.25'),
('4', '2020-05-17', 'банковская карта', '2', '2145.25'),
('5', '2020-05-17', 'наличный расчет', '3', '2000.25'),
('6', '2020-05-17', 'наличный расчет', '4', '100.25'),
('7', '2020-05-17', 'банковская карта', '5', '500.25'),
('8', '2020-06-17', 'наличный расчет', '2', '3000.25'),
('9', '2020-07-17', 'наличный расчет', '3', '4000.25'),
('10', '2020-05-17', 'банковская карта', '6', '00.99');

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
	supplier_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	organisation_name VARCHAR(100),
	email VARCHAR(100) UNIQUE,
  	phone BIGINT UNSIGNED UNIQUE,
  	adress TEXT,
  	INDEX(organisation_name)
);
INSERT INTO suppliers VALUES ('1', 'Молоковоз', 'porter.funk@example.org', '74952367858', 'Ул. Заводская д.10'),
('2', 'Мультивоз', 'multi@example.org', '7495257858', 'Ул. Трудовая д.5'),
('3', 'Агроном', 'agro.funk@example.org', '74956457858', 'Ул. Ленина д.7'),
('4', 'Хлебный дом', 'home@example.org', '74952387658', 'Ул. Маркса д.8'),
('5', 'Петелинка', 'petel@example.org', '74952000058', 'Ул. Речная д.15');

DROP TABLE IF EXISTS supplies;
CREATE TABLE supplies(
	id_of_supply BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	supplier BIGINT UNSIGNED NOT NULL,
	date_of_supply DATETIME,
	price_of_supply DECIMAL (10,2),
	FOREIGN KEY (supplier) REFERENCES suppliers(supplier_id)
);
INSERT INTO supplies VALUES ('1', '1', '2020-05-14', '1456258.32'),
('2', '2', '2020-06-14', '1456258.32'),
('3', '3', '2020-07-14', '456258.32'),
('4', '4', '2020-08-14', '145258.32'),
('5', '5', '2020-07-13', '56258.32'),
('6', '2', '2020-05-13', '145625.32');

DROP TABLE IF EXISTS supplies_content;
CREATE TABLE supplies_content(
	id SERIAL,
	supply BIGINT UNSIGNED NOT NULL,
	product BIGINT UNSIGNED NOT NULL,
	supplier BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (supply) REFERENCES supplies(id_of_supply),
	FOREIGN KEY (supplier) REFERENCES suppliers(supplier_id),
	FOREIGN KEY (product) REFERENCES products(product_id)
);
INSERT INTO supplies_content VALUES ('1', '1', '1', '3'),
('2', '2', '2', '2'),
('3', '3', '3', '3'),
('4', '4', '5', '3'),
('5', '5', '6', '5'),
('6', '6', '7', '1');

DROP TABLE IF EXISTS products_sales;
CREATE TABLE products_sales(
	product_sales_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	product BIGINT UNSIGNED NOT NULL,
	sale BIGINT UNSIGNED NOT NULL,
	quantity_of_product BIGINT,
	FOREIGN KEY (product) REFERENCES products(product_id),
	FOREIGN KEY (sale) REFERENCES sales(sales_id)
);
INSERT INTO products_sales VALUES ('1', '1', '1', '2'),
('2', '1', '2', '1'),
('3', '3', '4', '3'),
('4', '6', '3', '5'),
('5', '4', '1', '2');


-- 3) Структуру данных в таблицах с примерами SQL-запросов:
-- 3.1) Выбрать все марки гречки;
select brand
from products 
where name_product = 'гречка'
-- 3.1) Выбрать все транзакции с суммой менее 1 рубля;
select total_summ
from sales 
where total_summ < 1.00
-- 3.1) Выбрать все транзакции постоянного покупателя Иванова;
select total_summ, lastname
from sales s 
join buyers b 
on buyer_id = buyer and lastname = 'Иванов'
--  3.1) Выбрать топ-5 покупателей, которые совершили больше всего покупок;
select buyer, count(distinct bought_at)
from sales
group by buyer
order by bought_at
desc limit 5
-- 3.1) Сформировать выгрузку (отчет), в котором будет указано, сколько в среднем в месяц тратит Иванов в магазине.
SELECT lastname as 'Фамилия', AVG(total_summ) as 'Средние затраты в месяц', MONTH(bought_at) as 'Месяц', YEAR(bought_at) as 'Год'
FROM sales 
JOIN buyers 
ON buyer_id = buyer and lastname = 'Иванов'
group by YEAR(bought_at), MONTH(bought_at)








