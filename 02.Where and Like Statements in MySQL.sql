-- Where Clause--

SELECT*
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT*
FROM employee_salary
WHERE salary <= 50000
;

SELECT*
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT*
FROM employee_demographics
WHERE gender = 'Female'
;

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;


--  Logical Operators  AND OR NOT---

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'   			 # both conditions should happen
;

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male' 				 # one of the contions should at least happen

;

SELECT*
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male' 				 # one of the contions should at least happen
;


SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age =44) OR age > 55
;

				-- % and _ Like Statement 
SELECT *
FROM employee_demographics
WHERE first_name like '%er%'
;

SELECT *
FROM employee_demographics
WHERE first_name like 'a%'
;
SELECT *
FROM employee_demographics
WHERE first_name like 'a__'   #starts with a and after a comes two charchters only 
;



SELECT *
FROM employee_demographics
WHERE first_name like 'a___%'   #starts with a and after a comes three charchters and after can anythink come
;
SELECT *
FROM employee_demographics
WHERE birth_date like '1989%'   #starts with a and after a comes two charchters only 
;





























































