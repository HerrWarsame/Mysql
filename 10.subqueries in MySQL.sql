-- Subqueries

Select *
from employee_demographics
where employee_id In (  # query in query
					select employee_id
                    from employee_salary
                    where dept_id =1 )
;
#This is a subquery (inner query) that finds employees who work in department 1.
#First, it runs the inner query: Finds all employee_ids from employee_salary where dept_id = 1
#Then, it runs the outer query: Selects all employee details from employee_demographics whose IDs match those found in step 1
#Result: Returns demographic information for all employees in department 1.


select first_name ,salary, 
(select AVG(salary)
from employee_salary)
from employee_salary 
group by  first_name ,salary
;


select gender , AVG(age), max(age),min(age), count(age)
from employee_demographics 
group by gender ;


select gender , AVG(max(age))
from 
(select gender , 
AVG(age) as avg_age,
max(age) as max_age,
min(age) as min_age, 
count(age) as count_age
from employee_demographics 
group by gender ) AS agg_table
;

SELECT 
    gender,
    avg_age,
    max_age
FROM (
    SELECT 
        gender,
        AVG(age) AS avg_age,
        MAX(age) AS max_age,
        MIN(age) AS min_age,
        COUNT(age) AS count_age
    FROM employee_demographics 
    GROUP BY gender
) AS agg_table;
