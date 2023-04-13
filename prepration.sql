create table employees(
	emp_id serial primary key,
	name varchar(100),
	salary integer
);

insert into employees(name,salary)
values
('Yesasvi',55000),
('geeta',35000),
('sreeya',23000),
('mohan',23120),
('pavan',23000),
('jayanth',35000),
('charan',5000)
returning *;

insert into employees(name,salary)
values
('pavan',23000) returning *

delete from employees where emp_id=8;

--highest salary---------------------------------------
select * from employees where salary=
(select max(salary) from employees);


--second highest salary----------------------------

select * from employees
order by salary desc
limit 2 offset 1;

select * from employees
order by salary desc
fetch first 1 row only;


select * from employees
order by salary desc
fetch next 2 row only
offset 1;



select name,salary from employees where salary=
(select max(salary) as s from employees where salary <>(select max(salary) from employees)
order by s desc) 


select * from employees 
where salary=
(select max(salary) from employees 
where salary <(select max(salary) from employees));








select max(salary) from employees;

select * from employees order by salary desc
limit 2 offset 1

select * from employees where salary=(select max(salary) from employees where salary < (select max(salary) from employees))


--third highest salary--------------------------
select * from employees 
where salary=
(select max(salary) from employees 
where salary<(select max(salary) from employees 
where salary <(select max(salary) from employees))
);

select *,
dense_rank() over(order by salary desc)
from employees;


select *,lead(emp_id,1) over() from employees;

select *, lag(emp_id,1) over() from employees;

select *,row_number() over() from employees;




--all the salary using dens rank------------------------
select emp_id,name,salary from (select *,
dense_rank() over(order by salary desc)
from employees)as s
where dense_rank=3;

--------------------------------------------------------------------
 create table dupli(
 id integer
 );


insert into dupli
values
(1),
(2),(3),(4),(5),(1),(3),(2),(1) returning *;



select * from dupli
group by id;

select 
distinct id 
from dupli;



create table dupli2(
id integer,
	name varchar
);

insert into dupli2
values
(1,'yesasvi'),
(2,'Geeta'),(3,'sreeya'),(4,'chsran'),(5,'pavan'),(1,'yesasvi'),(3,'mohan') returning *;

select * from dupli2;




select id,name from dupli2
group by name,id;


--duplicate records
select min(id),name from dupli2
group by name



select distinct id , name from dupli2; 

with cte as(
select id,name,row_number() over(partition by name) from dupli2) select id, name from cte where row_number=1 order by id;










--array datatype

create table array_dt(
	id integer,
	name text[]

);


insert into array_dt 
values
(1,array['yesasvi','yeshu']),
(2, array['geeta','geeta'])
returning *;

select name[1]
from array_dt;

--- hstore datatype: hstore is a data type that allows you to store key-value pairs in a single column


CREATE TABLE hstore_dt  (h hstore);

INSERT INTO hstore_dt VALUES ('a=>b, c=>d');

SELECT h['a'] FROM hstore_dt;

--json data type

create table json_dt(j json);

insert into json_dt values ('{"name":"yesasvi",
							"gender":"female",
							"age":21}') returning *;
							
select j->'name' from json_dt;		---- return o/p data type json			
							
select j->>'gender' from json_dt;		----return o/p datatype text						
						

---mvcc-----------------
drop table u; 
create table u(id numeric,amount integer);

insert into u values(1,100);

begin;
select * from u;
update  u 
set amount=100
where id=1;
rollback;
commit


begin;
select * from u;
update  u 
set amount=300
where id=1;
commit;



 
--indexes----------------------

select * from pg_am; ----type of nodes


--cluster index and non cluster index


create table cluster_table(
id int,
	name varchar(20)

);

insert into
cluster_table
values
(1,'yesasvi'),
(5,'yeshu'),
(3,'getta'),
(4,'geetu'),
(7,'sreeya')
returning *;


create   index idx_cluster_u on cluster_table using btree(id);

select * from cluster_table;


--metadata

select * from information_schema.tables
where table_schema='public';



select column_name from information_schema.columns
where table_name='cluster_table';


select left('yesasvi',4);
select right('yesasvi',4);


select split_part('1,2,3',',',2)



select lpad('database',15,'*')


select 	substring('have a good day' from 10)


--converting a table to json

select row_to_json(employees) from employees;




DO $$ 
BEGIN 
  RAISE INFO 'information message %', now() ;
  RAISE LOG 'log message %', now();
  RAISE DEBUG 'debug message %', now();
  RAISE WARNING 'warning message %', now();
  RAISE NOTICE 'notice message %', now();
END $$;



--recuurcive cte----------------------


with recursive cte(list) as
(
	select 10
	
	union all
	
	select list + 5 from cte
	where  list<=50
	

)select list from cte;



with recursive cte(list) as
(

	select 10
	
	union all
	
	select list+5 from cte
	where list<=20
) select list from cte

create or replace function fn_exception_handling(x integer,y integer) returns real as 
$$
declare
	z real;
begin
	z=x/y;
	raise notice '%',z;
	exception when  division_by_zero then 
	raise info 'error %,%',sqlstate,sqlerrm; 

end
$$ language plpgsql

select fn_exception_handling(10,2);

select fn_exception_handling(2,0);




--trigger example-------------------

CREATE OR REPLACE FUNCTION check_salary() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.salary > 100000 THEN
    RAISE EXCEPTION 'Salary cannot be greater than $100,000';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_salary_trigger
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION check_salary();




