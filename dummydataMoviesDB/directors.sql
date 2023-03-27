create table directors(
	dirctor_id serial PRIMARY Key,
	first_name varchar(150),
	last_nmae varchar(150),
	date_of_birth date,
	nationality varchar(20),
	add_date date,
	update_date date
	
);



select * from directors;