--inner join

SELECT *
FROM MOVIES;

SELECT *
FROM DIRECTORS


--common column is dirsctors.director_id=movies.director_id


SELECT D.FIRST_NAME,
	M.MOVIE_NAME,
	M.MOVIE_ID
FROM DIRECTORS AS D
INNER JOIN MOVIES AS M ON D.DIRECTOR_ID = M.DIRECTOR_ID



SELECT D.FIRST_NAME,
	M.MOVIE_NAME,
	M.MOVIE_ID,
	M.MOVIE_LANG
FROM DIRECTORS AS D
INNER JOIN MOVIES AS M ON D.DIRECTOR_ID = M.DIRECTOR_ID
WHERE M.MOVIE_LANG = 'English'
order by 3




SELECT D.*,
	M.*
FROM DIRECTORS AS D
INNER JOIN MOVIES AS M ON D.DIRECTOR_ID = M.DIRECTOR_ID


--having same column name in both table we can use using key word to join

SELECT D.FIRST_NAME,
	D.DIRECTOR_ID,
	M.MOVIE_NAME,
	M.MOVIE_ID
FROM DIRECTORS AS D
INNER JOIN MOVIES AS M USING (DIRECTOR_ID)
ORDER BY 2;


SELECT *
FROM MOVIES
INNER JOIN DIRECTORS USING (DIRECTOR_ID)
ORDER BY MOVIES.DIRECTOR_ID



SELECT *
FROM MOVIES
INNER JOIN MOVIES_REVENUES USING(MOVIE_ID)



--connecting more that 2 tables

--movies and directo   director_id
---movies movies_revens  movie_id



SELECT *
FROM MOVIES_REVENUES
INNER JOIN MOVIES USING(MOVIE_ID)
INNER JOIN DIRECTORS USING (DIRECTOR_ID)




--USING MORE FILLTERS
SELECT M.MOVIE_NAME,
	D.FIRST_NAME,
	MR.REVENUES_DOMESTIC,
	M.MOVIE_LANG
FROM MOVIES_REVENUES MR
INNER JOIN MOVIES M ON M.MOVIE_ID = MR.MOVIE_ID
INNER JOIN DIRECTORS D ON M.DIRECTOR_ID = D.DIRECTOR_ID
WHERE M.MOVIE_LANG = 'Japanese'


SELECT M.MOVIE_NAME,
	D.FIRST_NAME,
	MR.REVENUES_DOMESTIC,
	M.MOVIE_LANG
FROM MOVIES_REVENUES MR
INNER JOIN MOVIES M ON M.MOVIE_ID = MR.MOVIE_ID
INNER JOIN DIRECTORS D ON M.DIRECTOR_ID = D.DIRECTOR_ID
WHERE M.MOVIE_LANG in ('English','Chinese','Japanes')
AND MR.REVENUES_DOMESTIC > 100
order by MR.REVENUES_DOMESTIC


SELECT M.MOVIE_NAME,
	D.FIRST_NAME,
	MR.REVENUES_DOMESTIC,
	MR.REVENUES_INTERNATIONAL,
	(MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) "Total_Revenue"
FROM MOVIES M
INNER JOIN DIRECTORS D USING(DIRECTOR_ID)
INNER JOIN MOVIES_REVENUES MR ON M.MOVIE_ID = MR.MOVIE_ID
ORDER BY 5 DESC NULLS LAST
LIMIT 5




SELECT M.MOVIE_NAME,
	D.FIRST_NAME,
	MR.REVENUES_DOMESTIC,
	MR.REVENUES_INTERNATIONAL,
	(MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) "Total_Revenue",
	M.RELEASE_DATE
FROM MOVIES M
INNER JOIN DIRECTORS D USING(DIRECTOR_ID)
INNER JOIN MOVIES_REVENUES MR ON M.MOVIE_ID = MR.MOVIE_ID
WHERE M.RELEASE_DATE BETWEEN '2005-01-01' AND '2008-12-31'
ORDER BY 5 DESC
LIMIT 10




--how to inner join tables with different  column datatypes

CREATE TABLE T1 (TEST int);


DROP TABLE T2
CREATE TABLE T2(TEST VARCHAR(10));


SELECT *
FROM T1
INNER JOIN T2 USING(TEST)
-- ERROR:  JOIN/USING types integer and character varying cannot be matched
-- SQL state: 42804


--to over come the above error we can use cast

SELECT *
FROM T1
INNER JOIN T2 ON T1.TEST = T2.TEST::int


SELECT *
FROM T1
INNER JOIN T2 ON CAST(T1.TEST AS varchar) = T2.TEST



INSERT INTO T1(TEST)
VALUES
(1),
(2),
(3);


INSERT INTO T2(TEST)
VALUES
('1'),
('2'),
('3');

SELECT * FROM T1;
SELECT * FROM T2;






--group by
select
director_id,
count(movie_length)
from movies
group by director_id
order by director_id





--group by

SELECT D.FIRST_NAME,
	M.DIRECTOR_ID,
	COUNT(M.MOVIE_LENGTH)
FROM MOVIES M
INNER JOIN DIRECTORS D USING(DIRECTOR_ID)
GROUP BY 1,2
ORDER BY 2









