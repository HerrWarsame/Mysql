-- Triggers and Events
-- Triggers
SELECT * 
FROM employee_salary
;
SELECT * 
FROM employee_demographics
;
DELIMITER $$
-- CREATE TRIGGER: Starts creating a new trigger
-- employee_insert: Name of the trigger
-- AFTER INSERT ON employee_salary: Trigger fires AFTER an INSERT operation on employee_demograhics table
-- FOR EACH ROW: Trigger executes once for each row inserted
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
      -- BEGIN: Start of the trigger body
	  -- INSERT INTO employee_demographics: We're inserting INTO demographics table
		INSERT INTO employee_demographics (
        employee_id,   
        first_name, 
        last_name)
        -- Get values from the NEW row inserted into employee_salary
        VALUE ( 
        NEW.employee_id,  -- From newly inserted salary record
        NEW.first_name,   -- From newly inserted salary record  
        NEW.last_name     -- From newly inserted salary record
        );
END  $$
DELIMITER ;

-- so let's put the values that we want to insert 
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);


-- we check if now if record created
SELECT * 
FROM employee_salary
;
-- and now if effected on this table
SELECT * 
FROM employee_demographics
;

-- -------------------------------------------------------------------------

-- now let's look at Events

SELECT * 
FROM employee_demographics
;
-- MySQL Events are scheduled tasks that automatically execute blocks of SQL code at predefined times. 
-- They serve as a powerful tool for database automation, enabling you to streamline and schedule routine operations without manual intervention.
    -- Importing or synchronizing data on a fixed schedule
    -- Generating and exporting reports automatically
    -- Performing routine maintenance, such as data archiving or cleanup
    -- Aggregating analytics or refreshing summary tables
    
DELIMITER $$
CREATE EVENT delete_OVER_60
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
    DELETE
	FROM employee_demographics
    WHERE age >= 60;
END $$

DELIMITER ; 



















