# SELECT statement is used to work with columns and define which columns to output
# note the ^^ Limit to #### rows. adjust to accomodate rows in table
# * selects all columns
SELECT *
FROM parks_and_recreation.employee_demographics;
# define database.table wen dealing with multiple databases
# ; indicates end of this query

# specific columns can be output
SELECT first_name, last_name, birth_date
FROM parks_and_recreation.employee_demographics;

# inputting column names on different rows is best practice
SELECT first_name, 
last_name, 
birth_date,
age,
age + 10 # you can perform calcuations in the SELECT statement
FROM parks_and_recreation.employee_demographics;
# math in My SQL follows PEMDAS

# outputs entire gender column
SELECT gender
FROM parks_and_recreation.employee_demographics;

# SELECT DISTINCT outputs only unique entries in gender column
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

# All first_name and gender combos are unique so all are output
SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;
