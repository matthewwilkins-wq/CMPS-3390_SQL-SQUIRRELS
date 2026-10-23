/*
TEAM NAME: SQL Squirrels
TEAM MEMBERS' NAME: Ben Verbois, Matthew Wilkins, Noah Day


Instructions
- Descriptions must reflect a business operation's need
- One query for each item (Q..) is enough. E.g., for QD1: CREATE TABLE, write a DDL query to create one of your project's tables. Similar for the others.
- You must use the exact format
- Project a few attributes only unless otherwise said
- Do not change the order of the queries
*/

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DDL QUERIES   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--QD1: CREATE TABLE ...
CREATE TABLE Employees (
    EmployeeId VARCHAR(10) NOT NULL,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    SSN CHAR(9) NOT NULL,
    Position VARCHAR(64) NOT NULL,
    HireDate DATE NOT NULL DEFAULT GETDATE(),
    DepartmentId INT,

    PRIMARY KEY (EmployeeId)
)

--INSERT INTO Employees TABLE (needed for DML tests)
INSERT INTO Employees (EmployeeId, FirstName, LastName, SSN, Position, DepartmentId) VALUES
('EMP1', 'Alice', 'Test', '111111111', 'Marketing Coordinator', 111),
('EMP2', 'Bob', 'Test', '222222222', 'Marketing Coordinator', 111),
('EMP3', 'Carl', 'Test', '333333333', 'Cashier', 666),
('EMP4', 'Dana', 'Test', '444444444', 'Stock Clerk', 222),
('EMP5', 'Evan', 'Test', '555555555', 'Store Manager', 777);

--CREATE Departments TABLE (needed for foreign keys & DML tests)
CREATE TABLE Departments (
    DepartmentId    INT          NOT NULL PRIMARY KEY,
    DepartmentName  VARCHAR(50)  NOT NULL
);

--INSERT INTO Departments TABLE (needed for foreign keys & DML tests)
INSERT INTO Departments (DepartmentId, DepartmentName) VALUES
(111, 'Marketing'), (222, 'Electronics'), (333, 'Toys'), (444, 'Clothing'),
(555, 'Furniture'), (666, 'Checkout'), (777, 'Management');

--QD2: ALTER TABLE ...
----Description: Change Employees.LastName to have a maximum size of 64
ALTER TABLE Employees ALTER COLUMN LastName VARCHAR(64) NOT NULL;

--QD3: ADD "CHECK" CONSTRAINT:
----Description: Check that Employees.FirstName only contains letters.
ALTER TABLE Employees
ADD CONSTRAINT CK_FirstName_Letters
CHECK (FirstName NOT LIKE '%[^a-zA-Z]%');

--QD4: ADD FK CONSTRAINT(S) TO THE TABLE
----Description: Every employee must work in a department that exists. If a department
----gets deleted, its employees are not removed, they are moved to the default
----Management department (777) until they are reassigned. If a department's ID
----changes, its employees' records follow it automatically.
ALTER TABLE Employees
ADD CONSTRAINT DF_Employees_DepartmentId DEFAULT 777 FOR DepartmentId;

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments
    FOREIGN KEY (DepartmentId) REFERENCES Departments (DepartmentId)
    ON DELETE SET DEFAULT
    ON UPDATE CASCADE;

--QD5: Create TRIGGER ...
----Description: .....................



-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DML QUERIES   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


--QM1.1: A TEST QUERY FOR THE TRIGGER CREATED in QD5:
----Description: .....................


--QM1.2: A TEST QUERY FOR THE "CHECK" CONSTRAINT DEFINED in QD3:
----Description: HR accidentally types a number into a new cashier's first name
----("J0hn" with a zero). The CHECK constraint will reject the insert.
INSERT INTO Employees (EmployeeId, FirstName, LastName, SSN, Position, DepartmentId)
VALUES ('EMP11', 'J0hn', 'Smith', '123456789', 'Cashier', 666);

--QM1.3: A TEST QUERY FOR THE FK CONSTRAINT DEFINED in QD4:
----Description: The store closes the Marketing department (111).
----Its employees are kept, and the FK's ON DELETE SET DEFAULT action
----moves them to the Management department (777).
SELECT EmployeeId, FirstName, LastName, Position, DepartmentId
FROM Employees
WHERE DepartmentId IN (111, 777);

DELETE FROM Departments
WHERE DepartmentId = 111;

SELECT EmployeeId, FirstName, LastName, Position, DepartmentId
FROM Employees
WHERE DepartmentId IN (111, 777);