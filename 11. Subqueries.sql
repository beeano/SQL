-- Subqueries

# Subqueries in WHERE clause can be an alternative to JOIN
SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id # Operand can only contain one column
					FROM employee_salary
                    WHERE dept_id = 1)
;


# Subqueries can be nested
# This example uses additonal subquery to specify dept_id in Salary table should correspond with the 'Finance' deptartment_id
# This is useful to prevent tables from containing unupdated info
SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id # Operand can only contain one column
					FROM employee_salary
                    WHERE dept_id IN
								(SELECT department_id
									FROM parks_departments
                                    WHERE department_name = 'Finance')
                    )
;

# Subqueries in SELECT statement
SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary) AS avg_salary
FROM employee_salary
;

SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary
;
# this provides the avg of salary for each row individually. Not what we want

# Subqueries using FROM statement

# typical GROUP BY
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

# same output as typical GROUP BY with output table named 'ag_table'
SELECT *
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS ag_table
;

## AVG(MAX(age)) is an aggregate function AVG on the previously calculated column MAX age. Use back ticks ` (not single quotation) to call this column
SELECT AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS ag_table
;
## or rename the aggregate function columns so aggregate func name is not used
SELECT AVG(max_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age, 
COUNT(age) AS count
FROM employee_demographics
GROUP BY gender) AS ag_table
;