--date
create table  table_dates(
id serial  primary key,
	emp_name varchar(100) not null,
	hire_date date  not null,
		add_date date default current_date
	
)


insert into table_dates( emp_name,hire_date)
values
('yesasvi','2022-05-01')
returning *

select now();

select current_date;



