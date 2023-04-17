create or replace function fn_emp_deta(emp_id integer)
returns table(
	empid integer,
	empname varchar(100),
	empdate date
) as
$$
begin

	return query
	select * from employees where emp_id=emp_id

end;

$$ language plpgsql;


select * from fn_emp_deta(1);


emp
id 
name

slar
id,month, salarey 

select * from employees
except
select * from salarey



select id from employees where id not in (selext id from slarares)

 create table sa
 
 (
	 id integer,
	 month integer,
	 sly   integer
  );
insert into sa
values
(1,1,123),
(2,1,123);
drop table sa;
insert into sa values
(1,1,1098),
(1,2,1098),
(1,3,1098),
(1,4,1098),
(1,5,1098),
(2,1,1098),
(2,2,1098),
(2,3,1098),
(2,4,1098) returning *;


select id from (select id, sum(sly) tt from sa
group by 1) as a 
where tt>5000;



create  table emp
(id integer,
	name varchar(20)
);

insert into emp
values
(1,'yesasvi'),
(2,'geeta'),
(3,'sreeya');

select * from sa;

select  e.id,e.name,sa.sly from emp e  left join sa on e.id=sa.id
where sly is ;







