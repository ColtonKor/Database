 drop schema if exists prescription;
 create schema prescription;
 use prescription;
 
 create table doctor(
   id int primary key auto_increment,
   ssn varchar(9) not null, 
   last_name varchar(30) not null, 
   first_name varchar(30) not null,
   specialty varchar(30),
   practice_since int );  
   
create table patient(
   id int primary key auto_increment, 
   ssn varchar(9) not null,
   last_name varchar(30) not null,
   first_name varchar(30) not null, 
   street varchar(30) not null, 
   city varchar(30) not null, 
   state varchar(30) not null,
   zip varchar(30) not null, 
   birthdate date not null, 
   doctor_id int, 
   foreign key(doctor_id) references doctor(id) 
   );
   
create table drug(
   drugID int not null primary key,
   name varchar(30)); 
   
insert into drug (drugID, name) values
    (10000, 'lisinopril'), 
	(10010, 'mirtazapine');

create table pharmacy(
   id int not null primary key,
   name varchar(30) not null,
   address varchar(80) not null,
   phone varchar(30));

insert into pharmacy (id, name, address, phone) 
values( 1, 'CVS', '123 Main', '831-981-9207');

create table prescription(
    rxid int primary key auto_increment,
    doctor_id int not null,
    patient_id int not null,
    drug_id int not null references drugs,
    quantity int not null,
    create_date date default(curdate()), 
	refills int default(0), 
    foreign key(doctor_id) references doctor(id),
    foreign key(patient_id) references patient(id),
    foreign key(drug_id) references drug(drugid));
    
alter table prescription auto_increment = 10000000;

create table prescription_fill (
   rxid int not null, 
   fill_no int not null, 
   fill_date date default (curdate()), 
   pharmacy_id int,
   cost numeric(8,2), 
   primary key (rxid, fill_no),
   foreign key(rxid) references prescription(rxid), 
   foreign key(pharmacy_id) references pharmacy(id)
);

create table drug_cost (
  pharmacy_id int not null,
  drug_id int not null, 
  price numeric(9,2), 
  primary key(pharmacy_id, drug_id), 
  foreign key(pharmacy_id) references pharmacy(id), 
  foreign key(drug_id) references drug(drugid) );
  
insert into drug_cost values(1, 10000, 0.05);
insert into drug_cost values(1, 10010, 0.10);

SELECT *
FROM doctor;

SELECT *
FROM patient;

SELECT * 
FROM drug;

SELECT *
FROM prescription;

SELECT * 
FROM pharmacy;