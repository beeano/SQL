-- String Functions
# Built-in functions within SQL that allow us to use and work with strings

SELECT LENGTH('sky');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2 DESC # order by LENGTH
;
# useful in cases where set length is expected like SSN or phone numbers

SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics
;
# useful for standardization

SELECT TRIM('          sky     ');
SELECT LTRIM('          sky     ');
SELECT RTRIM('          sky     ');

SELECT first_name,
UPPER(LEFT(first_name,4)), # start from LEFT and outputs 4 characters
UPPER(RIGHT(first_name,4)), # start from RIGHT and outputs 4 characters
SUBSTRING(first_name,3,2) # start at 3rd position and outputs 2 characters, inclusive of starting character
FROM employee_demographics
;

SELECT *,
SUBSTRING(birth_date,6,2) AS birth_month # start at 3rd position and outputs 2 characters, inclusive of starting character
FROM employee_demographics
;
# birth date has standardized format. Birth month is easily pulled using SUBSTRING

# REPLACE replaces arguement 2 with arguement 3 in the column specified in arguement 1
SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics
;

SELECT LOCATE('f','Tiffany');
# locates the first occurance
SELECT first_name, LOCATE('an',first_name)
FROM employee_demographics
;

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics
;