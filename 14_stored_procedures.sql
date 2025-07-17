-- Create a simple stored procedure and then call it
USE parks_and_recreation;
DROP PROCEDURE IF EXISTS large_salaries;

CREATE PROCEDURE large_salaries()
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

CALL large_salaries();

-- Create a stored procedure that contains multiple queries
USE parks_and_recreation;
DROP PROCEDURE IF EXISTS large_salaries2;

DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM parks_and_recreation.employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries2();

-- Pass parameters to the procedure
USE parks_and_recreation;
DROP PROCEDURE IF EXISTS large_salaries3;

DELIMITER $$
CREATE PROCEDURE large_salaries3(p_employee_id INT)
BEGIN
	SELECT employee_id
		, first_name
		, last_name
        , salary
	FROM parks_and_recreation.employee_salary
    WHERE employee_id = p_employee_id;
END $$
DELIMITER ;

CALL large_salaries3(1);