-- Temporary Tables
# Temporary Tables are only visible in the session they are created in
# Can be used to store intermediate results for complex queries and to manipulate data before inserting it into a more permanent table


# create blank table and input data
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

INSERT INTO temp_table
VALUES ('Tiffany', 'Zhang', 'Kikujiro')
;
SELECT *
FROM temp_table
;


# create temporary table from existing table
SELECT *
FROM employee_salary
;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary <= 50000
;
SELECT *
FROM salary_over_50k
;