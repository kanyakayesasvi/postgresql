--operators

select * from movies
--logical operators
--using where clause
select * from movies
where
movie_lang='english' 
;

--using and
select * from movies
where
movie_lang='telugu' 
and
age_certificate='13';

--using or
select * from movies
where
movie_lang='english' 
or
age_certificate='13';

--using and and or
select * from movies
where
(movie_lang='telugu' 
or
movie_lang='hindi')
and
age_certificate<='15';




--can we use where before from
--where should after from else synthax error


--can we use where after orderby
--cannot be used
select *from movies
where age_certificate='13'
order by movie_lang



--comparison operators


select * from movies
where
movie_length>=100;



select * from movies
where
movie_length<300;

--while working with dates
--give date formate in tyable yyyy-mm-dd

select * from
movies
where release_date >'2020-12-01'
order by release_date

--using txt types
select * from movies
where
movie_lang>'english'


--not eaual <> !=
select * from movies
where
movie_lang<>'english'


select * from movies
where
movie_lang !='english'


