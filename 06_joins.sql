-- Inner join
SELECT demo.employee_id
    , demo.age
    , salary.occupation
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS salary
    ON demo.employee_id = salary.employee_id;

-- Outer join
SELECT *
FROM parks_and_recreation.employee_demographics AS demo
RIGHT JOIN parks_and_recreation.employee_salary AS salary
    ON demo.employee_id = salary.employee_id;
    
-- Self join
SELECT sal1.employee_id AS id_santa
    , sal1.first_name AS first_name_santa
    , sal1.last_name AS last_name_santa
    , sal2.employee_id AS id_rec
    , sal2.first_name AS first_name_rec
    , sal2.last_name AS last_name_rec
FROM parks_and_recreation.employee_salary AS sal1
JOIN parks_and_recreation.employee_salary as sal2
    ON sal1.employee_id + 1 = sal2.employee_id;
    
-- Joining multiple tables
SELECT *
FROM parks_and_recreation.employee_demographics AS demo
JOIN parks_and_recreation.employee_salary AS salary
    ON demo.employee_id = salary.employee_id
JOIN parks_and_recreation.parks_departments AS pd
    ON salary.dept_id = pd.department_id;
