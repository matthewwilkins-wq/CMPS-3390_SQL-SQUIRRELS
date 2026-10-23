--CREATE TABLE
CREATE TABLE Departments (
    DepartmentId    INT          NOT NULL PRIMARY KEY,
    DepartmentName  VARCHAR(50)  NOT NULL
);

--INSERT INTO TABLE
INSERT INTO Departments (DepartmentId, DepartmentName) VALUES
(111, 'Marketing'), (222, 'Electronics'), (333, 'Toys'), (444, 'Clothing'),
(555, 'Furniture'), (666, 'Checkout'), (777, 'Management');