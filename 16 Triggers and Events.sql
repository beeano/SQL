-- Triggers and Events
# TRIGGER is a block of code that executes automatically when an event takes place on a specific table


# write a trigger to update data in employee demographics when data in salary is added

SELECT *
from employee_demographics;

SELECT *
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary # use BEFORE for deletion of data
    FOR EACH ROW # TRIGGER is activated for every row added. Batch triggers and Table level triggers only trigger once (not available on MySQL rn)
BEGIN
	INSERT INTO employee_demographics (employee_id,first_name,last_name)
    VALUES (NEW.employee_id, NEW.employee_insertfirst_name, NEW.last_name) # OLD is used for deleted or altered rows
    ;
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Jean Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL)
;


-- EVENTs
# EVENT takes place when it is scheduled. This is a scheduled automater

# Retire employee when they are over 60. Delete their info from the tables

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
	FROM employee_demographics
	WHERE age >= 60
    ;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%'; # event_scheduler needs to be ON
