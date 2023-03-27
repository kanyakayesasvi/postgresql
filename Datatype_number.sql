--number data type

create table table_serial(
id serial,
prodyct_type varchar(100)
	
)

insert into table_serial(prodyct_type)
values
('pencile1')
returning *

select * from table_serial;

DELETE FROM table_serial
WHERE id=2
returning *;

