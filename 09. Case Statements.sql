-- Case Statements

SELECT first_name,
last_name,
age,
CASE
	WHEN age < 35 THEN 'young'
    WHEN age BETWEEN 35 and 50 THEN 'mid age' # BETWEEN is inclusive
    WHEN age > 50 THEN 'old'
END AS 'Age Bracket'
FROM parks_and_recreation.employee_demographics
;


--  Exercise: identify bonus or raise and final compensation
-- < $50000 = 5% raise
-- >= 50000 = 7% raise
-- Finance = 10% bonus

### in the example, Alex create new salaries insteading of calulating the raise/bonus amount. I want to create a new column with the new salary
SELECT *
FROM employee_salary
;
SELECT *
FROM parks_departments
;

SELECT first_name, last_name, occupation, department_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 0.05
    WHEN salary >= 50000 THEN salary * 0.07
END AS raise,
CASE
	WHEN department_name = 'Finance' THEN salary * 0.1
END AS bonus 
#, salary + raise + bonus AS total_comp << unknown column 'raise' in 'field list'
FROM parks_and_recreation.employee_salary AS sal
INNER JOIN parks_and_recreation.parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

### My solution to calculate Final Compensation = total_comp
SELECT *,
salary + raise + bonus AS total_comp
FROM
    (SELECT first_name, last_name, occupation, department_name, salary,
	CASE
		WHEN salary < 50000 THEN salary * 0.05
		WHEN salary >= 50000 THEN salary * 0.07
	END AS raise,
	CASE
		WHEN department_name = 'Finance' THEN salary * 0.1
        ELSE 0
	END AS bonus
	FROM parks_and_recreation.employee_salary AS sal
	INNER JOIN parks_and_recreation.parks_departments AS pd
		ON sal.dept_id = pd.department_id
	) AS salary_adj
;
