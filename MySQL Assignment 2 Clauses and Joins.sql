USE employee;
SELECT * FROM employees;
ALTER TABLE EMPLOYEES ADD COLUMN SALARY DECIMAL(10,2);
UPDATE  EMPLOYEES SET SALARY= 45000.00 WHERE EMPLOYEE_ID=1;
UPDATE  EMPLOYEES SET SALARY= 38000.00 WHERE EMPLOYEE_ID=2;
UPDATE  EMPLOYEES SET SALARY= 52000.00 WHERE EMPLOYEE_ID=3;
UPDATE  EMPLOYEES SET SALARY= 45000.00 WHERE EMPLOYEE_ID=4;
UPDATE  EMPLOYEES SET SALARY= 62000.00 WHERE EMPLOYEE_ID=5;

/*Tasks 
Clause & Operators: 
1. DISTINCT VALUES:  
● A query to retrieve distinct salaries from the Employees table.*/

SELECT DISTINCT(SALARY) FROM EMPLOYEES; 

/*2. ALIAS (AS):  
● Provide aliases for the "age" and "salary" columns as "Employee_Age" and "Employee_Salary", respectively. */

SELECT AGE AS Employee_Age,
       SALARY AS Employee_Salary
FROM EMPLOYEES;       

/*3. WHERE CLAUSE & OPERATORS:  
	● Retrieve employees with a salary greater than ₹50000 and hired before 2016-01-01.*/
ALTER TABLE Employees RENAME COLUMN Date_of_joining TO Hire_date;  

UPDATE  EMPLOYEES SET Hire_date= '2014-06-15' WHERE EMPLOYEE_ID=5;
UPDATE  EMPLOYEES SET Hire_date= '2013-03-20' WHERE EMPLOYEE_ID=3;

SELECT * FROM Employees WHERE Salary>50000 AND Hire_date < '2016-01-01';

       ##● Find the employee whose designation is missing and fill it with "Data Analyst". 
UPDATE Employees SET designation = NULL WHERE employee_id = 5;

UPDATE Employees SET designation = 'Data Analyst' WHERE designation IS NULL;

/*Sorting and Grouping Data:  
1. ORDER BY:  
● Find employees sorted by department ID in ascending order and salary in 
descending order. */

SELECT * FROM Employees ORDER BY Department_Id ASC,Salary DESC;
##SELECT * FROM Employees ORDER BY  Salary DESC; 

/*2. LIMIT:  
● Display the first 3 employees hired in the year 2018. */
UPDATE  EMPLOYEES SET Hire_date= '2018-06-15' WHERE EMPLOYEE_ID=1;
UPDATE  EMPLOYEES SET Hire_date= '2018-03-20' WHERE EMPLOYEE_ID=2;
UPDATE  EMPLOYEES SET Hire_date= '2018-05-03' WHERE EMPLOYEE_ID=4;

SELECT * FROM employees 
WHERE YEAR(Hire_date)=2018 
ORDER BY employee_id LIMIT 3; 

/*3. AGGREGATE FUNCTIONS:  
● Calculate the sum of all salaries in the Finance department.*/

SELECT * FROM Departments;
SELECT SUM(Salary) AS Total_Finance_Salary
FROM Employees 
JOIN Departments 
    ON Employees.department_id = Departments.department_id
WHERE department_name = 'Finance';

##● Find the minimum age among all employees. 
SELECT MIN(Age) AS Minimum_Age FROM Employees;

/*4. GROUP BY:  
● List the maximum salary for each location. */
SELECT * FROM Locations;
UPDATE Locations SET Location_name= 'Chennai' WHERE Location_ID=3;

SELECT 
Locations.Location_name ,MAX(Employees.Salary) AS Maximum_Salary
FROM Employees
JOIN Locations
ON Employees.location_id=Locations.location_id
GROUP BY Locations.Location_name;


## Calculate the average salary for each designation containing the word 'Analyst'.  
SELECT 
ROUND(AVG(Salary),2) AS Average_Salary ,designation 
FROM Employees 
WHERE designation LIKE "%Analyst"
GROUP BY designation;

/*5. HAVING:  
●  Find departments with less than 3 employees.  */
SELECT department_id, COUNT(*) AS Employee_Count
FROM Employees
GROUP BY department_id
HAVING COUNT(*) < 3;

## Find locations with female employees whose average age is below 30. 
SELECT l.Location_name 
FROM Locations l
JOIN Employees e 
ON e.Location_id=l.Location_id
WHERE e.Gender = 'F'
GROUP BY l.location_name
HAVING  AVG(e.Age) < 30;

/*Joins:  
1. INNER JOIN:  
● List employee names, their designations, and department names where employees are assigned to a department. */
SELECT e.Employee_name,
		e.designation,
        d.department_name 
FROM Employees e 
INNER JOIN Departments d
ON e.department_id=d.department_id;

/*2. LEFT JOIN:  
● List all departments along with the total number of employees in each department, including departments with no employees.*/

INSERT INTO Departments (department_id, department_name)
VALUES (6, 'Operations');
 
SELECT * FROM Departments;

SELECT d.department_name,
	   COUNT(e.employee_id) AS Total_Employees
FROM Departments d 
LEFT JOIN Employees e
ON d.department_id=e.department_id
GROUP BY d.Department_name, d.Department_id;

/*3. RIGHT JOIN:  
● Display all locations along with the names of employees assigned to each location. 
If no employees are assigned to a location, display NULL for employee name.*/
SELECT * FROM Locations;

INSERT INTO Locations(Location_id,Location_name)
VALUES(6,'Salem');

SELECT l.location_name, 
	   e.employee_name
FROM Employees e 
RIGHT JOIN  Locations l
ON e.location_id=l.location_id;

/*4. CROSS JOIN 
●  Show all possible combinations of departments and locations.*/
SELECT
    d.department_name,
    l.location_name
FROM Departments d
CROSS JOIN Locations l;

/*5. SELF JOIN: 
● Show pairs of employees working in the same department, excluding self-pairs.*/
SELECT
    e1.Employee_name AS Employee_1,
    e2.Employee_name AS Employee_2,
	e1.Department_id
FROM Employees e1
JOIN Employees e2
    ON e1.Department_id = e2.Department_id
    AND e1.Employee_id < e2.Employee_id;
    
/*Windows function 
● Write a window function query to rank employees by salary using rank(). */

SELECT Employee_name,Salary,
RANK() OVER(ORDER BY SALARY DESC) AS Employee_rank
FROM employees;

/*● Write a window function query to rank employees by salary within each department 
using DENSE_RANK() */
SELECT
    d.Department_name,
    e.Employee_name,
    e.Salary,
    DENSE_RANK() OVER (PARTITION BY e.Department_id ORDER BY e.Salary DESC) AS Employee_rank
FROM Employees e
JOIN Departments d
    ON e.Department_id = d.Department_id;
    
##3Write a window function query, Running total salary by department
SELECT
    d.Department_name,
    e.Employee_name,
    e.Salary,
    SUM(e.Salary) OVER(PARTITION BY e.Department_id ORDER BY e.Employee_id) AS Running_Total_Salary
FROM Employees e
JOIN Departments d
    ON e.Department_id = d.Department_id;