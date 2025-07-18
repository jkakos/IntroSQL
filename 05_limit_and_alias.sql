-- LIMIT
-- Select only the first 3 entries
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3;

-- Skip 4 entries and select the next 2
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 4, 2;

-- Rename columns using an alias
SELECT gender
    , AVG(age) AS avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40;
