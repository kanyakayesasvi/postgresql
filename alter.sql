-- Database: mydata

-- DROP DATABASE IF EXISTS mydata;

CREATE DATABASE mydata
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
	
	
	
create table person(
person_id serial,
	first_name varchar(40) not null,
	last_name varchar(40) not null
)




select * from person

--adding columns
alter table person
add column age int not null


alter table person
add column nationality  varchar(30),
add column  email varchar(30) unique


--Rename a table	
alter table person
rename to users;

select * from users



--rename a column name
alter table users
rename column  last_name to surname;



--drop a column

alter table users
drop column age;


alter table users
add column age varchar(8) not null

--change data type
alter table users
alter column age type int
using age::integer;



--default value
alter table users
ADD COLUMN IS_ENABLE VARCHAR(1)

ALTER TABLE USERS
ALTER COLUMN IS_ENABLE SET DEFAULT 'Y'
