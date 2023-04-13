--crosstab

--install the extension

create extension  if not exists tablefunc;

--to check the extensions
select * from pg_extension;



--create sample data scores

create table scores(
	
	score_id serial primary key,
	name varchar(100),
	subject varchar(100),
	score numeric(4,2),
	score_date date
);


insert into scores(name,subject,score,score_date) values
('yesasvi','math',10,'2022-01-01'),
('yesasvi','english',9,'2022-01-02'),
('yesasvi','science',7,'2022-01-03'),
('yesasvi','social',8,'2022-01-04'),

('geeta','math',9,'2022-01-01'),
('geeta','english',5,'2022-01-02'),
('geeta','science',4,'2022-01-03'),
('geeta','social',9,'2022-01-04')
 returning *;
 
 
 
--pivort table

select distinct(subject) from scores;


select * from crosstab
(

'select name,subject,score from scores'
)
as ct
(
	name varchar,
	math numeric,
	english numeric,
	science numeric,
	social numeric
	
)


--rain fall data is in movies database

select * from rainfalls;


select * from crosstab
(
	'
	select location, year, sum(raindays) from rainfalls group by 1,2 order by 1,2
	
	'
	
) as ct
(
	"Location" text,
	"2012" bigint,
	"2013"  bigint,
	"2014"  bigint,
	"2015"  bigint,
	"2016"  bigint,
	"2017"  bigint)

--matrix report via query

select 
name,
min(case when subject='math' then score end) math,
min(case when subject='english' then score end)english,
min(case when subject='science' then score end) science,
min(case when subject='social' then score end) social
from scores
group by 1
order by 1;

--aggregate over filters

select 
location,
sum(raindays) filter(where year='2012') as "2012",
sum(raindays) filter(where year='2013') as "2013",
sum(raindays) filter(where year='2014') as "2014",
sum(raindays) filter(where year='2015') as "2015",
sum(raindays) filter(where year='2016') as "2016",
sum(raindays) filter(where year='2017') as "2017"
from rainfalls
group by 1;


--sattic to dynamic pvivort



CREATE OR REPLACE FUNCTION pivotcode (
	tablename VARCHAR,
	myrow VARCHAR,
	mycol VARCHAR,
	mycell VARCHAR,
	celldatatype VARCHAR
)
RETURNS VARCHAR
LANGUAGE PLPGSQL AS
$$
	DECLARE
		
		dynsql1 VARCHAR;
		dynsql2 VARCHAR;
		columnlist VARCHAR;
		
	BEGIN
		
		-- 1 retrive list of all DISTINCT column name
			
			-- SELECT DISTINCT(column_name) FROM table_name
			
			dynsql1 = 'SELECT STRING_AGG(DISTINCT ''_''||'||mycol||'||'' '||celldatatype||''','','' ORDER BY ''_''||'||mycol||'||'' '||celldatatype||''') FROM '||tablename||';';
		
			EXECUTE dynsql1 INTO columnlist;
			
		-- 2. setup the crosstab query 
			
		dynsql2 = 'SELECT * FROM crosstab (
		 ''SELECT '||myrow||','||mycol||','||mycell||' FROM '||tablename||' GROUP BY 1,2 ORDER BY 1,2'',
		 ''SELECT DISTINCT '||mycol||' FROM '||tablename||' ORDER BY 1''
	 	)
	 	AS newtable (
		 '||myrow||' VARCHAR,'||columnlist||'
		 );';
					
		-- 3. return the query
	
		RETURN dynsql2;
		
	END
$$

select pivotcode('rainfalls','location','year','sum(raindays)','numeric');


SELECT * FROM crosstab (
		 'SELECT location,year,sum(raindays) FROM rainfalls GROUP BY 1,2 ORDER BY 1,2',
		 'SELECT DISTINCT year FROM rainfalls ORDER BY 1'
	 	)
	 	AS newtable (
		 location VARCHAR,_2012 numeric,_2013 numeric,_2014 numeric,_2015 numeric,_2016 numeric,_2017 numeric
		 );

--interactive clinte side pivort (gives the view)
--cmd
psql -h localhost -d Movies -U postgres
password:root
select location, year, sum(raindays) from rainfalls group by 1,2 order by 1,2 \crosstabview

\crosstabview year location
 
 
 
 
select location,year, sum(raindays),rank() over(order by sum (raindays))
from rainfalls 
group by 1,2 
having sum(raindays)>100
order by 3
\crosstabview year location sum rank