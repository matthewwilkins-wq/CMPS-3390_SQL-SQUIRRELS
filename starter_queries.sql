TRUNCATE TABLE Employees;
DELETE FROM Departments WHERE (DepartmentId IS NOT NULL);

INSERT INTO Departments (DepartmentId, DepartmentName) VALUES 
(111, 'Marketing'),
(222, 'Electronics'),
(333, 'Toys'),
(444, 'Clothing'),
(555, 'Furniture');

INSERT INTO Employees 
  (EmployeeId, FirstName, LastName, SSN, Position, HireDate, DepartmentId)
VALUES 
('EMP1', 'Coleen', 'McLachlan', '000000000', 'Marketing Coordinator', '11/08/2026', 111),
('EMP2', 'Manfred', 'Bib', '111111111', 'Marketing Coordinator', '12/29/2010', 111),
('EMP3', 'Brittani', 'Stubbings', '222222222', 'Cashier', '6/27/2021', NULL);