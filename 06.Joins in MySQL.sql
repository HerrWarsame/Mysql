-- Joins

SELECT *
FROM employee_demographics ;

SELECT *
FROM employee_salary;

-- inner Joins 

SELECT *
FROM employee_demographics 
INNER Join employee_salary 
	ON  employee_demographics.employee_id=employee_salary.employee_id
	
;#result employee_id from employee_demograohics we don't have number 2, and join will be mist as well, because join will show only both table what they have same

-- i  use table alias 
SELECT *
FROM employee_demographics AS dem
INNER Join employee_salary  AS sal
	ON  dem.employee_id=sal.employee_id
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER Join employee_salary  AS sal
	ON  dem.employee_id=sal.employee_id
;


-- Outer Joins

SELECT*
FROM employee_demographics AS dem
LEFT Join employee_salary  AS sal
-- Takes all rows from the employee_demographics table (LEFT table), joins matching rows from employee_salary, and fills NULL for salary columns when no match exists.
	ON  dem.employee_id=sal.employee_id
;

SELECT*
FROM employee_demographics AS dem
Right Join employee_salary  AS sal
-- Takes all rows from the employee_salary table (RIGHT table), joins matching rows from employee_demographics, and fills NULL for demographic columns when no match exists.
	ON  dem.employee_id=sal.employee_id
;
-- Self Join 
SELECT *
FROM employee_salary As emp1
Join employee_salary As emp2
	on emp1.employee_id=emp2.employee_id
;


# This query joins the table to itself and pairs each employee with the next employee based on employee_id.
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name As last_name_santa,

emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name As last_name_emp
FROM employee_salary AS emp1
Join employee_salary AS emp2
	ON emp1.employee_id+1=emp2.employee_id   #Pair employee N with employee N+1

-- Joining Multiple tables together 
-- This query joins three tables using INNER JOIN, returning only employees that exist in all three tables with valid relationships.
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id=pd.department_id
;
-- employee_demographics match employee_salary with empployee_id,  and employee_salar match parks_department with department_id

