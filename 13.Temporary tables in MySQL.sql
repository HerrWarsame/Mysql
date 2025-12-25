-- Temporary Tables

-- Temporary Tables in MySQL are tables that exist only for the duration of a database session. 
-- They're useful for storing intermediate results and are automatically dropped when the session ends.
CREATE TEMPORARY TABLE temp_table (
    first_name varchar(50),
	last_name varchar(50),
	favorite_movie varchar(100)
);
-- if we execute this it gets created and we can actualyl query it.
SELECT *
FROM temp_table;
-- notice that if we refresh out tables it isn't there. It isn't an actual table. It's just a table in memory.

-- now i need to insert data into it.

INSERT INTO temp_table
VALUES ('Yasin','Warsame','Raymond Reddington: The Blacklist');

-- now i query temp_table

SELECT *
FROM temp_table;


CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- if we run this query we get our output
SELECT *
FROM salary_over_50k;
-- This is my standard approach when working with temporary tables, particularly for analytical queries involving complex data structures.
-- I find it helpful to organize and stage intermediate results into these temporary containers for later use in the process.
-- Breaking the data into logical sections this way makes it easier to manage and reference throughout the analysis.















