use course;

-- Hw 2
-- 1
SELECT
	course_id, title
FROM
	course
WHERE
	title LIKE '%System%' OR title LIKE '%Computer%'
ORDER BY
	course_id;
    
-- 2
SELECT
	ID, name
FROM
	instructor
WHERE
	LEFT(name, 1) = 'S'
ORDER BY
	name;
    
-- 3
SELECT
	dept_name, course_id AS course_number
FROM
	course
ORDER BY
	dept_name AND course_number;
    
-- 4
SELECT 
	ID, name, tot_cred
FROM 
	student
WHERE 
	tot_cred BETWEEN 50 AND 90
ORDER BY 
	ID;

-- 5
SELECT
	course_id, dept_name
FROM
	course
WHERE
	course_id >= '300'
ORDER BY
	dept_name AND course_id;
    
-- 6
SELECT DISTINCT
	building
FROM
	section
ORDER BY
	building;
    
-- 7
SELECT DISTINCT 
	ID, course_id
FROM 
	teaches
ORDER BY 
	ID, course_id;
    
-- 8
SELECT
	ID, name, ROUND(salary / 12) AS monthly_salary
FROM
	instructor
ORDER BY 
	monthly_salary desc;

-- 9    
SELECT
	course_id, sec_id, building, room_number
FROM
	section
WHERE
	course_id LIKE '%CS%' AND semester = 'Spring' AND year = 2009
ORDER BY
	course_id AND sec_id;
    
-- 10
SELECT
	ID, course_id, year, semester
FROM
	takes
WHERE
	grade IS NULL
	
ORDER BY
	ID;
