-- You can add aliases to the beginning of a CTE which will override
-- any aliases set in the SELECT statement.
WITH cte (Gender, Avg_salary, Min_salary, Max_salary, Num_salary) AS (
	SELECT gender
		, AVG(salary) AS avg_salary
        , MIN(salary) AS min_salary
        , MAX(salary) AS max_salary
        , COUNT(salary) AS num_salary
	FROM parks_and_recreation.employee_demographics AS demo
	JOIN parks_and_recreation.employee_salary AS sal
		ON demo.employee_id = sal.employee_id
	GROUP BY gender
)
SELECT *
FROM cte;

-- Joining multiple CTEs
WITH cte AS (
	SELECT employee_id
		, gender
		, birth_date
	FROM parks_and_recreation.employee_demographics
	WHERE birth_date > '1985-01-01'
)
, cte2 AS (
	SELECT employee_id
		, salary
	FROM parks_and_recreation.employee_salary
	WHERE salary > 50000
)
SELECT *
FROM cte
JOIN cte2
	ON cte.employee_id = cte2.employee_id;