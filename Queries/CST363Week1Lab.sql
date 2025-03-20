drop database IF EXISTS patientdb;
create database IF NOT EXISTS patientdb;
use patientdb;
CREATE TABLE IF NOT EXISTS patient
(
	patient_no int,
    last_name varchar(64),
    first_name varchar(64), 
    sex varchar(2),
    date_of_birth  date,
    ward int
);

DESCRIBE patient;

INSERT INTO patient
(patient_no, last_name, first_name, sex, date_of_birth, ward)
VALUES
(454, 'Smith', 'John', 'M', '1978-08-14', 6),
(223, 'Jones', 'Peter', 'M', '1985-12-7', 8),
(597, 'Brown', 'Brenda', 'F', '1961-06-17', 3),
(234, 'Jenkins', 'Alan', 'M', '1972-01-29', 7),
(244, 'Wells', 'Chris', 'F', '1996-02-25', 6);

-- 1
SELECT
	first_name
FROM
	patient
ORDER BY 
	first_name;

    
-- 2    
SELECT
	first_name
FROM
	patient
ORDER BY 
	first_name desc;


-- 3
SELECT
	last_name
FROM
	patient
WHERE
	patient_no = 234;
    
-- 4
SELECT
	ward
FROM
	patient
WHERE
	last_name = 'Smith';
    
    
-- 5
SELECT
	patient_no, last_name, first_name, sex, date_of_birth, ward
FROM
	patient
WHERE
	ward = 6;
    
-- 6
SELECT
	first_name, last_name
FROM
	patient
WHERE
	sex = 'F'
ORDER BY
	last_name;
    
    
-- 7
SELECT
	patient_no
FROM
	patient
WHERE
	patient_no >= 200
    AND
    patient_no <= 300;
    
    
-- 8
SELECT
	last_name, first_name
FROM
	patient
WHERE
	ward = 6
    OR
    ward = 7
ORDER BY
	last_name;
    

-- 9
SELECT
	last_name
FROM
	patient
WHERE
	ward = 3
    OR
    sex = 'M';
