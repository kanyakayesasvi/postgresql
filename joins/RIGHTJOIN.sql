--right join
select * from l_p
right join r_p
on l_p.p_id=r_p.p_id


-- get all the movives with directors names

select m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name"
from directors d right join movies m on m.director_id=d.director_id
order by 2


--usiing leftjoin
select m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name"
from  movies m  left join directors d on m.director_id=d.director_id
order by 2

select* from directors

--get list of english and chiness
select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name",
m.movie_lang
from  directors d left join  movies m  on m.director_id=d.director_id
where 	m.movie_lang in ('English','Chinese')
order by m.movie_lang


select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name",
m.movie_lang
from movies m  right join  directors d  on m.director_id=d.director_id
where 	m.movie_lang in ('English','Chinese')
order by m.movie_lang





select 
(d.last_name ||' ' || d.first_name) "director_name",
count(movie_name)
from  directors d right join  movies m  on m.director_id=d.director_id
group by 1
order by 2 desc





