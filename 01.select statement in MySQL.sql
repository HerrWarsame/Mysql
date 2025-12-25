select *
from parks_and_recreation.employee_demographics;  # ;  means ende of this query 


select first_name , 
last_name ,
birth_date,
age,
age+10
from parks_and_recreation.employee_demographics;  

#PEMDAS is the order of operations in mathematics (Parentheses, Exponents, Multiplication, Division, Addition, Subtraction)!
# stands for Parentheses (), exponent, Multi, Division, add, and sub
 
select distinct gender # this shows only the unieq values from selected section
from parks_and_recreation.employee_demographics; 

#if we select frist_name and gender, the unieq behaiver will not work, such 
select distinct first_name, gender # this shows only the unieq values from selected section





from parks_and_recreation.employee_demographics; 