-- Limit

SELECT *
FROM Parks_and_Recreation.employee_demographics
LIMIT 3
;

SELECT *
FROM Parks_and_Recreation.employee_demographics
ORDER BY age DESC
LIMIT 3
;

SELECT *
FROM Parks_and_Recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1 # start at row 2 (exclusive) and output 1 row after
;

-- Aliasing

SELECT gender, AVG (age)
FROM Parks_and_Recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

# you can rename aggregate function column
SELECT gender, AVG (age) AS avg_age
FROM Parks_and_Recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40
;

# AS is not required for aliasing. It is implied
SELECT gender, AVG (age) avg_age
FROM Parks_and_Recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40
;
