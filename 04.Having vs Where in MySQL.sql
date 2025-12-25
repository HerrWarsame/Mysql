-- Having vs Where


SELECT gender, AVG (age)
From employee_demographics
WHERE AVG (age) > 40  # will cause error , and will not be an output, 
-- reason we group by gender, when we selecting gender and performing age AVG function
--  this causing actually AVG age after grouping by gender,  and then age > 40 will lead error.
GROUP BY gender ;

Select gender , avg(age)
from employee_demographics
group by gender
Having avg (age) > 40
;

select occupation , avg (salary)
from employee_salary
where occupation like '%manager%' # filtering where class 'manager'
group by occupation
having avg (salary) > 75000  # now filtring  salary morethen 75k
;