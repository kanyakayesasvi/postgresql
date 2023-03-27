--sequences
create sequence if not exists  test_seq;

select nextval('test_seq');

select currval('test_seq');

alter sequence  test_seq restart with 100


select setval('test_seq',100);


select setval('test_seq',200,false)


create sequence if not exists  test_seq2 start with 100

create sequence if not exists test_seq3
increment 20
minvalue 400
maxvalue 6000
start with 500;


select nextval('test_seq3')




create sequence if not exists test_seq4 as smallint
create sequence if not exists test_seq5 as int




--desc
create sequence if not exists test_asc
select nextval('test_asc')



create sequence if not exists test_desc
increment -1
minvalue 1
maxvalue 3
start 3
cycle;
select nextval('test_desc')



create sequence if not exists test_desc1
increment -1
minvalue 1
maxvalue 3
start 3
no cycle;
select nextval('test_desc1')



drop sequence test_seq




create table person(
id serial ,
name varchar(12)
);

select * from person;

insert into person(name) values ('yesawe'),('geewe') 
returning *;


alter sequence person_id_seq restart with 100
select nextval('person_id_seq')






create table person1(
id int  ,
name varchar(12)
);

--create sequence

create sequence  person1_id_seq
start with 100 owned by person1.id



alter table person1
alter column id  set default nextval('person1_id_seq')

insert into person(name) values ('yeshu'),('geewe') 
returning *;



--lisrt of all sequences using meta data	

select relname sequence_name
from pg_class
where relkind='S'


--uding same sequence b/w two tables
create sequence common_fruit_seq start with 50;


create table apple(
	fruit_id int default nextval('common_fruit_seq') not null,
	fruit_name varchar(54)
)



create table mango(
	fruit_id int default nextval('common_fruit_seq') not null,
	fruit_name varchar(54)
)




insert into apple(fruit_name)values ('smallapple'),('lightgreenapple')

insert into mango(fruit_name)values ('bigmango'),('greenmango')

select * from apple;
select * from mango;

--alpha numeric

create sequence table_con;

create table contact(

 contact_id text not null default ('id' || nextval('table_con')),
	name varchar(30))
	
	
	
insert into contact(name)values('yesasvi'),('geeta')
select * from contact
							
