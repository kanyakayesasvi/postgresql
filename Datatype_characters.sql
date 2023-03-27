--character data types

--character(n),char(n) if we do not provide the length the default value is 1
select cast('yesasvi' as character) as "Name"

select cast('yesasvi' as character(10)) as "Name"

--"yesasvi   "-->blank padded (got extra space to leth the length 10)


select 'Yesasvi'::char(10) as "Name";
--"Yesasvi   "


--character  varying(n), varchar(n)


select 'yesasvi'::varchar(10);
--"yesasvi"

select 'yesasvi 123'::varchar(15);
--"yesasvi 123"

--text:unlimited length(1gb) , not part of sql

select 
'So three types corrector or char, you have watcha and then you have a tax.lagiri here.'::text as name1


create table table_characters(
col_char char(10),
col_varchar varchar(10),
col_text text
)

insert into table_characters(col_char,col_varchar,col_text)
values
('abc','abc','abc')
returning *;