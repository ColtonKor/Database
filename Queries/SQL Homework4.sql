use course;


-- SQL homework 4
-- 1. Find the department(s) with the most students.
-- Return department name and the count of students labeled as "students"
-- Your should find that Comp. Sci. has the most students with 4.
SELECT
	department.dept_name, COUNT(student.dept_name) as students
FROM
	department JOIN student USING (dept_name)
GROUP BY
	department.dept_name;
-- 2. Find courses that have not been taken by any student Return the course_id.
-- Hint: use NOT EXISTS or NOT IN predicate.
-- Answer: BIO-399 has not been taken by any students.
SELECT
	course_id
FROM
	course
WHERE course_id NOT IN(
	SELECT course_id
    FROM takes
);
-- 3. Do #2 in another way that uses a join.
SELECT
	course.course_id
FROM
	course LEFT JOIN takes ON takes.course_id = course.course_id
WHERE takes.course_id IS NULL;
-- 4. Find the courses taken by students in the Comp. Sci. department
-- that have more than 90 credits.
-- Return the course_id and title. List each course only once.
-- The answers will be CS-101 and CS-347
SELECT DISTINCT
	course.course_id, course.title
FROM
	course JOIN takes ON course.course_id = takes.course_id
    JOIN student ON takes.ID = student.id
WHERE
	student.tot_cred > 90 AND student.dept_name = 'Comp. Sci.';
-- 5. Find students who passed a 4 credit course (course.credits=4)
-- A passing grade is A+, A, A-, B+, B, B-, C+, C, C-.
-- Return student ID and name ordered by student name.
-- The answer will have 8 students.
SELECT DISTINCT
	student.ID, student.name
FROM
	student JOIN takes ON student.ID = takes.ID
    JOIN course ON course.course_id = takes.course_id
WHERE
	takes.grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-')
    AND course.credits = 4
ORDER BY
	student.name;
-- 6. Find the course(s) taken by the most students. Return columns
-- course_id, title, enrollment (the count of students that have taken the course)
-- The answer is CS-101 with an enrollment of 7
SELECT
	course.course_id, course.title, COUNT(takes.course_id) AS enrollment
FROM
	course JOIN takes ON course.course_id = takes.course_id
GROUP BY
	course.course_id, course.title
HAVING COUNT(takes.ID) = (
    SELECT 
		MAX(eCount)
    FROM (
        SELECT COUNT(t2.ID) AS eCount
        FROM takes t2
        GROUP BY t2.course_id
    ) AS eMAx
);
-- 7. create a view named "vcourse" showing columns course_id, title, credits, enrollment
-- If no students have taken the course, the enrollment should be 0.
CREATE VIEW vcourse AS
SELECT 
    c.course_id, 
    c.title, 
    c.credits, 
    COUNT(t.ID) AS enrollment
FROM 
    course c LEFT JOIN section s ON c.course_id = s.course_id
	LEFT JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id 
		AND s.semester = t.semester AND s.year = t.year
GROUP BY 
    c.course_id, 
    c.title, 
    c.credits;

-- 8. List all the rows in the view "vcourse" and verify that
-- the enrollment in BIO-399 is 0.
SELECT
	*
FROM
	vcourse;
-- 9. Use the view to display the course(s) with highest enrollment.
-- Return course_id, title, enrollment
-- Answer is same as #6.
SELECT
	vcourse.course_id, vcourse.title, COUNT(takes.course_id) AS enrollment
FROM
	vcourse JOIN takes ON vcourse.course_id = takes.course_id
GROUP BY
	vcourse.course_id, vcourse.title
HAVING COUNT(takes.ID) = (
    SELECT 
		MAX(eCount)
    FROM (
        SELECT COUNT(t2.ID) AS eCount
        FROM takes t2
        GROUP BY t2.course_id
    ) AS eMAx
);
-- 10. List the instructor(s) (ID, name) in order by ID who advise the most students
-- Answer: Einstein, Katz and Kim advise the most students.
SELECT
	instructor.ID, instructor.name
FROM
	instructor JOIN advisor ON instructor.ID = advisor.i_ID
GROUP BY 
	instructor.ID, instructor.name
ORDER BY 
	COUNT(advisor.s_ID) DESC;

-- 11. List the course_id and title for courses that are offered both in Fall 2009 and in Spring 2010.
-- A correct answers shows that CS-101 is the only course offered both semesters.

SELECT 
	course.course_id, course.title
FROM 
	course JOIN teaches t1 ON course.course_id = t1.course_id
	JOIN teaches t2 ON course.course_id = t2.course_id
WHERE t1.semester = 'Fall' AND t1.year = 2009
  AND t2.semester = 'Spring' AND t2.year = 2010;
