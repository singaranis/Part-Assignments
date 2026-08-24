CREATE DATABASE employee;
USE employee;

/*Create a Database for this project  
 Create all three tables in MySQL with appropriate data types and relationships*/

CREATE TABLE Departments(department_id  int Primary Key,department_name Varchar(100));

CREATE TABLE Location(location_id int Primary Key ,location_name Varchar(30));

CREATE TABLE Employees( employee_id int Primary Key,Employee_name Varchar(50), Gender Enum('M','F'), Age int,
Hire_date Date, Designation Varchar(100), Salary Decimal(10,2), department_id int ,location_id int ,
Foreign Key (department_id)references Departments(department_id) ,
Foreign Key (location_id)references Location(location_id));

##INSERTING VALUES
INSERT INTO Departments (department_id, department_name)
VALUES(1, 'HR'),(2, 'Finance'),(3, 'IT'),(4, 'Sales');

INSERT INTO Location (location_id, location_name)
VALUES(101, 'Chennai'),(102, 'Bangalore'),(103, 'Hyderabad'),(104, 'Mumbai');

INSERT INTO Employees
(employee_id, Employee_name, Gender, Age, Hire_date, Designation, Salary, department_id, location_id)
VALUES
(1, 'Arun', 'M', 28, '2022-06-15', 'Data Analyst', 45000.00, 3, 101),
(2, 'Priya', 'F', 26, '2023-01-10', 'HR Executive', 38000.00, 1, 101),
(3, 'Rahul', 'M', 32, '2021-03-20', 'Finance Analyst', 52000.00, 2, 102),
(4, 'Divya', 'F', 29, '2022-09-05', 'Sales Executive', 42000.00, 4, 103),
(5, 'Karthik', 'M', 35, '2020-11-18', 'Senior Developer', 68000.00, 3, 104);

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Location;

## Add a new column named "email" to the Employees table to store employee email addresses.
ALTER  TABLE Employees ADD COLUMN email Varchar(100);
UPDATE Employees SET email = 'arunk@gmail.com' WHERE employee_id = 1;
UPDATE Employees SET email = 'priyas@gmail.com' WHERE employee_id = 2;
UPDATE Employees SET email = 'rahuls@gmail.com' WHERE employee_id = 3;
UPDATE Employees SET email = 'divyah@gmail.com' WHERE employee_id = 4;
UPDATE Employees SET email = 'karthikk@gmail.com' WHERE employee_id =5;

##Modify the data type of the "designation" column in the Employees table to support a wider range of values. 
ALTER TABLE Employees MODIFY COLUMN Designation VARCHAR(200);

##Drop the “age” column from the Employees table.  
ALTER TABLE Employees DROP COLUMN Age;

##Rename the “hire_date” column to “date_of_joining”. 
ALTER TABLE Employees RENAME COLUMN Hire_date TO Date_of_joining;

##Rename the "Departments" table to "Departments_Info". 
RENAME TABLE Departments TO Departments_Info;
SELECT * FROM Departments_Info;

##Rename the "Location" table to "Locations".  
RENAME TABLE Location TO Locations;
SELECT * FROM Locations;

##Truncate the Employees table. 
TRUNCATE TABLE Employees;

##Drop the Employees table and then the “employee” database.  
DROP TABLE Employees;
DROP DATABASE employee;
USE employee;

/*Tasks: Constraints - 
1. Database Recreation:  
● Drop the 'employee' database if it exists  */
DROP DATABASE IF EXISTS employee;
 
##Recreate it using the provided schema, ensuring that all tables are created with the appropriate constraints as instructed.
CREATE DATABASE employee;
USE employee;

/* Departments Table:  
● Ensure that the "department_id" uniquely identifies each department.  
● Set up constraints on the "department_name" to avoid duplicate and null 
entries.*/
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO Departments (department_id, department_name)
VALUES
(1, 'HR'),(2, 'Finance'),(3, 'IT'),(4, 'Marketing');
INSERT INTO Departments (department_id, department_name)
VALUES (5, 'IT');

/* Locations Table:  
● Establish a mechanism to automatically generate unique identifiers for each 
location, ensuring that they are incremented sequentially.  
● Implement constraints to prevent the insertion of null and duplicate locations.  */
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL UNIQUE
);
INSERT INTO Locations (location_name)
VALUES
('Chennai'),('Bangalore'),('Hyderabad'),('Mumbai');
INSERT INTO Locations (location_name)
VALUES('Pune');

SELECT * FROM Departments;
SELECT * FROM Locations;

/*4. Employees Table:  
●  Guarantee that each employee has a distinct identifier.  
● Create a restriction to ensure that the employee's name is always provided.  
● Limit the acceptable values for the "gender" field to only 'M' or 'F'.  
● Enforce a condition to ensure that the employee's age is 18 or above.  
● Automatically assign the current date to the "hire_date" field if not specified. */

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    gender ENUM('M', 'F'),
    age INT CHECK (age >= 18),
    hire_date DATE DEFAULT (CURRENT_DATE),
    designation VARCHAR(100),
    email VARCHAR(100),
    department_id INT,
    location_id INT,
FOREIGN KEY (department_id)REFERENCES Departments(department_id),
FOREIGN KEY (location_id)REFERENCES Locations(location_id)
);
SHOW TABLES;
INSERT INTO Employees
(employee_id, Employee_name, Gender, Age, hire_date, Designation, email, department_id, location_id)
VALUES
(1, 'Arun', 'M', 28, '2022-06-15', 'Data Analyst', 'arunk@gmail.com', 3, 1),
(2, 'Priya', 'F', 26, '2023-01-10', 'HR Executive', 'priyas@gmail.com', 1, 2),
(3, 'Rahul', 'M', 32, '2021-03-20', 'Finance Analyst', 'rahuls@gmail.com', 2, 3),
(4, 'Divya', 'F', 29, '2022-09-05', 'Sales Executive', 'divyah@gmail.com', 4, 4),
(5, 'Karthik', 'M', 35, DEFAULT, 'Senior Developer', 'karthikk@gmail.com', 3, 5);

ALTER TABLE Employees RENAME COLUMN Hire_date TO Date_of_joining ;
SELECT * FROM Employees;
 