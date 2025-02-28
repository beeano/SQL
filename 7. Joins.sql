-- Joins
# JOINS are used to combine 2 or more tables if they have a common column. The common column does not have to have the same name, the data within must be similar

# INNER JOIN

SELECT *
FROM Parks_and_Recreation.employee_demographics
;

SELECT *
FROM Parks_and_Recreation.employee_salary
;

# JOIN is INNER JOIN by default
SELECT *
FROM Parks_and_Recreation.employee_demographics
JOIN Parks_and_Recreation.employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;
# since employee_id 2 is not present in employee demographics table, it will not be populated in the final table


# Use asliases to simplify
SELECT *
FROM Parks_and_Recreation.employee_demographics AS dem
JOIN Parks_and_Recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# If column name is repeated in differnt tables, specify table name
SELECT dem.employee_id, age, occupation
FROM Parks_and_Recreation.employee_demographics AS dem
JOIN Parks_and_Recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# OUTER JOIN

# LEFT OUTER JOIN takes everything from LEFT table (including items with no matches) and outputs with matches and null for info that DNE
# RIGHT JOIN takes everything from RIGHT table (including items with no matches) and outputs with matches and null for info that DNE

# LEFT JOIN and RIGHT JOIN are LEFT OUTER JOIN and RIGHT OUTER JOIN
SELECT dem.employee_id, age, occupation
FROM Parks_and_Recreation.employee_demographics AS dem
RIGHT JOIN Parks_and_Recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
# LEFT JOIN
# LEFT table is employee_demographics. Employee_id 2 does not exist in LEFT table. Output does not include Employee_id 2
# RIGHT JOIN
# RIGHT table is employee_salary. Employee_is 2 exists in RIGHT table. Output includes Employee_id 2 with null for contents of the LEFT table bc that information does not exist


# SELF JOIN

SELECT *
FROM parks_and_recreation.employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_recipient,
emp2.first_name AS first_name_recipient,
emp2.last_name AS last_name_recipient
FROM parks_and_recreation.employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;


# Joining >2 tables together
SELECT *
FROM Parks_and_Recreation.employee_demographics AS dem
INNER JOIN Parks_and_Recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments;
# this is called a reference table