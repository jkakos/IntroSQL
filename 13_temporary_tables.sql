-- Create a temporary table and add values to it
CREATE TEMPORARY TABLE temp (
    first_name varchar(50)
    , last_name varchar(50)
    , favorite_movie varchar(100)
);

INSERT INTO temp
VALUES('First', 'Last', 'Lord of the Rings: The Two Towers');

SELECT *
FROM temp;

-- Create a temporary table using values from an existing table
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;
