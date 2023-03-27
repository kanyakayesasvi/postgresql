--limit and offset

select * from
movies
order by movie_length asc
limit 3

--offset
select * from
movies
order by movie_length asc
limit 3 offset 3


--fetch
select * from
movies
fetch first 1 row only


select * from
movies
fetch next 1 row only



select * from
movies
fetch next 1 rows only


select * from
movies
fetch first 5 row only


select * from
movies
fetch next 1 row only

--get to 3  movies from movie length using fetch
select * from
movies
order by movie_length desc
fetch first 5 row only



select * from
movies
order by movie_length desc
fetch first 5 row only
offset 3

--get to 3  movies from movie length using limit
select * from
movies 
order by movie_length desc
limit 5


