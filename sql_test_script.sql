CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100) UNIQUE
);
CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    order_date DATE,
    customer_id NUMBER,
    CONSTRAINT fk_customer
      FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
CREATE TABLE Product (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    price NUMBER
);
CREATE TABLE Order_Detail (
    order_detail_id NUMBER PRIMARY KEY,
    order_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    CONSTRAINT fk_order
      FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CONSTRAINT fk_product
      FOREIGN KEY (product_id) REFERENCES Product(product_id)
);



INSERT INTO Customer (customer_id, name, email)
VALUES (1, 'MUGABO Lionel', 'mugabolionel8@gmail.com');

INSERT INTO Customer
VALUES (2, 'HIRWA Norcy', 'hirwanorcy8@gmail.com');

INSERT INTO Product (product_id, product_name, price)
VALUES (101, 'Laptop', 1500);

INSERT INTO Product 
VALUES (102, 'Smart_phone', 1200);

INSERT INTO Orders (order_id, order_date, customer_id)
VALUES (5001, TO_DATE('2023-09-25', 'YYYY-MM-DD'), 1);

INSERT INTO Orders 
VALUES (5002, TO_DATE('2023-09-25', 'YYYY-MM-DD'), 2);

INSERT INTO Order_Detail (order_detail_id, order_id, product_id, quantity)
VALUES (9001, 5001, 101, 2);

INSERT INTO Order_Detail
VALUES (9002, 5002, 102, 4);




UPDATE Product
SET price = 1600
WHERE product_id = 101;

SELECT * FROM Customer;
SELECT * FROM product;
SELECT * FROM orders;
SELECT * FROM Order_Detail ;


ALTER TABLE Order_Detail
DROP CONSTRAINT fk_order;

ALTER TABLE Order_Detail
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE;

DELETE FROM Orders
WHERE order_id = 5001;

SELECT * FROM orders;

SELECT c.name, o.order_date, p.product_name, od.quantity
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Detail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id;

SELECT name, email
FROM Customer
WHERE customer_id IN (
    SELECT customer_id FROM Orders
);

GRANT SELECT, insert, update ON customer TO LASTking;
GRANT SELECT ON product TO LASTking;
GRANT SELECT ON Orders TO LASTking;
GRANT SELECT ON Order_Detail TO LASTking;
GRANT CONNECT, RESOURCE TO LASTking;

REVOKE UPDATE on customer FROM LASTking;


commit;

INSERT INTO Product (product_id, product_name, price) VALUES (103, 'Tablet', 500);
INSERT INTO Product (product_id, product_name, price) VALUES (104, 'Monitor', 300);
SELECT * FROM Product;

ROLLBACK;
SELECT * FROM Product;

commit;

