drop database if exists course; 
create database course;
use course;

create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		    numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 constraint course1 foreign key (dept_name) references department(dept_name)
		on delete set null
	);

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 constraint instructor1 foreign key (dept_name) references department(dept_name)
		on delete set null
	);

create table section
	(course_id		varchar(8), 
	 sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year),
	 constraint section1 foreign key (course_id) references course(course_id)
		on delete cascade,
	 constraint section2 foreign key (building, room_number) 
        references classroom(building, room_number)
		on delete set null
	);

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 constraint teaches1 foreign key (course_id,sec_id, semester, year) 
        references section(course_id, sec_id, semester, year)
		on delete cascade,
	 constraint teaches2 foreign key (ID) references instructor(ID)
		on delete cascade
	);

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 constraint student1 foreign key (dept_name) references department(dept_name)
		on delete set null
	);

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 constraint takes1 foreign key (course_id,sec_id, semester, year) 
        references section(course_id, sec_id, semester, year)
		on delete cascade,
	 constraint takes2 foreign key (ID) references student(id)
		on delete cascade
	);

create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5),
	 primary key (s_ID),
	 constraint advisor1 foreign key (i_ID) references instructor(ID)
		on delete set null,
	 constraint advisor2  foreign key (s_ID) references student(ID)
		on delete cascade
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);
    
create table time_slot_f (
  time_slot_id char(4) primary key, 
  day_time varchar(25));

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 constraint prereq1 foreign key (course_id) references course(course_id)
		on delete cascade,
	 constraint prereq2 foreign key (prereq_id) references course(course_id)
	);
  
create table grade_points (
   grade   varchar(2) primary key,
   points  numeric(2, 1)
);

create table semester(
   sequence int not null, 
   semester varchar(10) not null,
   year  int not null);

insert into semester values
 (1, 'Spring', 2001),
 (2, 'Fall',   2001), 
 (3, 'Spring', 2002),
 (4, 'Fall',   2002), 
 (5, 'Spring', 2003),
 (6, 'Fall',   2003), 
 (7, 'Spring', 2004),
 (8, 'Fall',   2004),
 (9, 'Spring', 2005),
 (10,'Fall',   2005), 
 (11,'Spring', 2006),
 (12,'Fall',   2006),  
 (13,'Spring', 2007),
 (14,'Fall',   2007), 
 (15,'Spring', 2008),
 (16,'Fall',   2008), 
 (17,'Spring', 2009),
 (18,'Fall',   2009), 
 (19,'Spring', 2010),
 (20,'Fall',   2010);

insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');
insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');
insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');
insert into section values ('BIO-101', '1', 'Summer', '2009', 'Painter', '514', 'B');
insert into section values ('BIO-301', '1', 'Summer', '2010', 'Painter', '514', 'A');
insert into section values ('CS-101', '1', 'Fall', '2009', 'Packard', '101', 'H');
insert into section values ('CS-101', '1', 'Spring', '2010', 'Packard', '101', 'F');
insert into section values ('CS-190', '1', 'Spring', '2009', 'Taylor', '3128', 'E');
insert into section values ('CS-190', '2', 'Spring', '2009', 'Taylor', '3128', 'A');
insert into section values ('CS-315', '1', 'Spring', '2010', 'Watson', '120', 'D');
insert into section values ('CS-319', '1', 'Spring', '2010', 'Watson', '100', 'B');
insert into section values ('CS-319', '2', 'Spring', '2010', 'Taylor', '3128', 'C');
insert into section values ('CS-347', '1', 'Fall', '2009', 'Taylor', '3128', 'A');
insert into section values ('EE-181', '1', 'Spring', '2009', 'Taylor', '3128', 'C');
insert into section values ('FIN-201', '1', 'Spring', '2010', 'Packard', '101', 'B');
insert into section values ('HIS-351', '1', 'Spring', '2010', 'Painter', '514', 'C');
insert into section values ('MU-199', '1', 'Spring', '2010', 'Packard', '101', 'D');
insert into section values ('PHY-101', '1', 'Fall', '2009', 'Watson', '100', 'A');
insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2009');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2010');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2009');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2010');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2010');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2009');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2010');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2010');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2010');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2009');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2010');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2009');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2009');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2010');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2009');
insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');
insert into takes values ('00128', 'CS-101', '1', 'Fall', '2009', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2009', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2009', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2009', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2010', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2009', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2010', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2010', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2009', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2009', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2010', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2010', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2009', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2009', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2010', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2009', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2010', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2009', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2009', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2010', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2009', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2010', null);
insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');
insert into time_slot values ('A', 'M', '8', '0', '8', '50');
insert into time_slot values ('A', 'W', '8', '0', '8', '50');
insert into time_slot values ('A', 'F', '8', '0', '8', '50');
insert into time_slot values ('B', 'M', '9', '0', '9', '50');
insert into time_slot values ('B', 'W', '9', '0', '9', '50');
insert into time_slot values ('B', 'F', '9', '0', '9', '50');
insert into time_slot values ('C', 'M', '11', '0', '11', '50');
insert into time_slot values ('C', 'W', '11', '0', '11', '50');
insert into time_slot values ('C', 'F', '11', '0', '11', '50');
insert into time_slot values ('D', 'M', '13', '0', '13', '50');
insert into time_slot values ('D', 'W', '13', '0', '13', '50');
insert into time_slot values ('D', 'F', '13', '0', '13', '50');
insert into time_slot values ('E', 'T', '10', '30', '11', '45 ');
insert into time_slot values ('E', 'R', '10', '30', '11', '45 ');
insert into time_slot values ('F', 'T', '14', '30', '15', '45 ');
insert into time_slot values ('F', 'R', '14', '30', '15', '45 ');
insert into time_slot values ('G', 'M', '16', '0', '16', '50');
insert into time_slot values ('G', 'W', '16', '0', '16', '50');
insert into time_slot values ('G', 'F', '16', '0', '16', '50');
insert into time_slot values ('H', 'W', '10', '0', '12', '30');
insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');

insert into grade_points values ('A+', 4.2);
insert into grade_points values ('A', 4.0);
insert into grade_points values ('A-', 3.7);
insert into grade_points values ('B+', 3.3);
insert into grade_points values ('B', 3.0);
insert into grade_points values ('B-', 2.7);
insert into grade_points values ('C+', 2.3);
insert into grade_points values ('C', 2.0);
insert into grade_points values ('C-', 1.7);
insert into grade_points values ('F', 0.0);

insert into time_slot_f values 
('A', 'MWF 8:00am - 8:50am'),
('B', 'MWF 9:00am - 9:50am'),
('C', 'MWF 11:00am - 11:50am'),
('D', 'MWF 1:00pm - 13:50pm'),
('E', 'TR 10:30am - 11:45pm'),
('F', 'TR 2:30pm - 3:45pm'),
('G', 'MWF 4:00pm - 4:50pm'),
('H', 'W 10:00am - 12:30pm');

    
    
-- Homework 1
-- 1
-- SELECT
-- 	name, salary
-- FROM 
-- 	instructor
-- ORDER BY
-- 	name;
--     
-- -- 2
-- SELECT
-- 	ID, name, dept_name, salary
-- FROM 
-- 	instructor
-- WHERE
-- 	dept_name = 'Comp. Sci.'
-- ORDER BY
-- 	name;
--     
-- -- 3
-- SELECT
-- 	name, salary, dept_name
-- FROM
-- 	instructor
-- WHERE
-- 	salary < '50000'
-- ORDER BY
-- 	name;
--     
-- -- 4
-- SELECT
-- 	name, dept_name, tot_cred
-- FROM
-- 	student
-- WHERE
-- 	tot_cred >= 98
-- ORDER BY
-- 	tot_cred;
--     

-- -- 5
-- SELECT
-- 	ID, name
-- FROM
-- 	student
-- WHERE
-- 	(dept_name = 'Elec. Eng.' OR dept_name = 'Comp. Sci.') AND tot_cred >= 90
-- ORDER BY
-- 	ID;
--     
-- -- 6
-- SELECT
-- 	*
-- FROM 
-- 	student
-- ORDER BY
-- 	name;
--     
-- -- 7
-- SELECT
-- 	ID, name, salary
-- FROM 
-- 	instructor
-- ORDER BY
-- 	salary desc;
--     
-- -- 8
-- SELECT DISTINCT
-- 	dept_name AS major
-- FROM
-- 	student
-- ORDER BY
-- 	dept_name;




-- Lab 2 
-- 1
-- insert into student values(12399, 'Fred Brooks', 'Comp. Sci.', 0);

-- -- 2
-- UPDATE 
-- 	student
-- SET 
-- 	tot_cred = '100'
-- WHERE 
-- 	ID = '12399';

-- -- 3
-- UPDATE 
-- 	instructor
-- SET 
-- 	salary = salary * 1.04;

-- -- 4
-- UPDATE 
-- 	instructor
-- SET 
-- 	salary = salary + 3500
-- WHERE 
-- 	dept_name = 'Physics';

-- -- 5
-- -- DELETE FROM 
-- -- 	course
-- -- WHERE 
-- -- 	course_id = 'PHY-101';

-- -- 6
-- DELETE FROM 
-- 	course
-- WHERE 
-- 	course_id = 'CS-315';

-- -- 7 The delete didn't work in 5 because it was being referenced in another area already.

-- -- 8
-- insert into takes values ('12399', 'CS-101', '1', 'Fall', '2009', null);

-- -- 9
-- SELECT
-- 	ID, course_id, sec_id, semester, year
-- FROM
-- 	takes
-- WHERE
-- 	grade is null;

-- -- 10
-- UPDATE 
-- 	takes
-- SET 
-- 	grade = 'A'
-- WHERE
-- 	ID = '12399' AND course_id = 'CS-101';