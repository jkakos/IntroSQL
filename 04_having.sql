-- HAVING
-- This example doesn't work because AVG(age) aggregate function isn't calculated
-- until after the GROUP BY statement performs the grouping. However, the WHERE
-- clause is trying to filter by AVG(age) before the GROUP BY statement executes,
-- but AVG(age) does not yet exist.
-- 		SELECT gender, AVG(age)
-- 		FROM parks_and_recreation.employee_demographics
-- 		WHERE AVG(age) > 40
-- 		GROUP BY gender;
-- Instead, we need to use HAVING in place of WHERE. The HAVING clause is executed
-- after the grouping has taken place.

-- Select gender groups where the average age of the gender is greater than 40
SELECT gender
    , AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- Select gender groups and show the average age for people older than 40
SELECT gender
    , AVG(age)
FROM parks_and_recreation.employee_demographics
WHERE age > 40
GROUP BY gender;

-- Select occupations and average salaries for manager positions, then group
-- by occupation and select only those that make at least $50,000 per year.
SELECT occupation
    , AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 50000;
