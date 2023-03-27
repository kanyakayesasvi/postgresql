--view

-- create or replace view view_name as query

select m.movie_name,
m.movie_length,
m.release_date,
m.movie_language
from movies m
where m.release_date>='1997-01-01' and movie_language='English'
order by release_date 




create or replace view v_movies_after1977 as
select m.movie_name,
m.movie_length,
m.release_date,
m.movie_lang
from movies m
where m.release_date>='1997-01-01'
order by release_date


select * from v_movies_after1977
where movie_lang='English'



select m.movie_name,
m.movie_length,
m.release_date,(d.first_name ||' '|| d.last_name) as director_name,d.nationality
from movies m inner join directors d on m.director_id=d.director_id



create or replace view v_movie_directorname as 
select m.movie_name,
m.movie_length,
m.release_date,(d.first_name ||' '|| d.last_name) as director_name,d.nationality
from movies m inner join directors d on m.director_id=d.director_id


select * from v_movie_directorname where d.nationality in ('English','Chinese','Japanese')


--using union

select a.first_name,a.last_name,  'actors' as people_type  from actors a
union all
select d.first_name,d.last_name, 'directors' as people_type  from directors d




--view using select or union  with multipe tables
create view v_all_actors_directors as
select a.first_name,a.last_name,  'actors' as people_type  from actors a
union all
select d.first_name,d.last_name, 'directors' as people_type  from directors d


select * from v_all_actors_directors order by first_name

--connect multiple tabkle with a single view
create view v_movies_directors_revenues as
select 
m.movie_id,
m.movie_name,
m.movie_length,
m.release_date,
m.movie_lang,
m.age_certificate,
d.director_id,
d.first_name,
d.last_name,
d.nationality,
r.revenues_domestic,
r.revenues_international
from movies m inner join directors d on m.director_id=d.director_id
inner join movies_revenues r on m.movie_id=r.movie_id;

select * from v_movies_directors_revenues
where age_certificate ='18'
order by movie_id;


--changing views
--can we re arrange the column to an exting view


create view v_director_name as
select first_name,last_name from directors

--delect a column from existing view--change the name or drop and create the new view
create or replace view v_director_name as
select last_name from directors
-- --cannot drop columns from view
-- SQL state: 42P16

create view v_director_name_1 as
select last_name from directors

--add a column in a view--can done using replace
create or replace view v_director_nationality as
select first_name,
last_name,nationality,date_of_birth from directors


--A regular view 
--does not store data physically 
--always give  the update data

select * from v_director_nationality;

--inserting data in to base table
insert into directors(first_name)values('view')

delete from directors where director_id=39


--updatable view with crud operation

create or replace view  vu_directors as
select first_name,last_name from directors;

--lets add data using view
insert into vu_directors(first_name) values('viewside')
returning*;

select * from directors;

--let delete data using view

delete  from vu_directors where first_name='viewside'


--uv using with checkoperations
create table countries(
	country_id serial PRIMARY key,
	country_code varchar(4),
	city_name varchar(100)
);

insert into countries(country_code,city_name)values
('us','vikkk')
returning *;


create or replace view v_countries_ind as
select * from countries where country_code='ind';

select * from countries;

select * from v_countries_ind;

INSERT INTO v_countries_ind(country_code,city_name)VALUES
('ind','guntur')
returning *;

INSERT INTO v_countries_ind(country_code,city_name)VALUES
('uk','pls')
returning *;


create or replace view v_countries_ind_check as
select * from countries where country_code='ind'
with check option;

INSERT INTO v_countries_ind_check(country_code,city_name)VALUES
('ind','vza')
returning *;


INSERT INTO v_countries_ind_check(country_code,city_name)VALUES
('uk','vza')
returning *;
-- ERROR:  new row violates check option for view "v_countries_ind_check"
-- DETAIL:  Failing row contains (10, uk, vza).
-- SQL state: 44000

update v_countries_ind_check set country_code='us' where city_name='india'
-- ERROR:  new row violates check option for view "v_countries_ind_check"
-- DETAIL:  Failing row contains (1, us, india).
-- SQL state: 44000


--using local and cassacade optopn on check
create view v_contries_v as
select * from countries where city_name like 'v%';


select * from v_contries_v;


--using view to create a view
create view v_contries_ind_v_local as
select * from v_contries_v where country_code='ind' with local check option;


select * from v_contries_ind_v_local;


INSERT INTO v_contries_ind_v_local(country_code,city_name)VALUES
('ind','vijaya');


select * from v_contries_ind_v_local;


INSERT INTO v_contries_ind_v_local(country_code,city_name)VALUES
('ind','karnataka')
returning *;

--local check options are satsfed in curreent view


--casscade check 

create view v_contries_ind_v_cascaded as
select * from v_contries_v where country_code='ind' with cascaded check option;


