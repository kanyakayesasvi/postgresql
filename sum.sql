--sum function

select * from movies

select 
	sum(movie_length) 
	from
movies;


select 
	sum(movie_length) 
	from
movies
where movie_length>200;


select 
	sum(movie_length) 
	from
movies
where movie_lang='english';




select 
	sum(distinct movie_length) 
	from
movies;





