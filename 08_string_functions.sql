-- LENGTH and CONCAT
SELECT *
    , CONCAT(first_name, ' ', last_name) AS full_name
    , LENGTH(CONCAT(first_name, last_name)) AS name_length
FROM parks_and_recreation.employee_demographics
ORDER BY name_length ASC
    , last_name ASC;
    
-- UPPER and LOWER
SELECT *
    , UPPER(first_name)
    , LOWER(last_name)
FROM parks_and_recreation.employee_demographics;

-- TRIM, LTRIM, and RTRIM
SELECT '    word   ' AS word 
    , TRIM('       word      ') AS trim
    , LTRIM('       word      ') AS ltrim
    , RTRIM('       word      ') AS rtrim;
    
-- LEFT and RIGHT and SUBSTRING
SELECT first_name
    , LEFT(first_name, 4) AS 'left 4' -- select 4 characters from the left
    , RIGHT(first_name, 4) AS 'right 4' -- select 4 characters from the left
    , SUBSTRING(first_name, 2, 3) AS 'substring' -- select the first 3 characters starting from the second character
    , SUBSTRING(birth_date, 6, 2) AS 'birth_month'
FROM parks_and_recreation.employee_demographics;

-- REPLACE
SELECT first_name
    , REPLACE(first_name, 'a', 'z') -- case-sensitive
FROM parks_and_recreation.employee_demographics;

-- LOCATE
SELECT first_name
    , LOCATE('a', first_name) -- not case-sensitive
    , LOCATE('an', first_name)
FROM parks_and_recreation.employee_demographics;
