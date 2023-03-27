--in and in not

select * from movies
where movie_lang='english'
or movie_lang='telugu'
or movie_lang='tamil'

--using in operator
select * from
movies
where
movie_lang in ('english','telugu','tamil')

--in not
select * from
movies
where 
movie_lang not in ('hindi')



--between and not between

select * from
movies
where 
release_date between '2012-01-01' and '2021-12-31'
order by release_date



select * from
movies
where 
release_date not between '2012-01-01' and '2021-12-31'
order by release_date;



--like and ilike

select 'yesasvi' like 'yesasvi';

select 'yesasvi' like 'y%';

select 'yesasvi' like '%e%';

select 'yesasvi' like '%i';

select 'yesasvi' like '%sas%';


select 'yesasvi' like '_esasvi';

select 'yesasvi' like '%sv_';


select * from
movies
where movie_name like 'r%'

select * from
movies
where movie_name like 'R%'






