--transactions for ddl

-- CREATE, DROP, ALTER,TRUNCATE


begin
 create database transaction_db;
commit
rollback;

-- The CREATE DATABASE statement must run in autocommit mode 
-- (the default transaction management mode) and is not allowed in an explicit or implicit transaction

-- ERROR:  CREATE DATABASE cannot run inside a transaction block
-- SQL state: 25001

--alter database
BEGIN
ALTER DATABASE hr 
RENAME TO hr1;
COMMIT
ROLLBACK;


--drop database
begin
drop database testdb2;
commit
-- ERROR:  DROP DATABASE cannot run inside a transaction block
-- SQL state: 25001
rollback;

-- create table t5(id int);
-- insert into t5(id)values(1);
-- drop table t5;

--create a table
begin
create table tran_t1(
	id int
);
commit;

select * from tran_t1;

begin
create table tran_t2(
	id2 int
);
select * from tran_t2;
rollback;

select * from tran_t2;
-- ERROR:  relation "tran_t2" does not exist
-- LINE 1: select * from tran_t2;
--                       ^
-- SQL state: 42P01
-- Character: 15


--alter
begin 
alter table tran_t1 add column name varchar(100);
select * from tran_t1;
commit
select * from tran_t1;


begin 
alter table tran_t1 add column age int;
select * from tran_t1;
rollback;
select * from tran_t1;


begin 
alter table tran_t1 add column age int;
select * from tran_t1;
commit

begin 
alter table tran_t1 drop column age;
select * from tran_t1;
commit


--drop table
begin
DROP TABLE tran_t1;
select * from tran_t1;
-- ERROR:  relation "tran_t1" does not exist
-- LINE 1: select * from tran_t1;
--                       ^
-- SQL state: 42P01
-- Character: 15
rollback;


select * from tran_t1;

begin
DROP TABLE tran_t1;
commit;
select * from tran_t1;

--insert into
begin
insert into tran_t1(id)values(1),(2),(3);
commit;

select * from tran_t1;

begin
insert into tran_t1(id)values(4),(5),(6);
select * from tran_t1;
rollback;


--truncate
begin
TRUNCATE TABLE tran_t1;
select * from tran_t1;
rollback;


select * from tran_t1;

begin
TRUNCATE TABLE tran_t1;
select * from tran_t1;
commit;

select * from tran_t1;



--create a table using stored procedure

create or replace procedure sp_create_table()
as
$$
	begin
		create table sp_create_table1(
		id int,
		name varchar(100));
	end;

$$ language plpgsql


call sp_create_table();



create or replace procedure sp_drop_table()
as
$$

	begin
		drop table sp_create_table1;
	end;

$$ language plpgsql

begin
call sp_drop_table();
select * from sp_create_table1;
commit;
rollback;












