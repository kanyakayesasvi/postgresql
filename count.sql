--count

select * from movies;

--count all records
select count(*) from movies;


--countsall the records of specifc column
select count(movie_name) from movies


--count with distinct
select count(distinct movie_lang)
from 
movies;

--count telugu movies
select count(*) from movies
where movie_lang='telugu'

select count(dirctor_id)from movies