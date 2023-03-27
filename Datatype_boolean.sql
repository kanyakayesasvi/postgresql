create table table_boolen
(
prod_id serial primary key,
	id_available BOOLEAN NOT  NULL


);


INSERT INTO TABLE_BOOLEN (id_available) 
VALUES
('true'),
('false'),
('y'),
('n'),
('yes'),
('no'),
('1'),
('0')
RETURNING *;


select * from table_boolen
where 
id_available=TRUE


select * from table_boolen
where 
id_available='0'



select * from table_boolen
where
id_available


select * from table_boolen
where  not
id_available



--set default vales for boolen columns
alter table table_boolen
alter column id_available
set default 'FALSE'


