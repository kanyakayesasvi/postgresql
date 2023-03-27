
drop table t1;

create table t1(x int, y int);


insert into t1 values(1,NULL);
insert into t1 values(1,2);
insert into t1 values(2,2);
insert into t1 values(3,2);
insert into t1 values(4,1);

select * from t1;






insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;


explain select * from t1;
--cost37814.40 sequence scan





alter table t1 add column a char(500);
alter table t1 add column b char(500);
alter table t1 add column c char(500);
alter table t1 add column d char(500);
alter table t1 add column e char(500);
alter table t1 add column f char(500);
alter table t1 add column g char(500);
alter table t1 add column h char(500);
alter table t1 add column i char(500);
alter table t1 add column j char(500);
alter table t1 add column k char(500);
alter table t1 add column l char(500);


select * from t1;
--2.3 sec query time


update t1 set a = 'some long string that should be 500 chars',
b = 'some long string that should be 500 chars',
c = 'some long string that should be 500 chars',
d = 'some long string that should be 500 chars',
e = 'some long string that should be 500 chars',
f = 'some long string that should be 500 chars';
--4mins

update t1 set g = 'some long string that should be 500 chars',
h = 'some long string that should be 500 chars',
i = 'some long string that should be 500 chars',
j = 'some long string that should be 500 chars',
k = 'some long string that should be 500 chars',
l = 'some long string that should be 500 chars';
--4 min



select * from t1;
--with out index ----5 min

explain select* from t1;
--"Seq Scan on t1  (cost=0.00..1348659.59 rows=2634059 width=1636)"
--size of indices with out index
select pg_indexes_size('t1')--0 
select pg_size_pretty(pg_indexes_size('t1'))--0 bytes

create index idx1 on t1(x);

explain select* from t1;
--"Seq Scan on t1  (cost=0.00..1348533.40 rows=2621440 width=1636)"

--size of indices with out index
select pg_indexes_size('t1')--18186240 
select pg_size_pretty(pg_indexes_size('t1'))--"17 MB"
