--time
create table table_time(
id serial primary key,
	class_name varchar(100),
	start_time time not null,
		end_time time not null
					   
);
select * from table_time
insert into table_time(class_name,start_time,end_time)
values
('math','08:30','09:12:00')


select current_time;


select current_time(4);

