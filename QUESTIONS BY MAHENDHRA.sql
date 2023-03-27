--QUESTIONS BY MAHENDRA

--To get the particular table structure using information_schema.tables,
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'actors';



--List all columns in a table
SELECT column_name FROM information_schema.columns WHERE table_name = 'actors';




--insted of upsert
--insert into if not exists 

create table example_table(
	id int,
	name varchar(30));
	
select * from example_table

INSERT INTO example_table (id, name)
values
	(1,'John'),
	(2,'doe'),
	(3,'peter');

INSERT INTO example_table (id, name)
SELECT 5, 'John1'
WHERE
    NOT EXISTS (
        SELECT id FROM example_table WHERE id = 5)
	returning *;


--checking delete returning 
DELETE FROM example_table
WHERE id=2
returning *;
	

--why ""?
-- Double quotes are used to indicate identifiers within the database,which are objects like tables, column names, and roles,names case sensitive. 
-- In contrast, single quotes are used to indicate string literals

--create a table with 2 columns name and grade,and discplay the vaues NAMES whre C,A,B,D
create table grade_table(
	name varchar(30),
	grade varchar(2)
);


INSERT INTO grade_table (name,grade)
values
	('yesasvi','A'),
	('geeta','B'),
	('sreeya','C'),
	('sreeja','D')
returning *;


SELECT name
FROM grade_table
ORDER BY 
  CASE 
    WHEN grade = 'C' THEN 0 -- first order by C grade rows 0-(which is used to sort the rows to appear at the top of the result set.)
    ELSE 1                  -- then order by other grade rows
  END, grade ;            -- finally, order by grade in ascending order
  
  
  
-- SELECT name FROM grade_table
-- ORDER BY 
--   CASE 
--     WHEN grade = 'C' THEN 1
--     WHEN grade = 'A' THEN 2
--     WHEN grade = 'B' THEN 3
--     WHEN grade = 'D' THEN 4
    
--   END, grade DESC;



--drop a primer key column
drop table test1

create table test1(
id serial primary key,
	name varchar(20)
)

insert into test1(name)
values
('yesasvi'),
('geeta'),
('sreeya'),
('pooja')
returning *;

ALTER TABLE test1
DROP COLUMN id;

select * from test1;



