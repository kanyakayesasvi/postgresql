--partitioning

--table inhertitance

--master-->master_child

create table master(
	pk serial primary key,
	tag text,
	parent int);
--creates inhertitance
create table master_child() inherits (master);
create table master_child2() inherits(master);

alter table master_child 
add constraint master_pk primary key(pk);


select * from master;


select * from master_child;
--to check no of children table
-- step1:psql -h localhost -d database_name -U postgres
-- step:2 /d table_name
--step3:to check the child table \d+ table_name


--let see insertion
insert into master( pk, tag,parent) values
(1,'pen',0);


insert into master_child( pk, tag,parent) values
(2,'pencile',0) returning *;

insert into master_child2( pk, tag,parent) values
(3,'book',0) returning *;

select * from master;
select * from master_child;
select * from master_child2;


--individual records from each table

select * from only master;
select * from only master_child;
select * from only master_child2;
--updat effect
update master
set tag='monitor'
where pk=2;


update master_child
set tag='m1'
where pk=2;


--delete
delete from master where pk=2;

ALTER TABLE master_child2
ADD COLUMN  master_child2_column VARCHAR;




insert into master_child2( pk, tag,parent,master_child2_column) values
(8,'ink pen',0,'yesasvi') returning *;

-- delete from master_child2 where master_child2_column='yesasvi';


select * from master;
select * from master_child;
select * from master_child2;



select * from only master;
select * from only master_child;
select * from  only master_child2;




--droping parent table(delete all the child table also)
drop table master cascade


--partition by range

create table employees_range(
	id bigserial,
	birth_date date not null,
	country_code varchar(2) not null
) partition by range(birth_date);


-- create table partitipn_table_name partition  to  master_table for values  from valu1 to value2

create table employees_range_y2000 partition of employees_range
	for values from ('2000-01-01') to ('2001-01-01');


create table employees_range_y2001 partition of employees_range
	for values from ('2001-01-01') to ('2002-01-01');
	
select * from employees_range_y2001;
select * from employees_range_y2000;
select * from employees_range;
	
insert into employees_range (birth_date,country_code) values
('2000-01-01','US'),
('2000-01-02','US'),
('2000-12-31','US'),
('2001-01-01','US') returning *;


select * from employees_range;
select * from only employees_range;

	
select * from employees_range_y2001;

select * from employees_range_y2000;

select * from only employees_range_y2001;

select * from only employees_range_y2000;
--update operation
update employees_range set birth_date='2001-10-10' where id=1


-- delete
select * from employees_range
delete from employees_range where id=1;

--query planning
select * from employees_range;



select * from employees_range
where birth_date='2000-01-02'


--partition by list

create table employees_list(
	id bigserial,
	birth_date date not null,
	country_code varchar(2) not null
) partition by list (country_code);

create table employees_list_us partition of employees_list
	for values in('US');

CREATE TABLE employees_list_EU PARTITION OF employees_list
fOR values in ('UK','DE','IT','FR','ES');
	
SELECT * FROM employees_list_EU;
	
	
insert into employees_list (id,birth_date,country_code) values
(1,'2000-01-01','US'),
(2,'2000-01-02','US'),
(3,'2000-12-31','UK'),
(4,'2001-01-01','DE')
RETURNING *;


SELECT * FROM employees_list;

SELECT * FROM ONLY employees_list;


SELECT * FROM employees_list_US;

SELECT * FROM employees_list_EU;



SELECT * FROM ONLY employees_list_US;


SELECT * FROM ONLY employees_list_EU;

UPDATE employees_list  SET COUNTRY_CODE='US'
WHERE id=4

delete from employees_list where id=2

explain select * from employees_list;

explain select * from employees_list where country_code='US';

--PARTITION BY HARSH
create table employees_hash(
	id bigserial,
	birth_date date not null,
	country_code varchar(2) not null
) partition by hash (id);

create table employees_hash_1 partition of employees_hash
	for values with (modulus 3, remainder 0);
	
	
create table employees_hash_2 partition of employees_hash
	for values with (modulus 3, remainder 1);
	
create table employees_hash_3 partition of employees_hash
	for values with (modulus 3, remainder 2);


select * from only employees_hash
select * from only employees_hash_1
select * from only employees_hash_2
select * from only employees_hash_3

select * from employees_hash
select * from employees_hash_1
select * from employees_hash_2
select * from employees_hash_3
	
insert into employees_hash (id,birth_date,country_code) values
(1,'2000-01-01','US'),
(2,'2000-01-02','US'),
(3,'2000-12-31','UK')
RETURNING *;


update employees_hash set country_code='US'
where id=3;


