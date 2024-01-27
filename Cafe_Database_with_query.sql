-- ITCS 1170R1601 2023
-- Group# 4
-- Drake Weller , Micheal Blendl ,Biswanath Chakraborty, Paolo Delapena, Sean-Douglas Yang

--The group collectively discussed and wrote and edited the code
-- SPECEFICS 
--Sean wrote most of the insert statements
--Drake did most of the bugFixes and created tables to fix circular dependency 
--Paolo Wrote most of the tables from ERD
--Michael lead the group on the use of github
--Biswanath helped with a mix of everything and added the commments

USE master;
GO

drop database CoffeeShopDB;
GO

Create database CoffeeShopDB;
GO

use CoffeeShopDB;
GO
-- Table to store customer information
CREATE TABLE CUSTOMERS (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(2)
);

-- Table to store customer information
CREATE TABLE POSITIONS (
    PositionID INT PRIMARY KEY,
    Job VARCHAR(50)
);

-- Table to store customer information
CREATE TABLE EMPLOYEES (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    SSN VARCHAR(11),  --changed the (9) to (11)
    Address VARCHAR(255),
    DOB DATE,
    StartDate DATE,
    TerminationDate DATE
);

-- Table to store customer information
CREATE TABLE EMPLOYEE_POSITION_HISTORY (
    HistoryID INT PRIMARY KEY,
    EmployeeID INT,
    PositionID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID),
    FOREIGN KEY (PositionID) REFERENCES POSITIONS(PositionID)
);

-- Table to store discount information
CREATE TABLE DISCOUNTS (
    DiscountID INT PRIMARY KEY,
    Discount DECIMAL(5,2)
);

-- Table to store inventory information
CREATE TABLE INVENTORY (
    InventoryID INT PRIMARY KEY,
    Cups INT,
    CoffeeBeans INT,
    Lids INT,
    Creamer INT,
    Sugar INT
);

-- Table to store information about different drinks
CREATE TABLE DRINKS (
    DrinkID INT PRIMARY KEY,
    DrinkType VARCHAR(50),
    DrinkSold INT,
    InventoryID INT,
    Calories INT,
    Price DECIMAL(5,2),
    FOREIGN KEY (InventoryID) REFERENCES INVENTORY(InventoryID)
);

-- Table to store order information
CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY,
    OrderNumber VARCHAR(20),
    PaymentMethod VARCHAR(20),
    DrinkID INT,
    CustomerID INT,
    DiscountID INT,
    EmployeeID INT,
    TotalAmount DECIMAL(8,2),
    FOREIGN KEY (DrinkID) REFERENCES DRINKS(DrinkID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID),
    FOREIGN KEY (DiscountID) REFERENCES DISCOUNTS(DiscountID),
    FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID)
);


-- Inserting data into the CUSTOMERS table
Insert Into CUSTOMERS (CustomerID, FirstName, LastName, Phone, Email, Address, City, State)
Values
--BUGFIX: Added commas at the end of each line and a semicolon after the last
(01, 'Jake', 'Hughs', '586-583-8125', 'JakeHughs@email.com', '001 Road', 'Warren', 'MI'),
(02, 'Shelly', 'Maker', '586-743-3477', 'ShellyMaker@email.com', '002 Road', 'Warren', 'MI'),
(03, 'John', 'Doe', '586-347-7358', 'JohnDoe@email.com', '003 Road', 'Warren', 'MI'),
(04, 'Susan', 'Roald', '586-182-7134', 'SusanRoald@email.com', '004 Road', 'Warren', 'MI'),
(05, 'Sarah', 'Duck', '586-123-3456', 'SarahDuck@email.com', '005 Road', 'Warren', 'MI'),
(06, 'Aaron', 'Rodgers', '586-612-3121', 'AaronRodgers@email.com', '006 Road', 'Warren', 'MI'),
(07, 'Blake', 'Griffin', '586-111-8714', 'BlakeGriffin@email.com', '007 Road', 'Warren', 'MI'),
(08, 'Penny', 'Quaters', '586-173-1111', 'PennyQuaters@email.com', '008 Road', 'Warren', 'MI'),
(09, 'Lauren', 'King', '586-163-8335', 'LaurenKing@email.com', '009 Road', 'Warren', 'MI'),
(10, 'Dominic', 'Rake', '586-172-8174', 'DominicRake@email.com', '010 Road', 'Warren', 'MI');


-- Inserting data into the EMPLOYEES table
Insert Into EMPLOYEES (EmployeeID, FirstName, LastName, Phone, SSN, Address, DOB, StartDate, TerminationDate)
Values
--BUGFIX: Added commas at the end of each line and a semicolon after the last
(01, 'Justin', 'Crew', '586-126-4311', '123-12-1234', '0001 Ave', '19771021', '20030119', ''),    -- need to change date to yyyymmddd
(02, 'Conor', 'Long', '586-611-5411',  '123-48-4687', '0002 Ave', '19810120', '20030124', ''),
(03, 'Evan', 'Stew', '586-138-4613',  '123-98-7987', '0003 Ave', '19780321', '20030221', ''),
(04, 'Joel', 'Johnson', '586-134-4381',  '684-48-8798', '0004 Ave','20001109', '20030312', ''),
(05, 'Venus', 'Mars', '586-947-7987',  '467-79-4368', '0005 Ave', '19991027', '20030316', ''),
(06, 'Eden', 'Garden', '586-138-7358',  '123-46-7987', '0006 Ave', '19780612', '20030418', ''),
(07, 'Erich', 'Wright', '586-798-4987',  '146-73-1379', '0007 Ave', '19970524', '20030415', ''),
(08, 'Maila', 'Lore', '586-376-7987', '798-14-7681', '0008 Ave', '19850107', '20030501' , ''),
(09, 'Joseph', 'Strongman', '586-494-4321',  '167-77-7777', '0009 Ave', '19800922', '20030526', ''),
(10, 'Johnathan', 'Weakman', '586-468-4683', '434-73-7337', '0010 Ave', '19951225', '20030528', '');


