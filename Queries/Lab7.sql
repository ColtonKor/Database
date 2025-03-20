-- set @@autocommit = 0;
-- select @@autocommit;

-- select * from account;
-- update account set balance = balance + 200 where acctno=1001;
-- update account set balance = balance - 200 where acctno=2020;
-- select * from account;

-- rollback;
-- -- commit;
-- select * from account;


use lab15;
set @@autocommit = 0;
select * from account
where acctno=1001;


select * from account
where acctno=1001;
update account set
balance=balance+100
where acctno=1001;


select * from account
where acctno=1001;
commit;