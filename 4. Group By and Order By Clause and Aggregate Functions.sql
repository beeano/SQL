-- GROUP BY Clause
# GROUP BY clause is used to group rows with same values for specified column(s)
# Aggregate function can be run on the grouped rows

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;
# SELECT column and GROUP BY column(s) must match unless using an aggregate function

SELECT occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary
;
# if both office managers made the same salary, there would only be one row for 'office manager'
# unique values will have their own row

-- ORDER BY Clause
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY first_name DESC
;
# default ORDER BY is in ASC order unless specified

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age, gender
;
# gender is not used to order bc there are no repeated age values


SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4 #gender, age
;
# you can shorthand with column position but this is not recommended bc column position can change when addingremoving columns