use course;
-- Homework 1
-- 1
SELECT
 	name, salary
FROM 
 	instructor
ORDER BY
 	name;

-- 2
SELECT
 	ID, name, dept_name, salary
FROM 
 	instructor
WHERE
 	dept_name = 'Comp. Sci.'
ORDER BY
 	name;
     
-- 3
SELECT
 	name, salary, dept_name
FROM
 	instructor
WHERE
 	salary < 50000
ORDER BY
 	name;
     
-- 4
SELECT
 	name, dept_name, tot_cred
FROM
 	student
WHERE
 	tot_cred >= 98
ORDER BY
 	tot_cred;     

-- -- 5
SELECT
 	ID, name
FROM
 	student
WHERE
	(dept_name = 'Elec. Eng.' OR dept_name = 'Comp. Sci.') AND tot_cred >= 90
ORDER BY
 	ID;
     
-- 6
SELECT
 	*
FROM 
 	student
ORDER BY
 	name;
     
-- 7
SELECT
 	ID, name, salary
FROM 
 	instructor
ORDER BY
 	salary desc;
     
-- 8
SELECT DISTINCT
	dept_name AS major
FROM
 	student
ORDER BY
 	dept_name;
