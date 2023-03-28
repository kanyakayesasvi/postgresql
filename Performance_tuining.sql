
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
select pg_indexes_size('t1');--0 
select pg_size_pretty(pg_indexes_size('t1'));--0 bytes

create index idx1 on t1(x);

explain select* from t1;
--"Seq Scan on t1  (cost=0.00..1348533.40 rows=2621440 width=1636)"

--size of indices with out index
select pg_indexes_size('t1');--18186240 
select pg_size_pretty(pg_indexes_size('t1'));--"17 MB"

SELECT COUNT(*) FROM T1;

SELECT A.X FROM T1 A JOIN T1 B ON A.x = B.x;


CREATE TABLE T2(X INT);

SELECT * FROM T2;
ANALYZE T2;


SELECT A.X FROM T2 A JOIN T2 B ON A.x = B.x;
ANALYZE T1;
SELECT A.X FROM T2 A JOIN T1 B ON A.x = B.x;

SELECT A.X FROM T1 A JOIN T2 B ON A.x = B.x;



explain (format json) select * from t1 where x = 50
union
select * from t1 where x = 100;

--sort key to check the duplicates

-- "Unique  (cost=16.30..16.37 rows=2 width=24056)"
-- "  ->  Sort  (cost=16.30..16.30 rows=2 width=24056)"
-- "        Sort Key: t1.x, t1.y, t1.a, t1.b, t1.c, t1.d, t1.e, t1.f, t1.g, t1.h, t1.i, t1.j, t1.k, t1.l"
-- "        ->  Append  (cost=0.43..16.29 rows=2 width=24056)"
-- "              ->  Index Scan using idx1 on t1  (cost=0.43..8.13 rows=1 width=1636)"
-- "                    Index Cond: (x = 50)"
-- "              ->  Index Scan using idx1 on t1 t1_1  (cost=0.43..8.13 rows=1 width=1636)"
-- "                    Index Cond: (x = 100)"



explain (format json) select * from t1 where x = 50
union all
select * from t1 where x = 100;

create table t4 (x int, y int  not null) ;

create or replace view v_t4 as
select * from t4;

select * from v_t4;

alter table t4 add column z int;

select * from v_t4;
--only two columns

insert into v_t4(x,y) values (3,3);  
--what will happen

select * from t4;
select * from v_t4;

drop table t4;-- what will happen

-- --cannot drop table t4 because other objects depend on it
-- DETAIL:  view v_t4 depends on table t4
-- HINT:  Use DROP ... CASCADE to drop the dependent objects too.
-- SQL state: 2BP01

insert into t2(x)values(2);

SELECT *
FROM t4
CROSS JOIN t2;




