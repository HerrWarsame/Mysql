
-- windows function


  #Returns one row per unique combination of (first_name, last_name, gender).

    #The AVG(salary) is calculated across all rows in each group, but since each group only contains one person's salary(es), it just shows that person's average salary (if they have multiple salary entries).

    #If a person appears multiple times in employee_salary, it averages their salaries.

    #Row count: Equal to number of distinct (first_name, last_name, gender) combinations.
    
select dem.first_name , dem.last_name , gender , avg(salary)  As avg_salary
from employee_demographics As dem
join employee_salary As sal
		on dem.employee_id =sal.employee_id
group by dem.first_name , dem.last_name , gender
;


   #Returns all rows from the join.

   # AVG(salary) OVER(PARTITION BY gender) calculates the average salary for each gender, but adds this same average to every row belonging to that gender.

   # Each row shows individual employee details PLUS the overall average salary for their gender.

   # Row count: Equal to number of rows in the join result (all employee-salary combinations).

  #  No GROUP BY, so all original rows are preserved.
select dem.first_name , dem.last_name , avg(salary)  over(partition by gender ) # window function
from employee_demographics As dem
join employee_salary As sal
		on dem.employee_id =sal.employee_id

;

select dem.first_name , dem.last_name , gender, salary,
sum(salary)  over(partition by gender order by dem.employee_id )  as rolling_total  
from employee_demographics As dem
join employee_salary As sal
		on dem.employee_id =sal.employee_id
;
 #The rolling_total column creates a running total (cumulative sum) of salaries within each gender group, ordered by employee_id.
 
 
-- This query ranks employees within each gender group by salary (highest to lowest)
-- using two different ranking methods: ROW_NUMBER and RANK

SELECT 
    dem.employee_id, 
    dem.first_name, 
    dem.last_name, 
    gender, 
    salary,
    
    -- ROW_NUMBER: Assigns unique sequential numbers (1,2,3...) within each gender group
    -- If salaries are tied, arbitrary order is used (no duplicates in row numbers)
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num, 
    
    -- RANK: Assigns ranks with gaps for ties
    -- Employees with same salary get same rank, next rank skips numbers (e.g., 1,1,3,4...)
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num, 
	dense_rank() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
    
FROM employee_demographics AS dem
JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
-- No GROUP BY - returns all rows with ranking columns added
-- ORDER BY can be added at end to sort final results if needed
;
 





