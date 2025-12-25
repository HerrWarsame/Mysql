-- Case Staements

select first_name,
last_name,
age,
case
	when age<=30 then 'Young'
    when age between 31 and 50 then 'old'
    when age >= 50 then "On death's door"
end AS Age_bracket
from employee_demographics ;


-- Pax increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

select first_name , last_name , salary, 
Case
	when salary <= 50000 then salary*1.05
    when salary > 50000 then salary*1.07
    
end AS New_Salary,
case
	when dept_id = 6 then salary*.10
end AS Bonus
from employee_salary
;








