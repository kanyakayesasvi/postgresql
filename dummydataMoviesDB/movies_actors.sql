--movies_actors junction table


CREATE table movies_actors (
	
	movie_id int references movies(movie_id),
	actor_id int references actors(actor_id),
	PRIMARY KEY(movie_id,actor_id)
);