-- UNION
-- By default, UNION is UNION DISTINCT
SELECT first_name
    , last_name
FROM parks_and_recreation.employee_demographics
UNION ALL
SELECT first_name
    , last_name
FROM parks_and_recreation.employee_salary;

SELECT first_name
    , last_name
    , 'old_male' AS Label
FROM parks_and_recreation.employee_demographics
WHERE (
    age > 40
    AND gender = 'male'
)
UNION
SELECT first_name
    , last_name
    , 'old_female' AS Label
FROM parks_and_recreation.employee_demographics
WHERE (
    age > 40
    AND gender = 'female'
)
UNION
SELECT first_name
    , last_name
    , 'highly_paid' AS Label
FROM parks_and_recreation.employee_salary
WHERE salary > 70000
ORDER BY first_name
    , last_name;
