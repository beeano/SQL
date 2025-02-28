# WHERE clause is used to filter records (rows of data). SELECT statement filters the columns output

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie'
;

 -- Comparison operators are =, >=, <=, >, <
# <> and != are both not equal to
SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary < 50000
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators
# AND both statements need to be true to be output
# OR results of both statements will be output
# OR NOT first statement is true or second statement is false
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01' 
OR NOT gender = 'Male'
;

# (PEMDAS) applies to logical operators
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

-- LIKE Statement
# er% any character after 'Je'
# %er any character before 'Je'
# number of _ used defines number of any characters

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a___'
;
