--min max
select min(movie_length) from movies
	
	
select max(movie_length) from movies


--varchar can bve used it will arage in ass and des and retun the value
select min(movie_name) from movies


	

select max(movie_name) from movies


--greates and least

select greatest(20,30,5)

select least(20,30,5)

--same data type in list
select greatest('a','b','c','C')

select least('a','b','c','C')



select
movie_name,
movie_id,
movie_length,
greatest(movie_id,movie_length) as "greatest",
least(movie_id,movie_length) as "least"
from movies


