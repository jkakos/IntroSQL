-- Group by gender and then take the average salary for each of
-- the two groups.
SELECT gender
    , AVG(salary) AS avg_salary
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS sal
    ON demo.employee_id = sal.employee_id
GROUP BY gender;

-- Partition by gender and calculate the average salary for
-- each group on each row.
SELECT demo.first_name
    , demo.last_name
    , gender
    , AVG(salary) OVER(PARTITION BY gender) AS avg_salary_gender
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS sal
    ON demo.employee_id = sal.employee_id;

-- Calculate cumulative salary for each partition.
SELECT demo.employee_id
    , demo.first_name
    , demo.last_name
    , gender
    , salary
    , SUM(salary) OVER(PARTITION BY gender ORDER BY demo.employee_id) AS cumulative_salary_gender
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS sal
    ON demo.employee_id = sal.employee_id;
    
-- Use the ordered ROW_NUMBER() after partitioning by gender to list the
-- ranks of each employee's salary for their gender. Alternatively, use
-- RANK() to calculate a proper rank which handles ties. When a tie
-- occurs, RANK() will use the next number positionally. Using DENSE_RANK()
-- allows you to use the next rank numerically instead.
--
-- For example, Tom, Jerry, and Andy are 5th, 6th, and 7th in row number
-- for males. However, since Tom and Jerry have equal salary, they both
-- rank as 5th. Since there are six salaries higher than Andy's, he gets
-- rank 7 still. If we use DENSE_RANK(), then Andy gets rank 6 because
-- his salary value is the 6th highest among the males.
SELECT demo.employee_id
    , demo.first_name
    , demo.last_name
    , gender
    , salary
    , ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
    , RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
    , DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS sal
    ON demo.employee_id = sal.employee_id;
