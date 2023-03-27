--UUID


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


select uuid_generate_v1();
--consit os f address and timestamp

select uuid_generate_v4();
--pure random number

create table table_uuid(
	id uuid default uuid_generate_v1(),
	name varchar(45)
);

insert into table_uuid(name)
values
('yesasvi'),
('geeta'),
('sreeya')

select * from table_uuid


alter table table_uuid
alter column id
set default uuid_generate_v4()