Select *
from employee_demographics
order by age desc   # this shows the olds employee in the company 
Limit 3 # three olds employees , 
; 
Select *
from employee_demographics
order by age desc   
Limit 2, 1 # we start postion 2 and 1  we show one after 
; 

--  Aliasing 
# Alisaing is changing column name 
 #this change column name as avg_age
Select gender , AVG (age) AS avg_age   #this work with and without AS
From employee_demographics
group by gender 
Having avg_age > 40
;