delete from employees_hash where id=3;

explain select * from employees_hash;

explain select * from employees_hash WHERE ID=1;


explain select * from employees_hash WHERE COUNTRY_CODE='US';


--DEAFULT PARTITION

SELECT * FROM employees_list;
SELECT * FROM ONLY employees_list;
SELECT * FROM employees_list_EU;
SELECT * FROM employees_list_US;

--DATA THAT CANOT FIT INTO ANY PARTITION

insert into employees_list (id,birth_date,country_code) values
(1,'2001-01-01','JP');
-- ERROR:  no partition of relation "employees_list" found for row
-- DETAIL:  Partition key of the failing row contains (country_code) = (JP).
-- SQL state: 23514


--SOLUTION IS TO CREAT A PARTITION FOR IT
--OR
--CAN USE  DEFAULT PARTITION(WHICH DOESNOT CONTAIN ANY PARTION THOSE VALUES WILL COME INTO IT)

create table employees_list_default_partition partition  of employees_list default;

select * from employees_list_default_partition;

insert into employees_list (id,birth_date,country_code) values
(9,'2001-01-01','JP');

select * from employees_list_default_partition;

insert into employees_list (id,birth_date,country_code) values
(11,'2003-01-01','kl');

--sub partition(multi level partition)
create table employees_master(
	id bigserial,
	birth_date date not null,
	country_code varchar(2) not null
) partition by list (country_code);


--US  LIST
--EU  LIST
----EU_1  HASH
----EU_2  HASH


CREATE TABLE employees_master_us partition of employees_master
	for values in('US');
	
	
create table employees_master_eu partition of employees_master
	for values in('UK','DE','IT','FR','ES')
	partition by hash(id);
	
--sub partition
create table employees_master_eu_1  partition  of employees_master_eu
	for values with(modulus 3,remainder 0);
	
create table employees_master_eu_2  partition  of employees_master_eu
	for values with(modulus 3,remainder 1);
	
create table employees_master_eu_3  partition  of employees_master_eu
	for values with(modulus 3,remainder 2);
	
insert into employees_master (id,birth_date,country_code) values
(1,'2000-01-01','US'),
(2,'2000-01-02','US'),
(3,'2000-12-31','UK'),
(4,'2001-01-01','DE');


select * from employees_master;

select * from employees_master_us;

select * from employees_master_eu;

select * from only employees_master_eu;

select * from employees_master_eu_1;

select * from employees_master_eu_2;

select * from employees_master_eu_3;

--partition maintaince
create table  employees_list_sp partition of employees_list
	for values in('SP');

insert into employees_list (id,birth_date,country_code)
values
(14,'2020-02-03','SP')
returning *;

select * from employees_list;


select * from employees_list_sp;



--detach a partiton
alter table  employees_list detach partition employees_list_sp;


--altering  the bounds of a partition

create table t1(a int,b int ) partition by range(a);


CREATE TABLE T1_P1 partition of t1
	for values from (0) to (100);
	

CREATE TABLE T1_P2 partition of t1
	for values from (200) to (300);	
	
insert into t1 (a,b) values(1,1);

select * from t1;
select * from t1_p1;
select * from t1_p2;

insert into t1 (a,b) values(150,150);
-- ERROR:  no partition of relation "t1" found for row
-- DETAIL:  Partition key of the failing row contains (a) = (150).
-- SQL state: 23514


-- rollback;

begin transaction;
--detach
alter table t1 detach  partition t1_p1;

--attach
alter table t1 attach  partition t1_p1  for values from (0) to(200)
commit transaction;


insert into t1 (a,b) values(150,150);


--partition indexixing

--lets create a index on parent table

create unique index idx_u_employees_list_id on employees_list(id);
-- ERROR:  unique constraint on partitioned table must include all partitioning columns
-- DETAIL:  UNIQUE constraint on table "employees_list" lacks column "country_code" which is part of the partition key.
-- SQL state: 0A000

select * from employees_list

create unique index idx_u_employees_list_id_country_code on employees_list(id,country_code);


insert into employees_list(id,birth_date,country_code) values
(15,'2021-02-01','UK')
returning *;


--partition purning

show enable_partition_pruning;


select * from employees_list;


select * from employees_list where country_code='US';--seq scan filter

set enable_partition_pruning = off ;
show enable_partition_pruning;--off

select * from employees_list where country_code='US';--seq scan

set enable_partition_pruning = on ;

show enable_partition_pruning;--on

--determine  a key field  to partition over

--sizing the partition
select min(order_date),max(order_date) from  orders;

select distinct(country_code)  from employees_list;


select country_code,count(country_code)  from employees_list group by 1;



