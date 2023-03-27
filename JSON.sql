--exploring json objects


--how will reperent json in postgres
SELECT
'{"title":"the lord of the rings"}'

--cast
SELECT
'{
	"title":"the lord of the rings"
}'::json

--preserve white spaces
SELECT
'{
	"title":"the lord of the rings",
	"author":"j.r.r"
}'::jsonb

--create ous first table with jsonb datatype


create table books(
book_id serial primary key,
book_info jsonb)


INSERT INTO BOOKS(BOOK_INFO)
VALUES 
('
 {
 "title":"bookTitle1" ,
 "author":"author1"
 }
 ')
 returning *
 
INSERT INTO BOOKS(BOOK_INFO)
VALUES 
('
 {
 "title":"bookTitle2" ,
 "author":"author2"
 }
 '),
 ('
 {
 "title":"bookTitle3" ,
 "author":"author3"
 }
 '),
 ('
 {
 "title":"bookTitle4" ,
 "author":"author4"
 }
 ')
 returning *


--let use selector(->,->>)

select book_info from books

select book_info->'title' from books;

select book_info->>'title' from books;

select book_info->>'title' ,
book_info->>'author' 
from books;



select book_info->>'title' ,
book_info->>'author' 
from books
where author='author';



select book_info->>'title' ,
book_info->>'author' 
from books
where book_info->>'author' ='author1';


 
INSERT INTO BOOKS(BOOK_INFO)
VALUES 
('
 {
 "title":"bookTitle10" ,
 "author":"author10"
 }
 '),
 ('
 {
 "title":"bookTitle11" ,
 "author":"author11"
 }
 '),
 ('
 {
 "title":"bookTitle12" ,
 "author":"author12"
 }
 ')
 returning *;
 --update a record
 
 
 update books
 set book_info= book_info || '{"author":"yesasvi"}' 
 where book_info->>'author'='author10'

 
 update books
 set book_info= book_info || '{"title":"the first"}' 
 where book_info->>'author'='yesasvi'
 returning *;
 
 --add additional field
 
 update books
 set book_info= book_info || '{"Best seller":"true"}' 
 where book_info->>'author'='yesasvi'
 returning *;
 
 
 --MULTIPPLE KEY/vALUES
 
 
 update books
 set book_info= book_info || '{"category":"Science","pages":250}' 
 where book_info->>'author'='yesasvi'
 returning *;
 
--delete best sellers key/value


 
 update books
 set book_info= book_info -'Best seller' 
 where book_info->>'author'='yesasvi'
 returning *;
 
 --nessted data
 update books
 set book_info= book_info || '{"location":["india","andhra"]}' 
 where book_info->>'author'='yesasvi'
 returning *;
 
 --delet array
 
 update books
 set book_info= book_info #-'{location,1}' 
 where book_info->>'author'='yesasvi'
 returning *;

 update books
 set book_info= book_info - 'pages' 
 where book_info->>'author'='yesasvi'
 returning *;
 
 
 
--create json from tBLE

SELECT * FROM MOVIES

SELECT ROW_TO_JSON(MOVIES) FROM MOVIES

select row_to_json(t) from 
(select
movie_id,
movie_name,
release_date
from movies)as t



SELECT ROW_TO_JSON(A)::JSONB
FROM
	(SELECT DIRECTOR_ID,
			FIRST_NAME,
			LAST_NAME,
			DATE_OF_BIRTH,
			NATIONALITY,
			(SELECT JSON_AGG(X) AS ALL_MOVIES
				FROM
					(SELECT MOVIE_NAME
						FROM MOVIES
						WHERE DIRECTOR_ID = DIRECTORS.DIRECTOR_ID ) X)
		FROM DIRECTORS) AS A;


select * from director_docs

INSERT INTO DIRECTOR_DOCS(BODY)
SELECT ROW_TO_JSON(A)::JSONB
FROM
	(SELECT DIRECTOR_ID,
			FIRST_NAME,
			LAST_NAME,
			DATE_OF_BIRTH,
			NATIONALITY,
			(SELECT case count(*) when 0  then'[]' else JSON_AGG(X) end AS ALL_MOVIES
				FROM
					(SELECT MOVIE_NAME
						FROM MOVIES
						WHERE DIRECTOR_ID = DIRECTORS.DIRECTOR_ID ) X)
		FROM DIRECTORS) AS A;




select 	jsonb_array_elements(body->'all_movies') from director_docs

select 	*,jsonb_array_length(body->'all_movies')as total_movies from director_docs
order by total_movies



select j.* from director_docs,jsonb_to_record(director_docs.body) j(
director_id int,
first_name varchar(250),
last_name varchar(250),
date_of_birth date,
	nationality varchar(180))

select * from director_docs where body->'first_name'?'yesasvi'


select * from director_docs where body @> '{"director_id":1}'

--mix and match

select * from director_docs where body->>'first_name' like 'y%'


select * from director_docs where (body->>'director_id')::integer >2




select * from contacts_docs

select * from contacts_docs where body @> '{"first_name":"John"}'

EXPLAIN ANALYSE
SELECT *
FROM CONTACTS_DOCS
WHERE BODY @> '{"first_name":"John"}'


create index idx_gin_contacts_docs_body on contacts_docs using gin(body)