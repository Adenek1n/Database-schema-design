CREATE TABLE USERS (USERID INT PRIMARY KEY IDENTITY (1,1),
USERNAME VARCHAR(50) NOT NULL UNIQUE,
PASSWORD VARCHAR(255) NOT NULL,
EMAIL VARCHAR (100) NOT NULL UNIQUE,
ADDRESS VARCHAR(255),
PHONENUMBER VARCHAR(20),
DATECREATED DATETIME DEFAULT GETDATE()
);

CREATE TABLE PRODUCTS (PRODUCTID INT PRIMARY KEY IDENTITY (1,1),
PRODUCTNAME VARCHAR(100) NOT NULL,
PRICE DECIMAL(10,2) NOT NULL,
STOCKQUANTITY INT NOT NULL,
CATEGORYID INT
);

ALTER TABLE PRODUCTS
ADD CONSTRAINT FK_CATEGORYID
FOREIGN KEY (CATEGORYID) REFERENCES CATEGORIES(CATEGORYID);

CREATE TABLE CATEGORIES(CATEGORYID INT PRIMARY KEY IDENTITY (1,1),
CATEGORYNAME VARCHAR(100) NOT NULL,
DESCRIPTION TEXT
);

SELECT*FROM USERS
SELECT*FROM PRODUCTS
SELECT*FROM CATEGORIES
SELECT*FROM ORDERS
SELECT*FROM ORDERDETAILS
SELECT*FROM PAYMENTS
SELECT*FROM REVIEWS
SELECT*FROM CART

CREATE TABLE Orders (
 OrderID INT PRIMARY KEY IDENTITY(1,1),
 UserID INT,
 OrderDate DATETIME DEFAULT GETDATE(),
 TotalAmount DECIMAL(10,2) NOT NULL,
 OrderStatus VARCHAR(50)
);
ALTER TABLE Orders
ADD CONSTRAINT FK_UserID
FOREIGN KEY (UserID) REFERENCES Users(UserID);


CREATE TABLE ORDERDETAILS (
    ORDERDETAILID INT PRIMARY KEY IDENTITY (1,1),
    ORDERID INT,
    PRODUCTID INT,
    QUANTITY INT NOT NULL,
    PRICE DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID),
    FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
);

CREATE TABLE PAYMENTS(
PAYMENTID INT PRIMARY KEY IDENTITY(1,1),
ORDERID INT,
PAYMENTDATE DATETIME DEFAULT GETDATE(),
PAYMENTAMOUNT DECIMAL (10,2) NOT NULL,
PAYMENTMETHOD VARCHAR(50),
FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID)
);

CREATE TABLE REVIEWS(
REVIEWID INT PRIMARY KEY IDENTITY(1,1),
PRODUCTID INT,
USERID INT, 
RATING INT CHECK(RATING BETWEEN 1 AND 5),
COMMENT TEXT,
REVIEWDATE DATETIME DEFAULT GETDATE(),
FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS (PRODUCTID),
FOREIGN KEY (USERID) REFERENCES USERS (USERID)
);

CREATE TABLE CART ( 
CARTID INT PRIMARY KEY IDENTITY (1,1),
USERID INT,
PRODUCTID INT,
QUANTITY INT NOT NULL,
DATEADDED DATETIME DEFAULT GETDATE(),
FOREIGN KEY (USERID) REFERENCES USERS (USERID),
FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS (PRODUCTID)
);


INSERT INTO USERS (Username, Password, Email, Address, PhoneNumber)
VALUES
('john_doe', 'password123', 'john@example.com', '123 Main St', '555-1234'),
('jane_smith', 'password456', 'jane@example.com', '456 Oak St', '555-5678'),
('alice_jones', 'password789', 'alice@example.com', '789 Pine St', '555-9101'),
('bob_brown', 'passwordabc', 'bob@example.com', '321 Maple St', '555-1123'),
('carol_white', 'passworddef', 'carol@example.com', '654 Birch St', '555-1415');


