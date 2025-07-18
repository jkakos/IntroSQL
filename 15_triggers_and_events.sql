-- Create a trigger that will insert employee ID, first name, and
-- last name into the employee_demographics table when a new
-- employee is added into the employee_salary table.
DELIMITER $$
CREATE TRIGGER employee_insert
AFTER INSERT ON employee_salary
FOR EACH ROW

BEGIN
    INSERT INTO parks_and_recreation.employee_demographics (
        employee_id -- these are the columns to insert into
        , first_name
        , last_name
    )
    VALUES (
        NEW.employee_id -- these are values to pull from employee_salary
        , NEW.first_name -- NEW represents the new rows added to employee_salary
        , NEW.last_name
    );
END $$
DELIMITER ;

INSERT INTO parks_and_recreation.employee_salary (
    employee_id
    , first_name
    , last_name
    , occupation
    , salary
    , dept_id
)
VALUES (
    13
    , 'Jean-Ralphio'
    , 'Saperstein'
    , 'Entertainment 720 CEO'
    , 1000000
    , NULL
);

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT *
FROM parks_and_recreation.employee_demographics;

-- Create an event that checks employee age. If an employee is over
-- 60 years old, automatically retire them.
DELIMITER $$
CREATE EVENT delete_retirees ON SCHEDULE EVERY 30 SECOND DO
BEGIN
    DELETE
    FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';
