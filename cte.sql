--ctes
--cte can contain insert selectupdate or delete

--lets create a number of series from 1 to 10

with num as(
	select * from generate_series(1,10) as id
)
select * from num;



--list all the movies with diresctor id 1
with director1 as(
	select d.director_id,m.movie_name from movies m inner join directors d on m.director_id=d.director_id
	where d.director_id=1

)
select * from director1



with long_movies as(
	select movie_name,movie_length,(case 
									when  movie_length <100 then 'short'
									when movie_length <120 then 'medium'
									else 'long'								
									end) taken from movies 
)
select * from long_movies where taken='long'


--combine cte with a table
--lets calculate total revenues for each directoe

with  cte_director_revenue as(
	
	select d.director_id,
	sum(coalesce(REVENUES_DOMESTIC ,0)+ coalesce(REVENUES_INTERNATIONAL,0) )as total_revenues 
	from directors d  
	inner join  movies m on m.director_id=d.director_id
	inner join movies_revenues mr on m.movie_id=mr.movie_id
	group by 1
)
select dr.director_id,d.first_name,dr.total_revenues from cte_director_revenue dr 
inner join  directors d on dr.director_id=d.director_id;


--simultanious delecte insert  via cte
drop table articles;
drop table article_insert;
drop table delete_articles;
create table  articles(
	article_id serial primary key,
	title varchar(100)
);

create table delete_articles as select * from articles;




insert into articles(title) values
('yesasvi'),
('geeta'),
('sreeya') returning *;


select * from articles;

select * from delete_articles;


--delete a article it shou;d go inside de;lete articel

with cte_delecte_article as(
	
	delete from articles  where article_id=1 returning *

)insert into delete_articles select * from  cte_delecte_article;


select * from articles;
select * from delete_articles;

create table article_insert as select * from articles

with cte_article_insert as(

	delete from articles 
	returning *
)
insert into article_insert 
select * from cte_article_insert


select * from article_insert;

select * from articles;



--recursive

with recursive  series (list_num) as(
	--non recursive
	select 10
	
	
	union all
	--recursive 
	select list_num +5 from series
	where list_num +5<=50
	
	
)
select * from series;

--parent child


create table  items(
pk serial primary key,
name text not null,
parent int);



insert into items(pk,name,parent) values
(1,'vegtable',0),
(2,'fruits',0),
(3,'bannana',2),(4,'strawberry',2)
returning *;


with recursive cte_tree as(
	
	--all parent
	select 
	name,
	pk,
	1 as tree_level from items where parent=0	
	union
	--loop to get all child of each paremnt
	select 
	j.name || ' -> ' || i.name,
	i.pk,
	j.tree_level +1
	from items i join cte_tree j  on j.pk=i.parent
)
select tree_level,name from cte_tree
order by tree_level



