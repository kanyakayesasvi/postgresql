
drop table lt
CREATE TABLE lt(I int,j int)
CREATE TABLE lt2(a int, b int)


insert into lt (i,j)values(1,1),(2,1),(3,5) returning*;

insert into lt2 (a,b)values(5,6),(32,15),(3,5) returning*;


select * from lt 
select * from lt2 




SELECT *
FROM LT
LEFT JOIN LT2 ON LT.I = LT2.A 
where lt.i=3

--left join


create table l_p(
	
	p_id  serial primary key,
	p_name varchar(100)
	);



create table r_p(
	p_id  serial primary key,
	p_name varchar(100)
	);
	
	
	
insert into l_p(p_id,p_name)
values
	(1,'computers'),
	(2,'monitors'),
	(3,'monitors'),
	(5,'keyboards')
	returning *
	
	
	
	
	
insert into r_p(p_id,p_name)
values
	(1,'computers'),
	(2,'monitors'),
	(3,'monitors'),
	(4,'pens'),
	(7,'papers')
	returning *
	
	
SELECT *
FROM L_P
LEFT JOIN R_P ON L_P.P_ID = R_P.P_ID;
	
	
	
SELECT *
FROM L_P
LEFT JOIN R_P ON L_P.P_name = R_P.P_name;
	
	
	
select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name"
from movies m left join directors d on m.director_id=d.director_id
order by d.director_id


select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name"
from  directors d left join  movies m  on m.director_id=d.director_id
order by d.director_id

insert into directors(first_name,last_name) 
values('yesasvi','t')
	
	

select 
(d.last_name ||' ' || d.first_name) "director_name",
m.movie_lang,
count(m.movie_lang)
from  directors d left join  movies m  on m.director_id=d.director_id
group by 1,2



select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name",
m.movie_lang
from  directors d left join  movies m  on m.director_id=d.director_id
where 	m.movie_lang in ('English','Chinese')
order by m.movie_lang



select 
(d.last_name ||' ' || d.first_name) "director_name",
count(movie_name)
from  directors d left join  movies m  on m.director_id=d.director_id
group by 1
order by 1
	


select 
(d.last_name ||' ' || d.first_name) "director_name",
count(*) as "toatl_movies"
from  directors d left join  movies m  on m.director_id=d.director_id
group by 1
order by 1




select
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name",
m.age_certificate,
d.nationality
from directors d left join movies m on m.director_id=d.director_id
where 	d.nationality in ('American','Chinese','Japanese')
order by d.nationality


select * from directors	

--get all the  total revenues done by  each filime 	 for each director
SELECT 

(d.last_name ||' ' || d.first_name) "director_name",

sum(r.revenues_domestic + r.revenues_international ) "Total_revenue"

FROM DIRECTORS D
LEFT JOIN MOVIES M ON M.DIRECTOR_ID = D.DIRECTOR_ID
JOIN MOVIES_REVENUES R ON M.MOVIE_ID = R.MOVIE_Id
group by 1
having  sum(r.revenues_domestic + r.revenues_international ) >0
order by 2 desc 





	

