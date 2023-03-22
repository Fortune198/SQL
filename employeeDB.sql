

CREATE TABLE Employees (
	emp_id bigserial PRIMARY KEY,
	first_name varchar(30) NOT NULL,
	surname varchar(30) NOT NULL,
	gender varchar(1) NOT NULL,
	address varchar(100) NOT NULL,
	email varchar(50) UNIQUE NOT NULL,
	depart_id bigint REFERENCES Departments(depart_id),
	role_id bigint REFERENCES Roles(role_id),
	salary_id bigint REFERENCES Salaries(salary_id),
	overtime_id bigint REFERENCES Overtime_Hours(overtime_id)
);

INSERT INTO Employees 
VALUES 
(1,'Samantha','Smith','F','5467 1st str','samsmith198@gmail.com',1,1,1,2),
(2,'Rethabile','Nawe','M','9897 bull str','rethabilen1@gmail.com',2,4,2,3),
(3,'Samson','Ndlamlenze','M','3251 14th Ave','samsonndlamlenze@gmail.com',3,3,3,1),
(4,'Wendy','Lovemore','F','2133 Goat str','wendylovemore1211@outlook.com',4,2,4,4);

SELECT * FROM Employees;

DROP TABLE Employees;
DROP TABLE Departments;
DROP TABLE Roles;
DROP TABLE Salaries;
DROP TABLE Overtime_Hours;
=====================================================================


CREATE TABLE Departments (
	depart_id bigserial PRIMARY KEY,
	depart_name varchar(30),
	depart_city varchar(30)
);

INSERT INTO Departments (depart_name, depart_city)
VALUES 
('operations management','New York'),
('human resources','New York'),
('finance','Washington DC'),
('marketing','Baltimore');

SELECT * FROM Departments;

==========================================================================================================================


CREATE TABLE Roles (
	role_id bigserial PRIMARY KEY,
	role varchar(30) NOT NULL
);

INSERT INTO Roles (role)
VALUES 
('manager'),
('brand manger'),
('book keeping'),
('receptionist');

SELECT * FROM Roles;
========================================================================================================================


CREATE TABLE Salaries (
	salary_id bigserial PRIMARY KEY,
	salary_pa numeric
);

INSERT INTO Salaries (salary_pa)
VALUES 
(55000),
(12000),
(70000),
(50000);

SELECT * FROM Salaries;

=====================================================================================================================


CREATE TABLE Overtime_Hours (
	overtime_id bigserial PRIMARY KEY,
	overtime_hours numeric
);

INSERT INTO Overtime_Hours (overtime_hours)
VALUES 
(0.5),
(1),
(2),
(3);

SELECT * FROM Overtime_Hours;
=================================================================================================================================================================================================

--left join


SELECT Departments.depart_name, Roles.role, Salaries.salary_pa, Overtime_Hours.overtime_hours
FROM Employees
LEFT JOIN Departments 
ON Employees.depart_id = Departments.depart_id
LEFT JOIN Roles 
ON Employees.role_id = Roles.role_id
LEFT JOIN Salaries 
ON Employees.salary_id = Salaries.salary_id
LEFT JOIN Overtime_Hours 
ON Employees.overtime_id = Overtime_Hours.overtime_id;
