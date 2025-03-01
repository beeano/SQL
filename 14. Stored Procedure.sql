-- Stored Procedure
# Use to save SQL code for reuse later. Good for storing complex queries and repetitive procedures

USE parks_and_recreation; # optional to specify database
CREATE PROCEDURE small_salaries ()
SELECT *
FROM employee_salary
WHERE salary < 50000
;

CALL large_salaries();

# need a delimiter to include multiple queries within one stored procedure
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000
    ;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000
    ;
END $$
DELIMITER ; # best practice to change back to ; (standard delimiter)

CALL large_salaries2();


# how to pass through a parameter
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT) #create parameter here and provide data type
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = employee_id_param #parameter name can be same as column name but that is confusing. p_employee_id is another standard naming convention
    ;

END $$
DELIMITER ;

CALL large_salaries3(1);
