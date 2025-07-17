-- CASE
SELECT first_name
    , last_name
    , age
    , CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 34 AND 61 THEN 'Old'
        WHEN age > 60 THEN 'Omega old'
        WHEN age > 0 THEN 'alive'
    END AS 'age_bracket'
FROM parks_and_recreation.employee_demographics;

-- Pay increase and bonus
-- < 50000 -> 5%
-- >= 50000 -> 7%
-- Finance -> 10% bonus
WITH temp AS (
	SELECT *
		, CASE
			WHEN salary < 50000
				THEN salary * 1.05
			WHEN salary >= 50000
				THEN salary * 1.07
		  END AS 'new_salary'
		, CASE
			WHEN department_name = 'Finance'
				THEN salary * 0.1
				ELSE 0
		  END AS 'bonus'
	FROM parks_and_recreation.employee_salary AS sal
	JOIN parks_and_recreation.parks_departments AS depts
		ON sal.dept_id = depts.department_id
)
SELECT *
	, (new_salary - salary) + bonus AS 'total_pay_increase'
FROM temp
ORDER BY total_pay_increase DESC;
