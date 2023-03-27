--delete a primary key column
drop table test1

create table test1(
id serial primary key,
	name varchar(20)
)

insert into test1(name)
values
('yesasvi'),
('geeta'),
('sreeya'),
('pooja')
returning *;

ALTER TABLE test1
DROP COLUMN id;



select * from test1;




SELECT CAST(12345 AS VARCHAR(10));

select 'yesasvi 123'::varchar(15) AS "NAME1";


select factorial(4)


