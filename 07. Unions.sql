-- Unions
# UNION is used to combine tables together using rows

# UNION is UNION DISTINCT by default. Only outputs unique values (no repeated values)
# Ron Swanson is not in first table (employee_demographics) so he appears at the end of the UNION DISTINCT table output
SELECT first_name, last_name
FROM Parks_and_Recreation.employee_demographics
UNION
SELECT first_name, last_name
FROM Parks_and_Recreation.employee_salary
;

# UNION ALL includes all values, duplicates are not removed from output
SELECT first_name, last_name
FROM Parks_and_Recreation.employee_demographics
UNION ALL
SELECT first_name, last_name
FROM Parks_and_Recreation.employee_salary
;


SELECT first_name, last_name, "Old Man" AS label
FROM Parks_and_Recreation.employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, "Old Lady" AS label
FROM Parks_and_Recreation.employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS label
FROM Parks_and_Recreation.employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;
# Chris Trager and Leslie Knope are Old and Highly Paid Employees. ORDER BY shows all attributes someone has
# inlcuding WHERE by gender is an unneccesary step but for practice


SELECT *
FROM Parks_and_Recreation.employee_demographics
;
SELECT *
FROM Parks_and_Recreation.employee_salary
;
