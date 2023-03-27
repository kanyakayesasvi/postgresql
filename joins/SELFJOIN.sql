--SELF JOIN


SELECT * FROM L_P T1
INNER JOIN L_P T2 ON T1.P_ID=T2.P_ID	

--JOIN DIRECTORS TABLE
SELECT * FROM DIRECTORS T1
INNER JOIN  DIRECTORS T2 ON T1.DIRECTOR_ID=T2.DIRECTOR_ID



--LETS SELF JOIN  FINDS ALL PAIR OF MOVIES THAT HAVE SAME MOVIE LENGTH

SELECT T1.MOVIE_NAME,
T2.MOVIE_NAME,
T1.MOVIE_LENGTH
FROM MOVIES T1 INNER JOIN MOVIES T2 ON T1.MOVIE_LENGTH=T2.MOVIE_LENGTH
--AS FEW MOVIES ARE REPEATING TO AVID THS


SELECT T1.MOVIE_NAME,
T2.MOVIE_NAME,
T1.MOVIE_LENGTH
FROM MOVIES T1 INNER JOIN MOVIES T2 ON T1.MOVIE_LENGTH=T2.MOVIE_LENGTH
AND T1.MOVIE_NAME <> t2.MOVIE_NAME


--hirarchial data like directors and movies

select t1.movie_name,
t2.director_id
from movies t1 inner join movies t2 on t1.director_id=t2.movie_id
order by 2

select * from movies

select movie_name,director_id from movies
order by 2

create table employee(
emp_id int,
	emp_name varchar(100),
manager_id int

)

insert into employee(emp_id,emp_name,manager_id)
values
(1,'yesasvi',5),
(2,'geets',5),
(3,'mohan',5),
(4,'sreeya',null),
(5,'pavan',4)
returning*;

select
e1.emp_name,coalesce(e2.emp_name,'NoManager') from employee e1 left join employee e2 on e1.manager_id=e2.emp_id









