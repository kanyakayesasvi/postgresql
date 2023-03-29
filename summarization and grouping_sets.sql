--summarizaTION

drop table courses;

create  table courses(
	course_id serial primary key,
	course_name varchar(100) not null,
	course_level varchar(100)	not null,
	sold_unit int not null
);


insert into courses (course_name,course_level,sold_unit) values
('ml with python','Premium',100),
('Data Science bootcamp','Premium',50),
('intro to python','Basic',200),
('understanding mongo db','Premium',100),
('Algo desin  python','Premium',200);


select * from courses;

select * from courses
order by course_level,sold_unit;


SELECT 
	COURSE_NAME,
	COURSE_LEVEL,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 1,2




SELECT 
	COURSE_LEVEL,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 1


SELECT 
	
	COURSE_LEVEL,
	COURSE_NAME,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 1,2
order by 1,2


--rollup --creat group sets for basic and premuim on whole
SELECT 
	
	COURSE_LEVEL,
	COURSE_NAME,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 
rollup(1,2)
order by 1,2

--partial rool up
SELECT 
	
	COURSE_LEVEL,
	COURSE_NAME,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 
rollup(1,2)
order by 1,2



SELECT 
	
	COURSE_LEVEL,
	COURSE_NAME,
	sum(SOLD_UNIT) total_sold
FROM COURSES
group by 1,
rollup(2)
order by 1,2




--ADDING SUBTOTALS WITH ROLLUP

create table inventory(
	inventory_id serial PRIMARY key,
	category varchar(100) not null,
	sub_category varchar(100) not null,
	product varchar(100) not null,
	quantity int
);

select * from inventory;

insert into inventory (category,sub_category,product,quantity) values
('Furniture','Chair','Black',10),
('Furniture','Chair','Brown',10),
('Furniture','Desk','Blue',10),
('Equipment','Computer','Mac',5),
('Equipment','Computer','PC',5),
('Equipment','Monitor','Dell',10)
returning *;


select * from inventory;

--lets group the data by category sub category

select 
category,
sum(quantity) "Quantity"
from 
inventory
group by 1;



select 
category,
sub_category,
sum(quantity) "Quantity"
from 
inventory
group by 1,2


--sub total for echa category


select 
category,
sub_category,
sum(quantity) "Quantity"
from 
inventory
group by
rollup(1,2)
order by 1,2

--using groupingf with roll up

--grouping() alwasy return 0 or 1



select 
category,
sub_category,
sum(quantity) "Quantity",
grouping(category) as "category grouping",
grouping(sub_category) as "sub_category grouping"
from 
inventory
group by
rollup(1,2)
order by 1,2


select 
coalesce(category,'') as "Category",
coalesce(sub_category,'') as "Sub_Category",
sum(quantity) as "Quantity",
case 
when grouping(category) = 1 then 'grand total' else  ' '

end as "SubTottal/Total"
from 
inventory
group by
rollup(category,sub_category)
order by category,sub_category





select 
case
	when grouping(category) = 1 then 'grand total' 
	when grouping(sub_category) = 1 then 'sub total' 
	else
		coalesce(category,'') 
end as "Category",
coalesce(sub_category,'') as "Sub_Category",
sum(quantity) as "Quantity"
from 
inventory
group by
rollup(category,sub_category)
order by category,sub_category






























