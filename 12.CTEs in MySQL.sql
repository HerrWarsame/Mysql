-- CTEs  Common Table Expression


WITH CTE_EXAMPLE AS 
(
    SELECT 
        gender, 
        AVG(salary) AS avg_salary,  
        MAX(salary) AS max_salary, 
        MIN(salary) AS min_salary, 
        COUNT(salary) AS salary_count
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender 
)
SELECT AVG(avg_salary) AS overall_average_salary
FROM CTE_EXAMPLE;


SELECT AVG(avg_salary)
   FROM ( SELECT 
        gender, 
        AVG(salary) AS avg_salary,  
        MAX(salary) AS max_salary, 
        MIN(salary) AS min_salary, 
        COUNT(salary) AS salary_count
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender 
) EXAMPLE_SUBQUERY
;


-- Subquery (Nested, harder to read):
SELECT AVG(gender_avg)
FROM (
    SELECT 
        gender, 
        AVG(salary) AS gender_avg
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
) AS subquery_alias;


-- CTE (Separated, more readable):
WITH GenderAverages AS (
    SELECT 
        gender, 
        AVG(salary) AS gender_avg
    FROM employee_demographics AS dem
    JOIN employee_salary AS sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)
SELECT AVG(gender_avg)
FROM GenderAverages;    #CTEs must be used immediately after their definition in the same query. They don't persist beyond the current statement.





WITH CTE_EXAMPLE AS 
(
    SELECT  
    employee_id, gender, birth_date
	FROM employee_demographics 
    WHERE birth_date > '1985-01-01'
), 
CTE_EXAMPLE2 AS
(
  SELECT  
    employee_id, salary
	FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM CTE_EXAMPLE
JOIN CTE_EXAMPLE2
	ON CTE_EXAMPLE.employee_id=CTE_EXAMPLE2.employee_id
;
-- REAL-WORLD USE CASE BUILDING
WITH YoungEmployees AS (  #FIRST CTE
    SELECT  
        employee_id, 
        gender, 
        birth_date,
        YEAR(birth_date) AS birth_year -- Extracts year from date
    FROM employee_demographics 
    WHERE birth_date > '1985-01-01' -- Born after Jan 1, 1985
), 
HighEarners AS (  #SECOND CTE 
    SELECT  
        employee_id, 
        salary,
        CASE 
            WHEN salary > 80000 THEN 'A'
            WHEN salary > 60000 THEN 'B'
            ELSE 'C'
        END AS salary_grade   -- Creates salary categories
    FROM employee_salary
    WHERE salary > 50000 -- Only employees earning > 50k
),
EmployeeAnalysis AS (  #THIRD CTE
    SELECT 
        ye.employee_id,
        ye.gender,
        ye.birth_year,
        he.salary,
        he.salary_grade,
        ROUND(he.salary / 1000, 0) * 1000 AS salary_rounded  -- ROUND(number, decimal_places)
         -- Rounds salary to nearest $1000
        -- 55,500 → 56,000
        -- 62,300 → 62,000
    FROM YoungEmployees ye
    JOIN HighEarners he
        ON ye.employee_id = he.employee_id
        -- INNER JOIN: Only employees in BOTH CTEs
        --     Born after 1985 (from YoungEmployees) AND
		--     Earning > $50k (from HighEarners)
)
-- Final aggregated report
SELECT 
    gender,
    salary_grade,
    COUNT(*) AS employee_count,  --  -- How many in each group
    AVG(salary) AS avg_salary,   -- -- Average salary per group
    MIN(birth_year) AS youngest_birth_year, -- Oldest in group
    MAX(birth_year) AS oldest_birth_year  -- Youngest in group
FROM EmployeeAnalysis
GROUP BY gender, salary_grade   -- Groups by both gender AND salary grade
ORDER BY gender, salary_grade;




