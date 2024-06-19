/* JOINS
---> Joins are used to combine two or more tables to get specific data/information
-- Join is mainly of 6 types:
--1. Inner Join
--2. Left Outer Join
--3. Right Outer Join
--4. Full Outer Join
--5. Self Join
--6. Cross Join
*/
-- Creating database
CREATE DATABASE ola;

-- Using database
USE ola;

-- Creating table Drivers - did, dname, age, phone_no
CREATE TABLE drivers (
    did INT PRIMARY KEY,
    dname VARCHAR(50) NOT NULL,
    age INT,
    phone_no BIGINT NOT NULL
);

-- Creating table Customers - cid, cname, age, addr
CREATE TABLE customers (
    cid INT PRIMARY KEY,
    cname VARCHAR(50) NOT NULL,
    age INT,
    addr VARCHAR(100)
);

-- Creating table Rides - ride_id, cid, did, fare
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    cid INT,
    did INT,
    fare INT NOT NULL,
    FOREIGN KEY (cid) REFERENCES customers(cid),
    FOREIGN KEY (did) REFERENCES drivers(did)
);

-- Creating table Payment - pay_id, ride_id, amount, mode (upi, credit, debit), status
CREATE TABLE payment (
    pay_id INT PRIMARY KEY,
    ride_id INT,
    amount INT NOT NULL,
    mode VARCHAR(30) CHECK (mode IN ('upi', 'credit', 'debit')),
    status VARCHAR(30),
    FOREIGN KEY (ride_id) REFERENCES rides(ride_id)
);

-- Creating table Employee - eid, ename, phone_no, department, manager_id
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50) NOT NULL,
    phone_no BIGINT NOT NULL,
    department VARCHAR(50) NOT NULL,
    manager_id INT
);

-- Inserting values into Drivers table
INSERT INTO drivers VALUES (1, 'Amit', 30, 9876543210);
INSERT INTO drivers VALUES (2, 'Arpita', 25, 8765432109);
INSERT INTO drivers VALUES (3, 'Ravi', 35, 7654321098);
INSERT INTO drivers VALUES (4, 'Rohan', 28, 6543210987);
INSERT INTO drivers VALUES (5, 'Manish', 22, 5432109876);

-- Inserting values into Customers table
INSERT INTO customers VALUES (101, 'Ravi', 30, 'Mumbai');
INSERT INTO customers VALUES (102, 'Rahul', 25, 'Delhi');
INSERT INTO customers VALUES (103, 'Simran', 32, 'Bangalore');
INSERT INTO customers VALUES (104, 'Aayush', 28, 'Mumbai');
INSERT INTO customers VALUES (105, 'Tarun', 22, 'Delhi');

-- Inserting values into Rides table
INSERT INTO rides VALUES (1001, 101, 1, 500);
INSERT INTO rides VALUES (1002, 102, 2, 300);
INSERT INTO rides VALUES (1003, 103, 3, 200);
INSERT INTO rides VALUES (1004, 104, 4, 400);
INSERT INTO rides VALUES (1005, 105, 5, 150);

-- Inserting values into Payment table
INSERT INTO payment VALUES (1, 1001, 500, 'upi', 'completed');
INSERT INTO payment VALUES (2, 1002, 300, 'credit', 'completed');
INSERT INTO payment VALUES (3, 1003, 200, 'debit', 'in process');

-- Inserting values into Employee table
INSERT INTO employee VALUES (201, 'Aryan', 9876543210, 'Sales', 205);
INSERT INTO employee VALUES (202, 'Japjot', 8765432109, 'Delivery', 206);
INSERT INTO employee VALUES (203, 'Vansh', 7654321098, 'Delivery', 202);
INSERT INTO employee VALUES (204, 'Rishika', 6543210987, 'Sales', 202);
INSERT INTO employee VALUES (205, 'Sanjana', 5432109876, 'HR', 204);
INSERT INTO employee VALUES (206, 'Sanjay', 4321098765, 'Tech', NULL);

/* Different Types of Joins:
--1) Inner Join: Matching values from both tables should be present
-- Example 1: Get customer names who took rides
SELECT customers.cid, cname, rides.ride_id FROM rides
INNER JOIN customers ON rides.cid = customers.cid;

-- Example 2: Get customer names and driver names from rides
SELECT customers.cid, cname, drivers.did, dname, ride_id FROM rides
INNER JOIN drivers ON rides.did = drivers.did
INNER JOIN customers ON rides.cid = customers.cid;

--2)Left outer Join: All the rows from the left table should be present and matching rows from the right table are present.
-- Example: Get all drivers and their ride fares (if any)
SELECT drivers.did, dname, fare, rides.ride_id FROM drivers
LEFT JOIN rides ON rides.did = drivers.did;

--3)Right Join: All the rows from the right table should be present and only matching rows from the left table are present.
-- Example: Get all ride details and their payment status
SELECT * FROM payment
RIGHT JOIN rides ON rides.ride_id = payment.ride_id;

--4) Full outer Join: All the rows from both the table should be present 
-- Example: Get all rides and driver details
SELECT rides.ride_id, drivers.did, dname, fare FROM rides
LEFT JOIN drivers ON rides.did = drivers.did
UNION
SELECT rides.ride_id, drivers.did, dname, fare FROM rides
RIGHT JOIN drivers ON rides.did = drivers.did;

--5)Self Join: It is a regular join, but the table is joined by itself.
-- Example: Get employees and their managers
SELECT e1.ename AS Employee, e2.ename AS Manager FROM employee e1
INNER JOIN employee e2 ON e1.manager_id = e2.eid;

--6)Cross Join: It is used to view all the possible combinations of the rows of one table and with all the rows from second table.
-- Example: Get all combinations of customers and their rides where fare is greater than 200
SELECT customers.cid, cname, rides.ride_id, fare FROM customers
CROSS JOIN rides ON customers.cid = rides.cid
WHERE fare > 200;
--Quires: 
-- Display details of all rides which were taken from "Mumbai"
SELECT rides.*, customers.cname AS customer_name
FROM rides
INNER JOIN customers ON rides.cid = customers.cid
WHERE customers.addr = 'Mumbai';

--  Display details of all rides whose payment was made through "UPI"
SELECT rides.*, payment.mode AS payment_mode
FROM rides
INNER JOIN payment ON rides.ride_id = payment.ride_id
WHERE payment.mode = 'upi';

-- Display ride_id, fare, cname, payment mode of rides which were taken by people below 30 years and payment was made through "Credit".
SELECT rides.ride_id, rides.fare, customers.cname, payment.mode
FROM rides
INNER JOIN customers ON rides.cid = customers.cid
INNER JOIN payment ON rides.ride_id = payment.ride_id
WHERE customers.age < 30 AND payment.mode = 'credit';

-- Display ride_id, fare, cname, dname, phone_no of the rides whose payment is still pending or in process.
SELECT rides.ride_id, rides.fare, customers.cname, drivers.dname, drivers.phone_no
FROM rides
INNER JOIN customers ON rides.cid = customers.cid
INNER JOIN drivers ON rides.did = drivers.did
INNER JOIN payment ON rides.ride_id = payment.ride_id
WHERE payment.status IN ('in process', 'pending');

--  Display details of rides, drivers, and details of the customer who took the ride
SELECT rides.ride_id, customers.cname AS customer_name, drivers.dname AS driver_name
FROM rides
INNER JOIN customers ON rides.cid = customers.cid
INNER JOIN drivers ON rides.did = drivers.did;
*/