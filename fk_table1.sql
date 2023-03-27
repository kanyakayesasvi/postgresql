
drop table movies;
create table movies(
	movie_id serial PRIMARY key,
	movie_name varchar(150) not null,
	movie_length int,
	movie_lang varchar(20),
	age_certificate varchar(10),
	release_date date
	
);


insert into movies(movie_name,movie_length,movie_lang,age_certificate,release_date)
values
('kgf',314,'telugu','13','2021-09-01'),
('ccc',154,'hindi','15','2020-05-02'),
('aaa',184,'tamil','17','2012-03-01'),
('bbb',214,'hindi','13','2023-05-01'),
('las',185,'english','18','2014-06-12'),
('def',154,'kanada','13','2015-09-08'),
('ghi',145,'english','13','2020-09-01'),
('jkl',165,'english','18','2020-06-01')

returning *;

select * from movies


delete from movies
where movie_id=2


--helps to drop a table with constarains 
drop table movies cascade;


-- ERROR:  update or delete on table "movies" violates foreign key constraint "movies_actors_movie_id_fkey" on table "movies_actors"
-- DETAIL:  Key (movie_id)=(2) is still referenced from table "movies_actors".
-- SQL state: 23503