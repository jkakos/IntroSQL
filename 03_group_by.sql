-- GROUP BY
-- Group results by gender
SELECT gender
    , AVG(age)
    , 2023 - AVG(YEAR(birth_date)) AS 'Manual AVG(age)'
    , MIN(age)
    , MAX(age)
    , COUNT(age) AS num_employees
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

-- ORDER BY
-- Order by different columns sequentials, either ascending
-- or descending
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender ASC
    , age DESC;
