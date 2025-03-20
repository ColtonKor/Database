use course;

-- homework 3.sql
-- The tables used in this exercise come from 'courses-small.sql';
-- 1. List the Comp. Sci. courses taught in Spring 2009.
-- List the course id, title in order by course_id.
SELECT
	course.course_id, course.title
FROM
	course
    JOIN section USING (course_id)
WHERE semester = 'Spring' AND year = 2009 AND course.course_id LIKE "%CS%";
-- 2. For the spring 2009 semester, show the department name
-- and number of students enrolled in courses from each department
-- Label the number of students as "enrollment".
-- Order the result by department name.
SELECT
	student.dept_name, COUNT(takes.course_id) AS enrollment
FROM
	student JOIN takes ON takes.ID = student.ID
WHERE 
	takes.semester = 'Spring' AND takes.year = 2009
GROUP BY student.dept_name
ORDER BY
	student.dept_name;

-- 3. List all instructors ID , name and department with the number of courses taught with the
-- label "courses_taught". If an instructor did not teach, they are listed with a value of 0.
-- Order by result by ID. A correct result will have 3 instructors with 0 courses.
SELECT
	instructor.ID, instructor.name, instructor.dept_name, COUNT(teaches.ID) AS courses_taught
FROM
	instructor LEFT JOIN teaches ON instructor.ID = teaches.ID
GROUP BY instructor.ID
ORDER BY
	instructor.ID;
-- 4. List the student majors (student.dept_name) and the number of students in each major
-- with the label "count" in order by major.
SELECT
	department.dept_name, COUNT(student.dept_name)
FROM 
	department LEFT JOIN student ON department.dept_name = student.dept_name 
GROUP BY
	department.dept_name
ORDER BY
	department.dept_name;
-- 5. Same as #4 but only list majors with more than 2 students.
SELECT
	department.dept_name, COUNT(student.dept_name)
FROM 
	department LEFT JOIN student ON department.dept_name = student.dept_name 
GROUP BY
	department.dept_name
HAVING
	COUNT(student.dept_name) > 2
ORDER BY
	department.dept_name;

-- 6. List all departments and the number of students majoring in that department (use label "count")
-- and have more than 90 total credits. Order by department name.
-- Answer: 7 department rows. History, Music and Physics departments have 0 students
SELECT
	department.dept_name, COUNT(student.dept_name)
FROM 
	department LEFT JOIN student ON department.dept_name = student.dept_name AND student.tot_cred > '90'
GROUP BY
	department.dept_name
ORDER BY
	department.dept_name;
-- 7. show the instructor id, name, course title and number of times taught.
-- label the output columns id, name, title, count.
-- order the result by id, then title.
-- List all instructor. If an instructor has not taught any courses
-- then list title as null and count as 0.
-- Answer: Gold, Califeri and Singh have not taught courses.
SELECT
	instructor.ID AS id,  instructor.name AS name, teaches.course_id AS title, COUNT(teaches.course_id) AS count
FROM 
	instructor LEFT JOIN teaches ON instructor.ID = teaches.ID
GROUP BY
	instructor.ID, instructor.name, teaches.course_id
ORDER BY
	id, title;
-- 8. List students ID and name with more than 90 credits or have taken more than 2 courses.
-- order the result by ID.
-- Hint: Use UNION operator.
-- Answer: 6 rows
(SELECT student.ID, student.name FROM student WHERE student.tot_cred > 90)
UNION
(SELECT student.ID, student.name 
 FROM student JOIN takes ON student.ID = takes.ID
 GROUP BY student.ID, student.name
 HAVING COUNT(takes.course_id) > 2)
ORDER BY ID;

-- 9. Calculate the GPA for each student.
-- Multiply the sum of numeric value of the grade times the course credits
-- and divide by the sum of course credits for all courses taken.
-- The numeric value of a grade can be found in the grade_points table.
-- The course credit value is in the course table.
-- label the columns id, name, gpa and list the rows by student id
-- Answer: Zhang has a gpa 3.87143, Snow has a null gpa
SELECT 
    student.ID AS id,
    student.name AS name,
    SUM(grade_points.points * course.credits) / SUM(course.credits) AS gpa
FROM 
    student LEFT JOIN takes ON student.ID = takes.ID 
    LEFT JOIN course ON takes.course_id = course.course_id
	LEFT JOIN grade_points ON takes.grade = grade_points.grade
GROUP BY 
    student.ID, student.name
ORDER BY 
    student.ID;

