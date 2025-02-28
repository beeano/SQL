-- CTE Common Table Expression
# CTEs are used to define a subquery block so they can be referenced in the main query
# can only use CTE immediately after it is created within the same query. It is not a stored table
# easier readibility than subquery but same functionality

WITH CTE_Example AS
(
SELECT gender, 
AVG(salary) AS avg_sal,
MAX(salary) AS max_sal, 
MIN(salary) AS min_sal, 
COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal) #avg of Female and Male AVG. This is different than the overall AVG
FROM CTE_Example
;

# another way to rename columns besides Aliases
# column names at top override alias column names within
WITH CTE_Example (gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal)AS
(
SELECT gender, 
AVG(salary) AS avg_sal,
MAX(salary) AS max_sal, 
MIN(salary) AS min_sal, 
COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example
;


# Subquery version
SELECT AVG(avg_sal)
FROM (
SELECT gender, 
AVG(salary) AS avg_sal,
MAX(salary) AS max_sal, 
MIN(salary) AS min_sal, 
COUNT(salary) AS count_sal
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) AS Subquery_Example
;


# Can create multiple CTEs within same query
WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;