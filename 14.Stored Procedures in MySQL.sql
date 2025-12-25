-- Stored Procedures

SELECT *
FROM employee_salary
	WHERE salary >= 50000
;

-- Now let's put this into a stored procedure.

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;
-- When you execute this, the stored procedure will be successfully generated in the database.
-- The command does not produce a query result or data output — it only defines the procedure, so no result set is displayed.



-- To execute the stored procedure and run its logic, you can call it using:

CALL large_salaries(); -- or 
call parks_and_recreation.large_salaries();

-- For better control over the stored procedure's structure, it's a standard practice to use a custom delimiter along with BEGIN and END blocks.
-- Let's look at how this is done.
-- The delimiter is normally the character that signals the end of a SQL statement. By default, this is a semicolon (;).
-- We can temporarily change it to something like $$ (or another symbol).
-- Throughout my experience, $$ is widely adopted among SQL developers, so I've adopted it as a common convention.
-- Changing the delimiter allows MySQL to treat the entire procedure definition as a single statement, rather than stopping at the first semicolon inside the procedure body.

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

-- now we change the delimiter back after we use it to make it default again
DELIMITER ;

CALL large_salaries2();  -- as you can see we have 2 outputs which are the 2 queries we had in our stored procedure


CALL new_procedure(); 

-- -------------------------------------------------------------------------
-- we can also add parameters
USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`;
-- it automatically adds the dilimiter for us
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
-- Create a stored procedure named 'large_salaries3' that takes one integer parameter

-- Procedure body starts here
-- Select all columns from the employee_salary table where two conditions are met:
-- 1. Salary is greater than or equal to 60,000
-- 2. The employee_id matches the parameter passed to the procedure
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
    AND employee_id_param = employee_id;
END $$

DELIMITER ;


CALL large_salaries3(1);























