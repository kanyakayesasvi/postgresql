--group by
select
movie_lang,
count(movie_id)
from movies
group by movie_lang

--group by
select
movie_lang,
count(movie_lang)
from movies
group by movie_lang

select
movie_lang,
avg(movie_length)
from movies
group by(movie_lang)


select 
movie_lang,
age_certificate,
avg(movie_length)
from movies
group by movie_lang,age_certificate
order by 2 desc





select 
movie_lang,
age_certificate,
avg(movie_length)
from movies
where movie_length>200
group by movie_lang,age_certificate
order by 2 desc



select
movie_lang,
sum(movie_length)
from movies
group by movie_lang
having sum(movie_length)>184








