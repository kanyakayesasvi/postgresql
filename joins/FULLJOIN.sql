--FULL JOIN
SELECT * FROM
L_P
FULL JOIN R_P
ON
L_P.P_ID=R_P.P_ID



select 
d.director_id,
m.movie_name,
(d.last_name ||' ' || d.first_name) "director_name"
from movies m FULL join directors d on m.director_id=d.director_id
order by d.director_id