INSERT INTO v_contries_ind_v_cascaded(country_code,city_name)VALUES
('ind','vimala')
returning *;


INSERT INTO v_contries_ind_v_cascaded(country_code,city_name)VALUES
('ind','karnataka3')
returning *;
-- ERROR:  new row violates check option for view "v_contries_v"
-- DETAIL:  Failing row contains (15, ind, karnataka3).
-- SQL state: 44000
--cascade alwasy goes up and check all the previous virews



--materialized view(freshness,perfomancetime)
--store result of a query physically adnupdate the data periodically
-- create materialized view if not exists  view_name as  query
-- with [no] data;

--creat 
create materialized view if not exists  mv_directors as  
select  first_name,last_name from directors
with data;


--access
select * from mv_directors;

--creat materialized view with no data
create materialized view if not exists  mv_directors_nodata as  
select  first_name,last_name from directors
with  no data;

select * from mv_directors_nodata;


REFRESH MATERIALIZED VIEW mv_directors_nodata;

--check if a materilized view id populated or not
select relispopulated from pg_class where relname='mv_directors_nodata2';

create materialized view if not exists  mv_directors_nodata2 as  
select  first_name,last_name from directors
with  no data;


select * from mv_directors_nodata2;

--updating the data using MATERIALIZED VIEW

select * from  mv_directors;


insert into mv_directors(first_name) values ('dir1'),('dir2')
-- ERROR:  cannot change materialized view "mv_directors"
-- SQL state: 42809

insert into directors(first_name) values ('dir1'),('dir2')
returning *;--add data to base table


REFRESH MATERIALIZED VIEW mv_directors_nodata;--refresh the meteraillized data to get the data into view
select * from  mv_directors;


--delete data 

delete from mv_directors where  first_name='dir2'
--ERROR:  cannot change materialized view "mv_directors"
--SQL state: 42809
select * from directors

delete from directors where  first_name='dir2';


REFRESH MATERIALIZED VIEW mv_directors_nodata;

select * from mv_directors;



--refershing data in materialized views


create materialized view if not exists  mv_directors_nodata_American as  
select * from directors where nationality='American'
with  no data;

select * from mv_directors_nodata_American;



REFRESH MATERIALIZED VIEW mv_directors_nodata_American;


select * from mv_directors_nodata_American;
--concurrently llows us to update od the materilzes  view  with out locking it
REFRESH MATERIALIZED VIEW concurrently  mv_directors_nodata_American;
-- ERROR:  cannot refresh materialized view "public.mv_directors_nodata_american" concurrently
-- HINT:  Create a unique index with no WHERE clause on one or more columns of the materialized view.
-- SQL state: 55000


--concurerently must have a unique index on oits view


create unique index idx_u_mv_directors_nodata_American_director_id on mv_directors_nodata_American(director_id)

REFRESH MATERIALIZED VIEW concurrently  mv_directors_nodata_American;

--table insted of materialized viwr?---the ability to access to easy refresh it without locking evreyone else out of it


--using mv for  a website  page clicks analytics
--1.lets create  the page click table

create table page_clicks(
	rec_id serial primary key,
	page varchar(40),
	click_time timestamp,
	user_id bigint);
	
insert into page_clicks(page,click_time,user_id)
select(
case(random()*2)::int
	when 0 then 'klickanalytics.com'
	when 1 then 'clickapis.com'
	when 2 then 'google.com'
end)as page,
 now() as click_time,
 (floor(random()*(111111111-1000000 +1)+1000000))::int as user_id
from generate_series(1,10000) seq;


select * from page_clicks;
--to analyae a daily trend 

create  MATERIALIZED VIEW  mv_page_clicks_clicks as
select
	date_trunc('day', click_time) day1,
	page,
	count(*) as total_click from page_clicks  group by 1,2

REFRESH MATERIALIZED VIEW   mv_page_clicks_clicks;

select * from mv_page_clicks_clicks;

--creating chuncks of mv
--extract dat daily bases
create  MATERIALIZED VIEW  mv_page_clicks_daily as
select
	click_time as days,
	page,
	count(*) as total_click from page_clicks  where click_time >=date_trunc('day', now()) 
	and click_time< timestamp 'tomorrow'
group by 1,2;


REFRESH MATERIALIZED VIEW concurrently  mv_page_clicks_daily;

create unique index idx_u_mv_page_clicks_daily_days_page on mv_page_clicks_daily(days,page);


REFRESH MATERIALIZED VIEW concurrently  mv_page_clicks_daily;

select * from mv_page_clicks_daily;

--list of all materialized view
select oid::regclass::text from pg_class where relkind='m';

-- select c.relname as m_v_n from pg_class c where  c.relkind='m'
-- except
-- select mwk.relname from  matviews_with_no_unique_keys as mwk;























