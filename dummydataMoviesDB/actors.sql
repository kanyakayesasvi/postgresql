create table actors (
	actor_id SERIAL PRIMARY KEY,
	FIRST_name varchar(150),
	last_name varchar(150) not NULL,
	gender char(1),
	date_of_birth date,
	add_date date,
	update_date date
	
	

);