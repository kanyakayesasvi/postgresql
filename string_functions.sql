--functions

--upper() lower() initcap()

select upper(movie_name) as movie_name from movies;


select lower(movie_name) as movie_name from movies;

select initcap('hello world')


--left() right ()

select left('yesasvi',4)
--return all the charactes except last 2
select left('yesasvi',-2);



select right('yesasvi',4)
select right('yesasvi',-4)


--revers()
select reverse('yesasvi')

--spilt_part->only works on strings
split_part(string,delimiter, position)


select split_part('1,2,3',',',2)

select split_part('one,thre,four',',',2)

select split_part('a|b|c','|',3)


select * from movies

select movie_name,release_date,
split_part(release_date::text, '-' ,1)
as release_year 
from movies;



--trim ,btril,ltirm,rtrim



--lpad, rpad

select lpad('database',15,'*')

select rpad('database',15,'*')


select lpad('1111',6,'a')

select rpad('*',5+2,'*')


--length


select length('yesasvi')

select length(cast(12345 as text ))

select char_length('')
select length('')

select length(null)


--postion

select position('yesasvi'in 'yesasvi works for accolite');


select position ('a' in 'yesasvi');

--strops	--string postion
select  strpos('hello world','world')

--substring
select 	substring('have a good day' from 1 for 4)

select 	substring('have a good day' from 8 for 10) 

select 	substring('have a good day'  for 10) 

--repeat
select repeat('a',4)


--replace
select replace ('yesasvi','s','1')



