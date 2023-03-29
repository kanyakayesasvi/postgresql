drop table practice.t1;

create table practice.t1(x int, y int) partition by list(y);

create table t1_p1 partition of practice.t1
 for values in(1);

create table t1_p2 partition of practice.t1
 for values in(2);
 
create table t1_p3_default partition of practice.t1 default;


insert into practice.t1 values(1,NULL);
insert into practice.t1 values(1,2);
insert into practice.t1 values(2,2);
insert into practice.t1 values(3,2);
insert into practice.t1 values(4,1);

select * from practice.t1;
select * from only practice.t1;

select * from t1_p1;

select * from t1_p2;

select * from t1_p3_default;






insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
insert into practice.t1 select * from practice.t1;
--4 sec

select * from practice.t1;
--1.40 sec
select * from only practice.t1;

select * from t1_p1;

select * from t1_p2;

select * from t1_p3_default;


explain select * from practice.t1;
--cost37814.40 sequence scan(old with out partition)
--cost(5.0921)





alter table practice.t1 add column a char(500);
alter table practice.t1 add column b char(500);
alter table practice.t1 add column c char(500);
alter table practice.t1 add column d char(500);
alter table practice.t1 add column e char(500);
alter table practice.t1 add column f char(500);
alter table practice.t1 add column g char(500);
alter table practice.t1 add column h char(500);
alter table practice.t1 add column i char(500);
alter table practice.t1 add column j char(500);
alter table practice.t1 add column k char(500);
alter table practice.t1 add column l char(500);

--164ms

select * from practice.t1;
--1.919


update practice.t1 set a = 'some long string that should be 500 chars',
b = 'some long string that should be 500 chars',
c = 'some long string that should be 500 chars',
d = 'some long string that should be 500 chars',
e = 'some long string that should be 500 chars',
f = 'some long string that should be 500 chars';
--3 10 sec

update practice.t1 set g = 'some long string that should be 500 chars',
h = 'some long string that should be 500 chars',
i = 'some long string that should be 500 chars',
j = 'some long string that should be 500 chars',
k = 'some long string that should be 500 chars',
l = 'some long string that should be 500 chars';
--6 min 45

select * from practice.t1 where y=1;
--41.725sec






