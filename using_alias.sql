--using alias
SELECT * FROM movies;


select
movie_id as movieid
from movies


--using "" to achive how we want
select 
movie_id as "Movie Id"
from movies

--using alias from different columns
select 
movie_id as "Movie Id",
movie_name as "Movie Name"
from movies


--as is optional
select 
movie_id "Movie Id",
movie_name  "Movie Name"
from movies

