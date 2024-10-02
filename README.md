# **Database Management System for an Order Processing System**

## Problem Statement 

This database system manages the order processing for an e-commerce platform. It handles customers, products, customer orders, and order details, including the quantity of each product ordered. The goal is to maintain relationships between customers, products, orders, and order details, ensuring accurate record keeping and efficient data retrieval for reporting and analysis. 

## Key Features: 

**•	Customer Management:** Store and manage customer information such as name and contact details.

**•	Product Management:** Store and manage product information.

**•	Order Management:** Keep track of customer orders.

**•	Order Details Management:** Record the specifics of each order, such as the products purchased and their quantities.
  
## SQL Commands Executed 
### 1. Table Creation 
#### The database consists of four main tables: 
**•	Customer:** Stores customer information like customer ID, name, and contact.

**•	Product:** Stores product details like product ID, name, and price.

**•	Orders:** Stores customer orders including order ID, customer ID, and order date.

**•	Order_Detail:** Stores details about each product in an order such as order detail ID, order ID, product ID, and quantity. 

The following SQL commands were used to create the tables and enforce relationships via foreign keys: 

```sql
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
```



## 2. Data Manipulation (DML) 
We used SQL commands to insert, update, and delete records in the database. 
###•	Insert data into the tables:

```sql
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

```
 
### •	Update data: 
```sql
UPDATE Product
SET price = 1600
WHERE product_id = 101;
```
 
### •	Delete data:
```sql
ALTER TABLE Order_Detail
DROP CONSTRAINT fk_order;

ALTER TABLE Order_Detail
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE;

DELETE FROM Orders
WHERE order_id = 5001;
```
here we first altered the the **Order_Detail** column to make it **DELETE CASCADE** so that can allow deletion of foreign key in an other table.

## 3. Querying the Data 
We executed SQL commands to retrieve related data using JOIN and basic SELECT queries.

 ```sql
SELECT c.name, o.order_date, p.product_name, od.quantity
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Detail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id;
```
 
#### RESULTS 
 
### 4. Transaction Control 
We used COMMIT to save all changes and ROLLBACK to undo the changes to manage transactions:
```sql
INSERT INTO Product (product_id, product_name, price) VALUES (103, 'Tablet', 500);
INSERT INTO Product (product_id, product_name, price) VALUES (104, 'Monitor', 300);
SELECT * FROM Product;
```
 
RESULT 
 
But when we rollback means we are undoing the last insertion as shown 
 ```sql
ROLLBACK;
SELECT * FROM Product;
```
 
#### Results 

 
 
Then after we commit to save changes 
  ```sql
commit;
```
  
## 5. Grant and Revoke Privileges 
We granted and revoked privileges to specific users. 
```sql
GRANT SELECT, insert, update ON customer TO LASTking;
GRANT SELECT ON product TO LASTking;
GRANT SELECT ON Orders TO LASTking;
GRANT SELECT ON Order_Detail TO LASTking;
GRANT CONNECT, RESOURCE TO LASTking;

REVOKE UPDATE on customer FROM LASTking;
```
## Explanation of Results:
 

**•	Inserting Records:** Successfully inserted customer, product, and order details. The relationships between Customer, Orders, Order_Detail, and Product tables are enforced by foreign keys.

**•	Updating Records:** The product price was successfully updated. A transaction was committed, making the change permanent.

**•	Deleting Records:** Deletion of records respects foreign key constraints to prevent orphaned records. 

**•	Join Query:** The join query demonstrates retrieving data across multiple tables, showing customer names, product names, and their quantities in specific orders. 
  
## Transaction Management 
In this project, transactions were handled using COMMIT to save changes permanently and 
ROLLBACK to undo changes when necessary. For example, we used ROLLBACK to revert an incorrect insertion 
  
  
