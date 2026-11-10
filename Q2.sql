/*
TEAM NAME: SQL Squirrels
TEAM MEMBERS' NAME: Ben Verbois, Matthew Wilkins, Noah Day


Instructions
- Descriptions must reflect a business operation's need
- One query for each item (Q..) is enough. E.g.,�for�QD1: CREATE TABLE, write a DDL query to create one of your project's tables. Similar for the others.
- You must use the exact format
- Project a few attributes only unless otherwise said
- Do not change the order of the queries
*/


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DML QUERIES   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--QM2: INSERT DATA:
----Description: Create a new employee and assign them to a Department.
INSERT INTO Employees 
  (EmployeeId, FirstName, LastName, SSN, Position, HireDate, DepartmentId)
VALUES 
  ('EMP4', 'Merlina', 'Krysztofowicz', '333333333', 'Stock Clerk', '2/21/2021', 222);

--QM3: UPDATE DATA:
----Description: Update Employee 'EMP4' to change their position to 'Sales Associate'.

SELECT *
FROM Employees

UPDATE Employees
SET Position = 'Sales Associate'
WHERE EmployeeId = 'EMP4';

--QM4: DELETE DATA:
----Description: Delete the employee with Id 'EMP4' from the Employees table.

DELETE FROM Employees
WHERE EmployeeId = 'EMP4';

SELECT *
FROM Employees
WHERE EmployeeId = 'EMP4';

--QM5: QUERY DATA WITH WHERE CLAUSE:
----Description: Retrieve the employee with Id 'EMP4' and all employees
----hired after 1/1/2020 that work in department 111.

SELECT *
FROM Employees
WHERE (EmployeeId = 'EMP4') OR 
      ( (DepartmentId = 111) AND
        (HireDate > '1/1/2020') 
      );


--QM6.1: QUERY DATA WITH 'SUB-QUERY IN WHERE CLAUSE':
----Description: Retrieve EMP4 and employees in department 111 hired after 1/1/2020 using a subquery.

SELECT *
FROM Employees
WHERE EmployeeId = 'EMP4'
OR EmployeeId IN (
    SELECT EmployeeId
    FROM Employees
    WHERE DepartmentId = 111
    AND HireDate > '2020-01-01'
);

--QM6.2: QUERY DATA WITH SUB-QUERY IN FROM CLAUSE:
----Description: Retrieve the FirstName and DepartmentId of all 
----employees with a non-null DepartmentId equal to 111.

SELECT EMPS.FirstName, EMPS.DepartmentId
FROM (SELECT * FROM Employees WHERE DepartmentId IS NOT NULL) AS EMPS
WHERE (EMPS.DepartmentId = 111);

--QM6.3: QUERY DATA WITH 'SUB-QUERY IN SELECT CLAUSE':
----Description: Retrieves the employees names and the department
----they work in for employees hired since 2015.

SELECT E.FirstName, E.LastName, E.Position,
       (SELECT D.DepartmentName FROM Departments D WHERE D.DepartmentId = E.DepartmentId) AS DepartmentName
FROM Employees E
WHERE E.HireDate >= '2015-01-01';


--QM7: QUERY DATA WITH EXCEPT:
----Description: Retrieve the DepartmentId for all Departments which do not 
----have any employees.
SELECT DepartmentId FROM Departments
EXCEPT
SELECT DepartmentId FROM Employees

--QM8.1: QUERY DATA WITH ANY/SOME:
----Description: Retrieves a list of departments that currently
----have staff in them, meaning at least one employee works in them.

SELECT DepartmentId, DepartmentName
FROM Departments
WHERE DepartmentId = ANY (SELECT DepartmentId FROM Employees);


--QM8.2: QUERY DATA WITH ALL in front of a sub-query:
----Description: Retrieves the longest working employee:
----the one hired on or before every other employee.

SELECT FirstName, LastName, Position, HireDate
FROM Employees
WHERE HireDate <= ALL (SELECT HireDate FROM Employees);