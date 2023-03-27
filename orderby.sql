--orderby
--single column in asc
select * from
movies 
order by
release_date asc;


--single column in desc
select * from
movies 
order by
release_date desc;


--using multiple column
--movie name-asc and release_date->desc

select * from
movies 
order by
release_date desc,
movie_name asc;

--using column number
select 
release_date,
movie_name,
movie_lang
from
movies
order by
1 desc,
3 asc;


--orderby using expression
select
movie_lang,
length(movie_lang) as leng
from
movies
order by leng desc;

