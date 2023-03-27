--schema
	
select * from hr.public.employees

select * from hr.humanresorces.employee

--movie a table to new schema

alter table humanresorces.order set schema public



--schema search path


select current_schema()

show search_path
--"""$user"", public"

--set search path 
set search_path to humanresorces,public

show search_path
--"humanresorces, public"

select * from test1

insert into public.test1(id2)values (1);



select * from public.test1

set search_path to public,humanresorces



--to move a schema with whole data

CREATE TABLE lt(I int,j int)



insert into lt (i,j)values(1,1),(2,1),(3,5) returning*;


--make dump
pg_dump -d hr -h localhost -U postgres -n public > dump.sql 

--chage thr public schema name
--import back
psql -h localhost -U postgres -d hr -f dump.sql


set search_path  to "$user", public

--view pg_catalog
select * from information_schema.schemata;
SELECT * FROM information_schema.columns;











