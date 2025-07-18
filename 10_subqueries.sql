-- Subquery employee_id for employees who have dept_id = 1. Then select
-- everything from employee_demographics for employees who have employee_id
-- in the subquery column of IDs.
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE employee_id IN (
    SELECT employee_id
    FROM parks_and_recreation.employee_salary
    WHERE dept_id = 1
);

-- Subquery salary for all employees and calculate the average as a
-- new column in employee_salary.
SELECT *
    , (SELECT AVG(salary)
        FROM parks_and_recreation.employee_salary
    ) AS avg_salary
FROM parks_and_recreation.employee_salary;

-- Subquery aggregate age information and operate on the aggregated
-- table. In this case, select the average of the maximum ages for
-- males and females.
SELECT AVG(max_age)
FROM (SELECT gender
        , AVG(age) AS avg_age
        , MIN(age) AS min_age
        , MAX(age) AS max_age
        , COUNT(age) AS num_age
    FROM parks_and_recreation.employee_demographics
    GROUP BY gender
) AS agg_table;
