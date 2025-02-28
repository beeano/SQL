-- Window Functions
# WINDOW functions are used similarly to GROUP BY except they do not consolidate groups into one row

# GROUP BY
SELECT gender, AVG(salary) AS avg_salary
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

# WINDOW with OVER
# OVER() keeps all rows
# PARTITION BY() is similar to GROUP BY by defining which column to average by
SELECT gender, AVG(salary) OVER(PARTITION BY gender) AS avg_salary
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

# WINDOW allows you to add additional desired columns without affecting the windowing
# GROUP BY would have required the additional columns to be included in he GROUP BY
SELECT dem.first_name, dem.last_name, gender, 
AVG(salary) OVER(PARTITION BY gender) AS avg_salary
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

# Rolling Total starts at a specific value and adds values from subsequent rows based on PARTITION
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY sal.employee_id) AS Rolling_Total
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

# ROW NUMBER, RANK, and DENSE RANK
# ROW NUMBER does not have dulpicate numbers within the PARTITION BY
# RANK will have duplicate rank when duplicates exist in ORDER BY. Subsequent number will be positional not numerical
# DENSE RANK will have duplicate rank when duplicates exist in ORDER BY. Subsequent number will be numerical not positional
SELECT dem.employee_id,dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM parks_and_recreation.employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;