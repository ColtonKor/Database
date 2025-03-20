use course;
-- Lab 5
-- use schema from files 'courses-small.sql';
-- 1. Show the names of all students who have taken course "CS-190" as well as the year they took the course.
-- use a join of the student and takes tables. Answer: Shankar and Williams took the course in 2009.
SELECT 
	student.name, takes.year
FROM 
	student
JOIN 
	takes ON student.ID = takes.ID
WHERE 
	takes.course_id = 'CS-190';
-- 2. For every Comp. Sci. course taught, show the instructor's name, the course_id and the course_title.
-- Do not show duplicates. Sort the result by instructor name and then course_id. Join the instructor, teaches and course tables.
-- Answer has 7 rows.
SELECT DISTINCT 
	instructor.name, course.course_id, course.title
FROM 
	instructor
JOIN 
	teaches ON instructor.ID = teaches.ID
JOIN 
	course ON teaches.course_id = course.course_id
WHERE 
	course.course_id LIKE 'CS-%'
ORDER BY 
	instructor.name, course.course_id;
-- 3. Do a natural join on student and takes tables
-- for students in the 'Physics' department.
-- Answer has 4 rows.
SELECT 
	student.*, takes.*
FROM
	student
NATURAL JOIN
	takes
WHERE
	student.dept_name = 'Physics';
	
-- 4. Do a left outer join on student and takes tables
-- for students in the 'Physics' department.
-- Answer has 5 rows.
SELECT
	student.*, takes.*
FROM
	student
LEFT OUTER JOIN 
	takes ON student.ID = takes.ID
WHERE
	student.dept_name = 'Physics';
-- 5. What difference do you observe in the results of #3 compared to #4
-- The difference I observed were the new line where there are null values

-- 6. Return the names of students who have not taken any classes.
-- Hint: use "is null"
-- Answer: One row, name = 'Snow'
SELECT
	name
FROM
	student
LEFT OUTER JOIN 
	takes ON student.ID = takes.ID
WHERE 
	takes.course_id IS NULL;
	
-- 7. Give the course_id for courses that have never been taught.
-- Answer: BIO-399
SELECT
	course.course_id
FROM 
	course
LEFT OUTER JOIN 
	teaches ON course.course_id = teaches.course_id
WHERE
	teaches.course_id IS NULL;
-- 8. Give the student ID, name and the count of number of courses taken.
-- If a student has not taken any course, show the student ID, name and a count of 0.
-- Answer: 13 rows. Student 70557, Snow is listed with a count of 0
SELECT
	student.ID, student.name, COUNT(takes.course_id) as count
FROM
	student
LEFT OUTER JOIN
	takes ON student.ID = takes.ID
GROUP BY 
	student.ID, student.name;
-- 9. List the departments and the number of students
-- for departments with less than 4 students.
-- Answer: Biology, Finance, History and Music have 1 student.
-- Elec. Eng. has 2, and Physics has 3.
SELECT
	department.dept_name, COUNT(student.dept_name) as students
FROM
	department
LEFT OUTER JOIN
	student ON student.dept_name = department.dept_name
GROUP BY
	department.dept_name
HAVING
	COUNT(student.dept_name) < 4
ORDER BY
	students;
	
	