TRUNCATE TABLE CATEGORIES;
ALTER TABLE PRODUCTS NOCHECK CONSTRAINT FK_CATEGORYID;
ALTER TABLE PRODUCTS CHECK CONSTRAINT FK_CATEGORYID;


INSERT INTO CATEGORIES (CATEGORYNAME, DESCRIPTION)
VALUES
('Electronics', 'Devices and gadgets'),
('Books', 'Fiction and non-fiction books'),
('Clothing', 'Apparel and accessories'),
('Home & Kitchen', 'Household items and kitchenware'),
('Sports', 'Sporting goods and equipment');

INSERT INTO PRODUCTS(PRODUCTNAME,PRICE,STOCKQUANTITY,CATEGORYID)
VALUES
('Laptop', 999.99, 10, 1),
('Smartphone', 699.99, 15, 1),
('Tablet', 399.99, 20, 1),
('Novel', 19.99, 50, 2),
('T-shirt', 9.99, 100, 3),
('Blender', 49.99, 25, 4),
('Basketball', 29.99, 30, 5);

INSERT INTO ORDERS (UserID,TotalAmount,OrderStatus)
VALUES
(1, 1049.98, 'Completed'),
(2, 49.99, 'Pending'),
(1, 19.99, 'Completed'),
(3, 9.99, 'Shipped'),
(4, 699.99, 'Completed');

INSERT INTO ORDERDETAILS(ORDERID,PRODUCTID,QUANTITY,PRICE)
VALUES
(1, 1, 1, 999.99),
(1, 3, 1, 399.99),
(2, 6, 1, 49.99),
(3, 4, 1, 19.99),
(4, 5, 1, 9.99),
(5, 2, 1, 699.99);

INSERT INTO PAYMENTS(ORDERID,PAYMENTDATE,PAYMENTAMOUNT,PAYMENTMETHOD)
VALUES
(1, '2024-08-01', 1049.98, 'Credit Card'),
(2, '2024-08-02', 49.99, 'PayPal'),
(3, '2024-08-03', 19.99, 'Credit Card'),
(4, '2024-08-04', 9.99, 'Debit Card'),
(5, '2024-08-05', 699.99, 'Credit Card');

INSERT INTO REVIEWS (PRODUCTID, USERID, RATING,COMMENT)
VALUES
(1, 1, 5, 'Excellent laptop, highly recommend!'),
(2, 2, 4, 'Great smartphone, but a bit pricey.'),
(3, 3, 3, 'Tablet is okay, but could be better.'),
(4, 4, 5, 'Loved the novel, a great read.'),
(5, 5, 4, 'T-shirt is comfortable and fits well.');

INSERT INTO CART (USERID, PRODUCTID,QUANTITY)
VALUES
(1, 1, 1),
(1, 4, 2),
(2, 3, 1),
(3, 5, 3),
(4, 2, 1),
(5, 6, 2);

UPDATE USERS
SET EMAIL = 'JOHN_NEW@EXAMPLE.COM'
WHERE USERID = 1;

SELECT PRODUCTNAME, PRICE, STOCKQUANTITY FROM PRODUCTS; 
SELECT * FROM PRODUCTS WHERE PRICE > 500;
SELECT * FROM PRODUCTS WHERE PRICE < 500;
SELECT USERNAME, EMAIL, PHONENUMBER FROM USERS;
SELECT * FROM PRODUCTS ORDER BY PRICE DESC;
SELECT * FROM PRODUCTS ORDER BY PRICE ASC;
SELECT CATEGORYID, COUNT (*) AS PRODUCTCOUNT
FROM PRODUCTS
GROUP BY CATEGORYID;
SELECT USERID, SUM(TOTALAMOUNT) AS
TOTALSPENT
FROM ORDERS
GROUP BY USERID;

