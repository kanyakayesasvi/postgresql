--is null not null

select * from
movies
where
dirctor_id is NULL;





select * from
movies
where
dirctor_id is not NULL;

--concatinating
select concat_ws(',',movie_id,movie_name) as "Concatiatng " from 
movies
