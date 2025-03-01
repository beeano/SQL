-- HAVING vs WHERE

# invalid use of GROUP BY function
SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
WHERE AVG(age) > 40 # GROUP BY not applied yet, so the aggregate function applied to age column does not exist yet
GROUP BY gender
;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;

# must use HAVING Caluse when filtering on aggregate functions
# WHERE Clause is more common but cannot be used in these instances ^