SELECT CATEGORYID, AVG(PRICE) AS
AVGPRICE
FROM PRODUCTS
GROUP BY CATEGORYID;

SELECT
Orders.OrderID,
USERS.USERNAME,
Orders.TotalAmount,
Orders.OrderDate 
FROM Orders
INNER JOIN
USERS ON ORDERS.UserID = USERS.USERID;

SELECT 
PRODUCTS.PRODUCTNAME,
CATEGORIES.CATEGORYNAME
FROM PRODUCTS
INNER JOIN
CATEGORIES ON PRODUCTS.CATEGORYID = CATEGORIES.CATEGORYID;

SELECT
Orders.OrderID,
PRODUCTS.PRODUCTNAME,
ORDERDETAILS.QUANTITY,
ORDERDETAILS.PRICE,
Orders.OrderDate
FROM ORDERDETAILS
INNER JOIN
Orders ON  ORDERDETAILS.ORDERID = Orders.OrderID
INNER JOIN
PRODUCTS ON ORDERDETAILS.PRODUCTID = PRODUCTS.PRODUCTID;

SELECT PRODUCTNAME
FROM PRODUCTS WHERE PRODUCTID NOT IN ( SELECT DISTINCT PRODUCTID FROM ORDERDETAILS);

SELECT TOP 3 PRODUCTS.PRODUCTNAME,
SUM (ORDERDETAILS.QUANTITY) AS TOTALSOLD
FROM ORDERDETAILS INNER JOIN PRODUCTS ON ORDERDETAILS.PRODUCTID = PRODUCTS.PRODUCTID
GROUP BY PRODUCTS.PRODUCTNAME ORDER BY TOTALSOLD DESC;

SELECT ORDERID, CASE WHEN TOTALAMOUNT < 100 THEN 'SMALL ORDER' WHEN TOTALAMOUNT BETWEEN 100 AND 500 THEN 'MEDIUM ORDER'
ELSE 'LARGER ORDER' END AS ORDERCATEGORY FROM Orders;

UPDATE PRODUCTS
SET STOCKQUANTITY = STOCKQUANTITY - 1
WHERE PRODUCTID =1;

UPDATE PRODUCTS
SET STOCKQUANTITY = STOCKQUANTITY - 1
WHERE PRODUCTID =3;

DELETE FROM Orders WHERE OrderStatus = 'CANCELED'

UPDATE Orders
SET OrderStatus = 'CANCELED' WHERE OrderID = 3;

select * from CATEGORIES;	
insert into CATEGORIES (CATEGORYNAME,DESCRIPTION)
values ('toys','toys for children of all ages');

select ORDERDATE,
SUM (TOTALAMOUNT) OVER (ORDER BY ORDERDATE) AS RUNNINGTOTAL FROM ORDERS;

SELECT
PRODUCTS.PRODUCTNAME, 
SUM (ORDERDETAILS.QUANTITY) AS TOTALSOLD,
RANK() OVER (ORDER BY SUM(ORDERDETAILS.QUANTITY)DESC)
AS SALESRANK
FROM ORDERDETAILS
INNER JOIN PRODUCTS ON ORDERDETAILS.PRODUCTID = PRODUCTS.PRODUCTID
GROUP BY PRODUCTS.PRODUCTNAME;

SELECT
YEAR(ORDERDATE) AS YEAR,
MONTH(ORDERDATE) AS MONTH,
SUM(TOTALAMOUNT) AS TOTALSALES
FROM Orders
GROUP BY YEAR (OrderDate),
MONTH(OrderDate)
ORDER BY YEAR, MONTH;

SELECT USERID, COUNT(*)
FROM USERS
GROUP BY USERID
HAVING COUNT (*) > 5;

SELECT USERID, COUNT(ORDERID) AS
ORDERCOUNT
FROM Orders
GROUP BY UserID
HAVING COUNT(OrderID) > 1;

SELECT * FROM ORDERS
WHERE USERID IS NULL OR TotalAmount IS NULL;