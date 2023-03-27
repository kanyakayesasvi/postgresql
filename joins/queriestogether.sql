select* from t1

select* from t2


select test::varchar  from t1
union
select* from t2
order by test


select * from table1
select * from table2



select * from table1
union
select * from table2
-- ERROR:  each UNION query must have the same number of columns
-- LINE 4: select * from table2
--                ^
-- SQL state: 42601
-- Character: 36


select * from l_p left join r_p on l_p.p_id=r_p.p_id

-- l_p
-- 1	"computers"
-- 2	"monitors"
-- 3	"monitors"
-- 5	"keyboards"


-- r_p
-- 1	"computers"
-- 2	"monitors"
-- 3	"monitors"
-- 4	"pens"
-- 7	"papers"


select * from l_p
union
select * from r_p
order by p_id


-- 1	"computers"
-- 2	"monitors"
-- 3	"monitors"
-- 4	"pens"
-- 5	"keyboards"
-- 7	"papers"


insert into r_p(p_id,p_name)values
(5,'board')



select * from l_p
union
select * from r_p
order by p_id

-- 1	"computers"
-- 2	"monitors"
-- 3	"monitors"
-- 4	"pens"
-- 5	"board"
-- 5	"keyboards"
-- 7	"papers"



--to get duplicate elements

select * from l_p
union all
select * from r_p
order by p_id



select (first_name ||' '|| last_name) "name",'actor' as "tablename"  from actors
union 
select  (first_name ||' '|| last_name) "d_name",'director' as "tablename"  from directors
order by "name"
--183 records remove duplicate


--combine all directors whewr nationality is english chinees japanes will all female actors


SELECT
first_name,
last_name,
date_of_birth,
'directors' as "tablename"
FROM DIRECTORS
where date_of_birth 
>'1970-12-31'
union
SELECT
first_name,
last_name,
date_of_birth,
'actors' as "tablename"
FROM actors 
where gender='F' and date_of_birth >'1970-12-31'
order by date_of_birth


--all directores and acctors first name satrts with a
SELECT
first_name,
last_name,
'directors' as "tablename"
FROM DIRECTORS
where first_name like 'A%'
union
SELECT
first_name,
last_name,
'actors' as "tablename"
FROM actors
where first_name like 'A%'



--union tab;le with different noof columns



select * from table1
union
select * from table2


select add_date,col1,col2,col3 from table1
union
select add_date,col1,col2,col3 from table2




select add_date,col1,col2,col3,null as col4,null as col5 from table1
union
select add_date,col1,col2,col3,col4,col5 from table2
order by add_date

--intersect


select * from l_p
intersect
select * from r_p
order by p_id


select (first_name ||' '|| last_name) "name" from actors
intersect 
select  (first_name ||' '|| last_name) "d_name" from directors
order by "name"

--excpept
select * from l_p
except
select * from r_p
order by p_id


select * from r_p
except
select * from l_p

