create table movies_revenues(
 revenue_id serial primary key,
	movie_id int references movies (movie_id),
	revenue_domestic numeric(10,2),
	revenue_international numeric (10,2)
);


 