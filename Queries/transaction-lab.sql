-- lab week 10 transactions & concurrency
create database lab15;
use lab15;
create table account (
  acctno int primary key, 
  balance int
); 
create table duty (
  name varchar(20) primary key, 
  status varchar(10)
); 
insert into account values (1001, 500), (2020, 750); 
insert into duty values ('Bob', 'on'), ('Alice', 'on');