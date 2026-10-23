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
    HireDate DATE NOT NULL,
    DepartmentId INT,

    PRIMARY KEY (EmployeeId)
)

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
----Description: .....................


--QM1.3: A TEST QUERY FOR THE FK CONSTRAINT DEFINED in QD4:
----Description: .....................


