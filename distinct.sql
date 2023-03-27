--distinct

select * from movies



--get unique movie_lang
select 
	distinct movie_lang
from 
movies
order by movie_lang desc;


--get unigue movie_lang and age_certificate
select 
	distinct movie_lang,age_certificate
from 
movies
order by movie_lang desc;


--get all unique records
select distinct * from movies;
