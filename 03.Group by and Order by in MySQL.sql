-- Group by 

Select *
from employee_demographics

SELECT  gender , AVG(age) ,  # avrage age for each part male and female
 max(age), 
 min(age),
 count(age)
from employee_demographics
group by gender
;


Select occupation, salary
from employee_salary
group by occupation , salary
;


-- ORDER BY  

SELECT *
FROM employee_demographics
ORDER BY first_name  # A to Z  in this case by defult is ASC 
;
SELECT *
FROM employee_demographics
ORDER BY first_name ASC # A to Z  
;
SELECT *
FROM employee_demographics
ORDER BY first_name DESC  #Z to A
;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC
;
# we can use column position as well if we know, but i not recommend , if you woking on a larg database
SELECT *
FROM employee_demographics
ORDER BY 5, 4 DESC
;
























