--text to structured data

--case formatting

select  upper('yesasvi');

select  lower('YESASVI');

SELECT INITCAP('HELLO WORLD');

SELECT INITCAP('hello world');

--character information

select char_length('yesasvi');


--removing characters
select trim(' yesasvi');

select char_length(trim(' yesasvi'));


--similar to
select 'same' similar to 'same';

select 'same' similar to 'Same';

select 'same' similar to 's';


select 'same' similar to 's%';


select 'same' similar to 'sa%';


select 'same' similar to '%s';


select 'same' similar to '%(s|a)%';

select 'same' similar to '(m|e)%';

select 'same' similar to '%(m|e)%';


select 'same' similar to 'sam_';

--posix regular expressions(BREs and EREs)

select 'same' ~'same' as result;

select 'same' ~'Same' as result;

select 'same' ~* 'Same' as result;


select 'same' ~'same' as result;

select 'same' !~ 'Same' as result;

select 'same' !~* 'Same' as result;


--substring  wit posix regular expression
--single character
select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '.');--similar to _

--all character
select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '.*');--similar to %

--any character aftrt say movie

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from 'movie.+');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from 'will.+');--will%

--one or more  word charactes from start
select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\w');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\w+');

--one or more  word charactes from end

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\w+.$');

--a.m or p.m
select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d{2}');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d{4}');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d{1,2}');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d{1,2} (a.m |p.m )');


select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from '\d{1,2} (?:a.m |p.m )');

select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from 'Nov|Dec');


select substring('The movie will  start  at 8 p.m  on Dec 10,2022.' from 'Dec \d{2},\d{4}');


--regexp_matches function
-- regexp_matches(source string,pattren[,flag]) flag g,i

--single match
select regexp_matches('Amazing #Postgresql','#');

select regexp_matches('Amazing #Postgresql','#([A-Za-z0-9_])');

select regexp_matches('Amazing #Postgresql','#([A-Za-z0-9_]+)');
--multiple matches
select regexp_matches('Amazing #Postgresql #sql','#([A-Za-z0-9_]+)','g');

select regexp_matches('XYZ','X','g');
--GROUP TO CAPTURE  PARTS OF STRING
select regexp_matches('XYZ','^(X)(..)$','g');

select regexp_matches('my cat alwas jumps around','cat|dog','g');	

select regexp_matches('1111 2222-A 3333-B 4444-C','[A-Z]','g');


select regexp_matches('1111 2222-A 3333-B 4444-C','-[A-Z]','g');


select regexp_matches('1111 2222-A 3333-B 4444-C','-?[A-Z]','g');


--regexp_replace() function
--reverse word

select regexp_replace('Yesasvi Kanyaka','(.*) (.*)','\2 \1');

--have only characte data
select regexp_replace('ABCD1234abs','[[:digit:]]','','g');

--have only numeric data
select regexp_replace('ABCD1234abs','[[:alpha:]]','','g');

--data change
select regexp_replace('2019-02-01','\d{4}','2020');

--regexp_split_to_table

select regexp_split_to_table('1,2,3,4,5',',');

select regexp_split_to_table('N B Kanyaka yesasvi',' ');

--regexp_split_to_array

select regexp_split_to_array('N B Kanyaka yesasvi',' ');

select regexp_split_to_array('N,B,Kanyaka,yesasvi',',');


select array_length(regexp_split_to_array('N B Kanyaka yesasvi',' '),1);






