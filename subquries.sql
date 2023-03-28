--SUBQUERIES

--FILTERING WITH WHERE CLAUS



SELECT 
MOVIE_NAME,
MOVIE_LENGTH
FROM MOVIES
WHERE MOVIE_LENGTH >(SELECT AVG(MOVIE_LENGTH) FROM MOVIES)
ORDER BY MOVIE_LENGTH;









SELECT MOVIE_NAME,
	MOVIE_LENGTH
FROM MOVIES
WHERE MOVIE_LENGTH >
		(SELECT AVG(MOVIE_LENGTH)
			FROM MOVIES
			WHERE MOVIE_LANG = 'English')
ORDER BY MOVIE_LENGTH;


--get first lastname of all actor who are younger then douglas siva

SELECT FIRST_NAME,
	LAST_NAME,
	DATE_OF_BIRTH
FROM ACTORS
WHERE DATE_OF_BIRTH >
		(SELECT DATE_OF_BIRTH
			FROM ACTORS
			WHERE FIRST_NAME = 'Douglas');
			
--subquries with in
--fing all movies domestic revenuse are greater than 200


SELECT MOVIE_NAME,
	MOVIE_LANG,
	MOVIE_ID
FROM MOVIES
WHERE MOVIE_ID in
		(SELECT MOVIE_ID
			FROM MOVIES_REVENUES
			WHERE REVENUES_DOMESTIC > 200)
			
--fing all movies domestic revenuse are greater than international revenue

SELECT MOVIE_NAME,
	MOVIE_LANG,
	MOVIE_ID
FROM MOVIES
WHERE MOVIE_ID in
		(SELECT MOVIE_ID
			FROM MOVIES_REVENUES
			WHERE REVENUES_DOMESTIC > REVENUES_INTERNATIONAL)




--subquries with join
--list all the directorss where  their movies  made more than  the avg  total revenue af all eng movies

SELECT D.DIRECTOR_ID,
	(D.FIRST_NAME || ' ' || D.LAST_NAME) DIRECTOR_NAME,
	sum(MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) AS TOTAL_REVENUES
	
FROM DIRECTORS D
INNER JOIN MOVIES M ON D.DIRECTOR_ID = M.DIRECTOR_ID
INNER JOIN MOVIES_REVENUES MR ON MR.MOVIE_ID = M.MOVIE_ID
WHERE (MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) >
		(SELECT AVG(REVENUES_DOMESTIC + REVENUES_INTERNATIONAL) AS AVG_TOTAL_REVENUES
			FROM MOVIES_REVENUES  )
group by 1
ORDER BY 1



SELECT D.DIRECTOR_ID,
	(D.FIRST_NAME || ' ' || D.LAST_NAME) DIRECTOR_NAME,
	sum(MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) AS TOTAL_REVENUES

	
FROM DIRECTORS D
INNER JOIN MOVIES M ON D.DIRECTOR_ID = M.DIRECTOR_ID
INNER JOIN MOVIES_REVENUES MR ON MR.MOVIE_ID = M.MOVIE_ID
WHERE (MR.REVENUES_DOMESTIC + MR.REVENUES_INTERNATIONAL) >
		(SELECT AVG(REVENUES_DOMESTIC + REVENUES_INTERNATIONAL) AS AVG_TOTAL_REVENUES
			FROM MOVIES_REVENUES mr inner join movies m on mr.movie_id = m.movie_id where m.movie_lang='English')
group by 1
ORDER BY 1




--order  entries  in a  union without oder by
select * from (
select first_name,0 myorder,'actor' as tablename  from  actors
union
select first_name ,1,'director' as tablename from directors
) t order by myorder

--subbquries as alias
select * from (select * from movies) t


--a select without from

 select * from movies;
 
 
SELECT
	(SELECT MAX(REVENUES_DOMESTIC)
		FROM MOVIES_REVENUES)
		
		
	
SELECT
	(SELECT MIN(REVENUES_DOMESTIC)
		FROM MOVIES_REVENUES),
	(SELECT MAX(REVENUES_DOMESTIC)
		FROM MOVIES_REVENUES),
	(SELECT AVG(REVENUES_DOMESTIC)
		FROM MOVIES_REVENUES)
		
--coorelated subquries



select
m.movie_name,
m.movie_lang,
m.movie_length,
m.age_certificate
from 
movies m
where m.movie_length >(select min(m2.movie_length) from movies m2 where m.age_certificate = m2.age_certificate ) 
order by 3
	  
	  

	  
	  
	  
	  
	  
	  
	  
