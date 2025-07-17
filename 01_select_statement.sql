-- SELECT
-- Select everything from employee_demographics
SELECT *
FROM parks_and_recreation.employee_demographics;

-- Select a subset of columns from employee_demographics
SELECT first_name
    , last_name
    , birth_date
    , age
    , age + 10
FROM parks_and_recreation.employee_demographics;

-- Select only unique pairings of first names and gender
SELECT DISTINCT first_name
    , gender
FROM parks_and_recreation.employee_demographics;