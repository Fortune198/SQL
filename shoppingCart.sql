--Create products table


CREATE TABLE products (
	id bigserial PRIMARY KEY,
	name varchar(50),
	price numeric
);

INSERT INTO products (name, price)
VALUES 
('coke', 10),
('chips' ,5),
('sweets',15),
('Slaap Chips',20),
('chocolate',15);

SELECT * FROM products;

=================================================================================================================================================
--user table

CREATE TABLE user_table (
	user_id bigserial PRIMARY KEY,
	name varchar (50)
);

INSERT INTO user_table (name)
VALUES 
('Arnold'),
('Sheryl');

SELECT * FROM user_table;
=================================================================================================

--creating add_products function

CREATE OR REPLACE FUNCTION add_products(prod_id bigint)
RETURNS void AS $$
BEGIN
IF EXISTS (SELECT * FROM cart_table WHERE product_id = prod_id)
	THEN
		UPDATE  cart_table SET quantity = quantity + 1  WHERE product_id = prod_id;
	ELSE
		INSERT INTO cart_table (product_id,quantity) VALUES (prod_id ,1);
	END IF; 

END;
$$ LANGUAGE plpgsql;


SELECT * FROM cart_table;

SELECT add_products(1);
SELECT add_products(1);
SELECT add_products(2);
SELECT add_products(3);
SELECT add_products(4);
SELECT add_products(5);

=======================================================================================================================

--cart table

CREATE TABLE cart_table (
	product_id bigint REFERENCES products(id) UNIQUE,
	quantity numeric CONSTRAINT qty_check CHECK(quantity >-1)
);


SELECT * FROM cart_table;

DELETE FROM cart_table;

====================================================================================================================================

--order_header table

CREATE TABLE order_header (
	OrderID bigserial PRIMARY KEY,
	user_id bigint REFERENCES user_table(user_id),
	OrderDate timestamp DEFAULT current_timestamp
);


INSERT INTO order_header (user_id)
VALUES
(2);


SELECT * FROM order_header;

====================================================================================================================

--Order_Details table

CREATE TABLE Order_Details (
	OrderID BIGINT REFERENCES order_header (OrderID),
	product_id bigint REFERENCES products (id),
	Qty BIGINT NOT NULL  CONSTRAINT qty_check CHECK(qty > -1)
);


INSERT INTO Order_Details 
VALUES 
(1,1,2),
(1,2,1);


SELECT * FROM Order_Details;

DROP TABLE Order_Details;
DROP TABLE order_header;
DROP TABLE cart_table;
DROP TABLE user_table;
DROP TABLE products;

==================================================================================================================
--Delete function

CREATE OR REPLACE FUNCTION remove_product(prod_id bigint)
RETURNS void AS $$
BEGIN
    IF EXISTS (SELECT * FROM cart_table WHERE product_id = prod_id
                                  AND quantity > 1)
    THEN
        UPDATE  cart_table
        SET quantity = quantity - 1
        WHERE product_id = prod_id;
    ELSE
        DELETE FROM cart_table 
        WHERE product_id = prod_id;
    END IF; 
END;
$$ LANGUAGE plpgsql;

--Testing remove_function

SELECT remove_product(1);
SELECT remove_product(2);
SELECT remove_product(3);
SELECT remove_product(4);
SELECT remove_product(5);

SELECT add_products(1);
SELECT add_products(2);
SELECT add_products(3);
SELECT add_products(4);
SELECT add_products(5);

SELECT * FROM cart_table;
===============================================================================================================================
--2nd Order

INSERT INTO order_header (user_id)
VALUES 
(2);

INSERT INTO Order_Details
VALUES 
(2,3,3),
(2,5,2);

=================================================================================================================================

--Printing

SELECT order_header.orderID AS Order_ID,
	user_table.name AS Username,
	products.id AS Products,
	Order_Details.Qty AS Quantity,
	products.price AS Price,
	products.price * Order_Details.Qty AS Total
FROM user_table
JOIN order_header
ON user_table.user_id = order_header.user_id
JOIN Order_Details
ON order_header.orderID = Order_Details.orderID
JOIN products
ON products.id = Order_Details.product_id
WHERE order_header.orderID = 1;


--All printing


SELECT order_header.orderID AS Order_ID,
	user_table.name AS Username,
	products.id AS Products,
	Order_Details.Qty AS Quantity,
	products.price AS Price,
	products.price * Order_Details.Qty AS Total
FROM user_table
JOIN order_header
ON user_table.user_id = order_header.user_id
JOIN Order_Details
ON order_header.orderID = Order_Details.orderID
JOIN products
ON products.id = Order_Details.product_id
WHERE date_part('day', orderdate) = '16'
ORDER BY Order_header.orderID;

SELECT * FROM order_header;