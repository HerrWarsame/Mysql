-- Unions

Select first_name,last_name
from employee_demographics
union distinct  #unique, doublicates will remove  #UNION is by defult distinct 
Select first_name,last_name
from employee_salary
;

--  if i need to show all , 
Select first_name,last_name
from employee_demographics
union all 
Select first_name,last_name
from employee_salary
;

-- Use case

Select first_name, last_name ,'Old Man'  AS Lable 
from employee_demographics
where age > 40 and gender = 'Male'
union
Select first_name, last_name ,'Old Lady '  AS Lable 
from employee_demographics
where age > 40 and gender = 'Female'
union
Select first_name, last_name ,'Highly Paid Employee'  AS Lable 
from employee_salary
where salary>70000

Order by first_name ,last_name
;




