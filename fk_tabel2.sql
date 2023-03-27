--movies_actors junction table

drop table movies_actors
CREATE table movies_actors (
	
	movie_id int references movies(movie_id)
	ON DELETE CASCADE,
	actor_name varchar(40)
	
);

--ON DELETE RESTRICT


-- alter table movies_actors
-- drop column movie_id

insert into movies_actors(movie_id,actor_name)
values
(1,'a'),
(2,'b'),
(3,'c'),
(1,'d'),
(2,'e'),
(3,'f'),
(4,'g')

select * from movies_actors



SELECT a.movie_id,b.movie_name,a.actor_name 
FROM movies_actors a 
JOIN movies b ON a.movie_id= b.movie_id;



delete from movies
where movie_id=2