-- Inserting data into the POSITIONS table
Insert Into POSITIONS(PositionID, Job)
Values
--BUGFIX: Changed JOB_POSITION to POSITIONS and deleted the EmployeeID Value
(01, 'Manager'),
(02, 'Cashier'),
(03, 'Stocker'),
(04, 'Barista'),
(05, 'Janitor');

-- Inserting data into the DISCOUNTS table
Insert Into DISCOUNTS (DiscountID, Discount)
Values
--BUGFIX: deleted the extra zeros
(1 , 0.00),
(2, 0.25),
(3,0.5),
(4, 0.75);


--Added inventory table due to error with Drinks Table, well moved it about drinks
-- Inserting data into the INVENTORY table
INSERT INTO INVENTORY (InventoryID, Cups, CoffeeBeans, Lids, Creamer, Sugar)
VALUES
(1, 178, 46, 214, 14, 27),
(2, 150, 75, 250, 15, 25),
(3, 120, 60, 180, 8, 18);




-- Inserting data into the DRINKS table
Insert Into DRINKS (DrinkID, DrinkType, DrinkSold, InventoryID, Calories, Price)
Values
-- BUGFIX :deleted the ' ' from the int and and Added commas at the end of each line and a semicolon after the last
(01,'Hot Tea', 23, 01, 80, 0.99),
(02,'Lemonade', 41, 01, 120, 2.99),
(03,'Fruit Drink', 21, 01, 220, 3.99),
(04,'Hydrator', 31, 01, 70, 3.99),
(05,'Coffee', 55, 01, 00, 1.50),
(06,'Latte', 45, 01, 180, 2.99),
(07,'Espresso', 17, 01, 10, 1.99),
(08,'Frozen', 08, 01, 220, 4.99),
(09,'Iced Tea', 27, 01, 120, 2.99),
(10,'Juice', 12, 01, 80, 1.99);


-- Inserting data into the ORDERS table
Insert Into ORDERS (OrderID, OrderNumber, DrinkID, CustomerID, DiscountID, EmployeeID, TotalAmount)  -- Extra customer ID in the Values, deleted it
Values
--BugFix: typos and Added commas at the end of each line and a semicolon after the last
(01, 01, 01, 01, 001, 03, 0.99),
(02, 02, 02, 02, 001, 04, 2.99),
(03, 03, 03, 03, 002, 03, 3.99),
(04, 04, 04, 04, 002, 03, 3.99),
(05, 05, 05, 05, 001, 04, 1.50),
(06, 06, 06, 06, 004, 03, 1.50),
(07, 07, 07, 07, 001, 03, 1.50),
(08, 08, 08, 08, 003, 03, 2.99),
(09, 09, 09, 09, 001, 04, 1.99),
(10, 10, 10, 10, 001, 04, 4.99);




-- Count the number of orders made by each customer
--outerjoin 
SELECT CUSTOMERS.CustomerID, 
	   FirstName, 
	   LastName, 
	   COUNT(ORDERS.OrderID) AS 'Number Of Orders'
FROM CUSTOMERS LEFT JOIN ORDERS
ON CUSTOMERS.CustomerID = ORDERS.CustomerID
GROUP BY CUSTOMERS.CustomerID, FirstName, LastName;


-- Select customers who made orders  

--SubQuery with WHERE cluase
SELECT
    FirstName,
    LastName,
    Phone,
    Email
FROM
    CUSTOMERS
WHERE
    CustomerID IN (
        -- Subquery to get the CustomerIDs of customers who have placed orders
        SELECT
            DISTINCT CustomerID
        FROM
            ORDERS);
  



-- Query: Total amount for each customer Having statement
SELECT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    SUM(O.TotalAmount) AS 'TotalOrderAmount'
FROM CUSTOMERS C LEFT JOIN ORDERS O 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING SUM(O.TotalAmount) > 2.00;


-- Query: MultiTable join
SELECT
    ORDERS.OrderID,
    ORDERS.OrderNumber,
    CUSTOMERS.FirstName AS 'CustomerFirstName',
    CUSTOMERS.LastName AS 'CustomerLastName',
    DRINKS.DrinkType,
    DRINKS.Price,
    EMPLOYEES.FirstName AS 'EmployeeFirstName',
    EMPLOYEES.LastName AS 'EmployeeLastName'
FROM ORDERS JOIN CUSTOMERS
	ON ORDERS.CustomerID = CUSTOMERS.CustomerID
JOIN DRINKS
	ON ORDERS.DrinkID = DRINKS.DrinkID
JOIN EMPLOYEES 
	ON ORDERS.EmployeeID = EMPLOYEES.EmployeeID;


-- Query to retrieve customer names and employee names.
SELECT
    FirstName,
    LastName
FROM
    CUSTOMERS
UNION
SELECT
    FirstName,
    LastName
FROM
    EMPLOYEES;