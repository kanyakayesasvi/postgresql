--feed1
create table Feed1(
	"Date" date,
	"Desk_id"  integer,
	"Product_id" integer,
	"Quantity"	integer,
	"Amount"   numeric
);
select * from feed1;

create table Price_Feed(
		"Business_date" date,
		"Product_id" integer,
		"Price" numeric
);


create table  Desk_feed(
	"Desk_id" integer,
	"Desk_name" varchar(100),
	"Desk_date" date default now()
);


create table Postion(
	"Business_date" date,
	"Desk_id" int,
	"Section_name(7A or 7B)" varchar(5),
	"Value_held_0_30" numeric,
	"Value_held_31_60" numeric,
	"Value_held_61_90" numeric,
	"Value_held_91_180" numeric,
	"Value_held_181_360" numeric,
	"Value_held_GR360" numeric
);


insert into price_feed values
('2023-04-06',101,50),
('2023-04-06',102,30),
('2023-04-06',103,60),
('2023-04-06',104,10),

insert into price_feed values
('2023-04-07',101,50),
('2023-04-07',102,30),
('2023-04-07',103,60),
('2023-04-07',104,10),
('2023-04-07',107,30),
('2023-04-07',108,20),
('2023-04-07',109,10)
returning *;


insert into desk_feed values
(1,'D1'),
(2,'D2'),
(3,'D3')
returning *;




drop table feed1;
delete from feed1;

insert into feed1 values
('2023-04-05',1,101,50,2500),
('2023-04-05',2,102,10,300),
('2023-04-05',1,103,20,1200),
('2023-04-05',2,103,50,3000),
('2023-04-05',3,104,20,200),

('2023-04-06',1,101,40,2000),
('2023-04-06',2,102,11,330),
('2023-04-06',1,103,20,1200),
('2023-04-06',2,103,50,3000),
('2023-04-06',3,104,15,150)

returning *;

insert into feed1 values
('2022-04-03',1,101,10,5000);

truncate postion;

-- insert into Postion
-- select 
-- current_date,
-- "Desk_id",
-- case 
-- 	when sum("Amount")>0 
-- 		then '7A' 
-- 	else '7B' 
-- 	end,
-- case  
-- when current_date-"Date" between 0 and 30  then sum("Amount")
-- else 0
-- end,
-- case  
-- when  current_date-"Date" between 31 and 60 then sum("Amount")
-- else 0
-- end,
-- case  
-- when current_date-"Date" between 61 and 90 then sum("Amount")
-- else 0
-- end,
-- case  
-- when current_date-"Date" between 91 and 180 then sum("Amount")
-- else 0
-- end,
-- case  
-- when current_date-"Date" between 181 and 360 then sum("Amount")
-- else 0
-- end,
-- case  
-- when current_date-"Date" > 360 then sum("Amount")
-- else 0
-- end
-- from feed1
-- group by "Date","Desk_id"
-- returning *;

-- select * from feed1;

-- create or replace function fn_feed1_date_of_report(report_date date) 
-- returns table (desk_id integer,no_product bigint,value numeric)
-- as 
-- $$ 
-- begin
-- return query
-- select "Desk_id",count("Product_id"),sum("Amount") from feed1
-- where 
-- "Date"=report_date
-- group by "Desk_id";
-- end;
-- $$ language plpgsql;

-- -- DROP FUNCTION fn_feed1_date_of_report(date);


-- select * from fn_feed1_date_of_report('2023-04-06');

create or replace function fn_feed1_date_of_report(report_date date) 
returns void
as 
$$ 
begin
insert into Postion 
select 
	current_date,
	"Desk_id",
	case
		when sum("Amount") > 0 then '7A'
		else '7L'
	end,
	case  
		when current_date-report_date between 0 and 30  then sum("Amount")
		else 0
	end,
	case  
		when  current_date- report_date between 31 and 60 then sum("Amount")
		else 0
	end,
	case  
		when current_date-report_date between 61 and 90 then sum("Amount")
		else 0
	end,
	case  
		when current_date-report_date between 91 and 180 then sum("Amount")
		else 0
	end,
	case  
		when current_date-report_date between 181 and 360 then sum("Amount")
		else 0
	end,
	case  
		when current_date-report_date > 360 then sum("Amount")
		else 0
	end	
from feed1
where "Date" =report_date
group by "Desk_id";
end;
$$ language plpgsql;


select fn_feed1_date_of_report('2023-04-06');

select * from postion;

delete from postion; 

-- select "Desk_id",sum("Amount") from feed1
-- where "Date" = '2023-04-06'
-- group by "Desk_id";

