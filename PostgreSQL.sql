-- Parte 1
create table countries(
  id_country serial primary key,
  name varchar(50) NOT NULL  
);

create table users(
 id_users serial primary key,
 id_country integer NOT NULL,
 email varchar(100) NOT NULL,
 name varchar (50) NOT NULL,
 foreign key (id_country) references countries (id_country)   
);

-- Parte 2

insert into countries (name) values ('argentina') , ('colombia'),('chile');
select * from countries;
insert into users (id_country, email, name)
    values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;


delete from users where email = 'bar@bar.com';


update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;


select * from users inner join  countries on users.id_country = countries.id_country;
select u.id_users as id, u.email, u.name as fullname, c.name 
  from users u inner join  countries c on u.id_country = c.id_country;

-- Parte 3

create table priorities(
  id_priority serial primary key,
  type_name varchar(50) NOT NULL
);

create table countries(
  id_country serial primary key,
  name varchar(50) NOT NULL
);

create table contact_request(
  id_email serial primary key,
  name varchar(50),
  details TEXT,
  physical_address varchar(100),
  id_country INT,
  id_priority INT,
  foreign key(id_country) references countries(id_country),
  foreign key(id_priority) references priorities(id_priority)
);


-- Parte 4

insert into countries(name)
values
('Estados Unidos'),
('Mexico'),
('Chile'),
('Peru'),
('Argentina');

insert into priorities(type_name)
values
('Alta'),('Media'),('Baja');

insert into contact_request(name, details, physical_address, id_country, id_priority)
VALUES
('Juan Perez', 'Detalles de la solicitud', 'Calle principal', 1, 1),
('Jose Rodrigo', 'Mas detalles', 'Calle segundaria', 5, 3),
('Alexander Ferra', 'Otras', 'Calle', 3, 2);

-- Eliminar dato
delete from contact_request
where id_email = (select id_email from contact_request limit 1);

delete from contact_request
where id_email = (select id_email from contact_request order by id_email DESC limit 1);

-- Actualizar estado
update contact_request set name = 'pedro Ferra', physical_address = 'principal'
where id_email = 2;

-- Parte 5
CREATE TABLE roles (
  id_role SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE countries (
  id_country SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE customers (
  email SERIAL PRIMARY KEY,
  id_country INTEGER,
  id_role INTEGER,
  name VARCHAR,
  age INTEGER,
  password VARCHAR(255),
  physical_address VARCHAR(255),
  FOREIGN KEY (id_country) REFERENCES countries(id_country),
  FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE payments (
  id_payment SERIAL PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE invoice_status (
  id_invoice_status SERIAL PRIMARY KEY,
  status BOOLEAN
);

CREATE TABLE invoices (
  id_invoice SERIAL PRIMARY KEY,
  id_customer INTEGER,
  id_payment INTEGER,
  id_invoice_status INTEGER,
  date TIMESTAMP,
  total_to_pay DECIMAL(10, 2),
  total_without_tax DECIMAL(10, 2),
  FOREIGN KEY (id_payment) REFERENCES payments(id_payment),
  FOREIGN KEY (id_invoice_status) REFERENCES invoice_status(id_invoice_status),
  foreign key (id_customer) REFERENCES customers(email)
);

CREATE TABLE discounts (
  id_discount SERIAL PRIMARY KEY,
  status BOOLEAN,
  percentage DECIMAL(10, 2)
);

CREATE TABLE offers (
  id_offer SERIAL PRIMARY KEY,
  status BOOLEAN
);

CREATE TABLE taxes (
  id_tax SERIAL PRIMARY KEY,
  percentage DECIMAL(10, 2)
);

CREATE TABLE products (
  id_product SERIAL PRIMARY KEY,
  name VARCHAR(255) not NULL,
  details TEXT not NULL,
  minimum_stock INTEGER not NULL,
  maximum_stock INTEGER not NULL,
  current_stock INTEGER not NULL,
  price DECIMAL(10, 2) not NULL,
  price_with_tax DECIMAL(10, 2),
  id_discount INT,
  id_offer INTEGER,
  id_tax INTEGER,
  foreign key (id_discount) references discounts(id_discount),
  foreign key (id_offer) references offers(id_offer),
  foreign key (id_tax) references taxes(id_tax)
);

CREATE TABLE orders (
  id_order SERIAL PRIMARY KEY,
  id_product INTEGER,
  id_invoice INTEGER,
  detail VARCHAR(255),
  amount INTEGER not NULL,
  price DECIMAL(10, 2) not NULL,
  FOREIGN KEY (id_product) REFERENCES products(id_product),
  foreign key (id_invoice) REFERENCES invoices(id_invoice)
);

CREATE TABLE products_customers (
  id_product INTEGER,
  id_customer INTEGER,
  FOREIGN KEY (id_product) REFERENCES products(id_product),
  FOREIGN KEY (id_customer) REFERENCES customers(email)
);

-- parte 6
INSERT INTO roles (name) VALUES ('admin'), ('user'), ('guest');
INSERT INTO countries (name) VALUES ('USA'), ('Canada'), ('Mexico');
INSERT INTO customers (id_country, id_role, name, age, password, physical_address) VALUES
( 1, 1, 'John Doe', 30, 'password123', '123 Main St, Anytown USA'),
( 2, 2, 'Jane Smith', 25, 'password456', '456 Elm St, Anytown Canada'),
( 3, 3, 'Mike Johnson', 35, 'password789', '789 Oak St, Anytown Mexico');
INSERT INTO payments (type) VALUES ('credit card'), ('debit card'), ('cash');
INSERT INTO invoice_status (status) VALUES (true), (false);
INSERT INTO discounts (status, percentage) VALUES (true, 0.1), (false, 0.2), (false, 0.3);
INSERT INTO offers (status) VALUES (true), (false), (false);
INSERT INTO taxes (percentage) VALUES (0.05), (0.07), (0.09);
INSERT INTO products (name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax, id_discount, id_offer, id_tax) VALUES
('Product 1', 'Details for Product 1', 10, 50, 25, 100.00, 105.00, 1, 1, 1),
('Product 2', 'Details for Product 2', 5, 20, 15, 50.00, 52.50, 2, 2, 2),
('Product 3', 'Details for Product 3', 2, 10, 8, 20.00, 21.00, 3, 3, 3);
INSERT INTO invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay, total_without_tax) VALUES
(1, 1, 1, '2023-01-01 10:00:00', 250.00, 237.50),
(2, 2, 2, '2023-01-02 11:00:00', 55.00, 50.00),
(3, 3, 1, '2023-01-03 12:00:00', 100.00, 95.00);
INSERT INTO orders (id_product, id_invoice, detail, amount, price) VALUES
(1, 1, 'Order 1 for Product 1', 2, 200.00),
(2, 2, 'Order 1 for Product 2', 1, 50.00),
(3, 3, 'Order 1 for Product 3', 4, 80.00);
INSERT INTO products_customers (id_product, id_customer) VALUES
(1, 1),
(2, 2),
(3, 3);

DELETE FROM orders
WHERE id_invoice = 3;
DELETE FROM invoices
WHERE id_customer = 3;
DELETE FROM products_customers
WHERE id_customer = 3;
delete from customers
where email = 3;

UPDATE customers
SET name = 'alejandro', age = 39
WHERE email = (SELECT MAX(email) FROM customers);
UPDATE products
SET price = 500;
UPDATE products
SET id_tax = id_tax + 100
WHERE id_tax BETWEEN 1 AND 49;
UPDATE taxes
SET id_tax = id_tax + 150,
    percentage = percentage * 1.10
WHERE id_tax < 50;
