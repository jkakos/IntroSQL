-- WHERE
SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie'; -- use single = for comparison

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'; -- YYYY-MM-DD date format;

-- AND
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
	AND NOT gender = 'Male';

-- Grouping logical operators
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (
		first_name = 'Leslie'
        AND age = 44
	)
	OR age > 55;

-- LIKE statement
-- % and _    
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a%'; -- find names with A followed by anything

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a___%'; -- find names with A, followed any three characters, and then anything after

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE '____-03-__'; -- find people born in March
    