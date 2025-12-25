-- String Functions
SELECT length('Skyfall');

SELECT  first_name, length (first_name)
From employee_demographics
order by 2;

SELECT UPPER ('sky');
SELECT LOWER ('SKY');

SELECT first_name, UPPER (first_name)
FROM employee_demographics;
# Trim fixes the space 
SELECT trim('		sky		');
SELECT ltrim('		sky		');  # fixes only left handside
SELECT rtrim('		sky		');  # fixes only right handside

SELECT first_name, 
left(first_name,4), #select only first 4 character from left 
right(first_name,4), #select only last 4 character from right 
substring(first_name,3,2),  #3rd the position, and i go 2 characters
birth_date,
substring(birth_date,6,2) AS birth_month
FROM employee_demographics;  

-- replace
SELECT first_name , REPLACE (first_name, 'a' ,'z')  # in first name, every lowercase a, replace a lowercase z
FROM employee_demographics; 

-- Locate
SELECT LOCATE ('s','Warsame')  AS Postion ;  # looking for the letter x, will tall  me which postion is it.alter

-- concat
Select first_name, last_name, 
concat(first_name, ' ' ,last_name ) AS Full_name
From employee_demographics
;
