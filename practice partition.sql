drop table pr_t1 cascade;
drop  table pr_t2 cascade;

create table pr_t1(
	c int,
	d int
)partition by list(c);

create table pr_t1_p1 partition of pr_t1
	for values in(1);
create table pr_t1_p2 partition of pr_t1
	for values in(2);
create table pr_t1_default partition of pr_t1  default;

insert into pr_t1(c,d)values 
(1,2),
(3,4),
(2,4),
(5,6),
(1,6);


select * from pr_t1;
select * from pr_t1_p1;

select * from pr_t1_p2;

select * from pr_t1_default;


-- insert into pr_t1(c,d) values
-- (2,5);



create table pr_t2(
	c int,
	d int
)partition by list (c);

create table pr_t2_p1 partition of pr_t2
	for values in(1);


-- rollback;
-- begin transaction;
-- alter table pr_t1 detach  partition pr_t1_p2;
-- alter table pr_t2 attach  partition pr_t1_p2;
-- commit transaction;


alter table pr_t1 detach  partition pr_t1_p2;

alter table pr_t2 attach  partition pr_t1_p2 for values in (2);

select * from pr_t1_p2;

--with out transaction
-- ERROR:  syntax error at or near ";"
-- LINE 1: alter table pr_t2 attach  partition pr_t1_p2;
--                                                     ^
-- SQL state: 42601
-- Character: 45
	

-- create table pr_t2_p1 partition of pr_t2
-- 	for values in(2);
--

--with transaction

insert into pr_t2(c,d)values 
(1,2),
(3,4),
(2,4),
(5,6),
(1,6);






--default table

create table p1_t3(a int,b int ) partition by range(a);


CREATE TABLE pr_t3_default partition of p1_t3 default;

insert into p1_t3(a,b) values(200,150);

select * from pr_t3_default;

alter table p1_t3  detach partition pr_t3_default;

alter table p1_t3  attach partition pr_t3_default for values from (1) to (250); 


--create a table same str
--detach and attach


alter TABLE pr_t3_1_250 partition of p1_t3
	for values from (1) to (250) ;	
-- ERROR:  updated partition constraint for default partition "pr_t3_default" would be violated by some row
-- SQL state: 23514



drop TABLE pr_t3_default;

select * from pr_t3_1_250;

drop table p1_t3 cascade;

