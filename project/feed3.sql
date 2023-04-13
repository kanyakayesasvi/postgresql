create table feed3
(
	"Date" date,
	"Desk_id" integer,
	"Product_id" integer,
	"Quantity held 0-30" integer,
	"Quantity held 30-60" integer,
	"Quantity held 60-90" integer,
	"Quantity held 90-180" integer,
	"Quantity held 180-360" integer,
	"Quantity held GT360" integer
);

insert into feed3
values
('2023-04-03',1,107,7,8,0,0,0,0),

('2023-04-04',1,107,9,9,0,0,0,0),

('2023-04-05',1,107,7,8,0,0,0,0),
('2023-04-05',2,109,10,8,1,0,0,0),
('2023-04-05',3,108,10,0,0,0,0,0),

('2023-04-06',1,107,9,0,0,0,0,0),
('2023-04-06',2,109,9,0,0,0,0,0),
('2023-04-06',3,108,10,0,0,0,0,0),



('2023-04-07',1,107,-2,0,0,0,0,0),
('2023-04-07',2,109,10,0,0,0,0,0),
('2023-04-07',3,108,10,0,0,0,0,0)
returning *;

insert into feed3 values 
('2023-04-07',2,109,10,0,0,0,0,0),
('2023-04-07',2,108,10,0,0,0,0,0)
returning *;


select * from price_feed;

select * from feed3
where "Date"='2023-04-06';

select * from price_feed where "Business_date" = '2023-04-07';



select 
f3."Desk_id",
f3."Date",
f3."Product_id",
(f3."Quantity held 0-30"+f3."Quantity held 30-60"+f3."Quantity held 60-90"+f3."Quantity held 90-180"+f3."Quantity held 180-360") as total,
(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' )
from feed3 f3
where "Date"='2023-04-07'

select * from feed3
delete from feed3
where  "Date"<>'2023-04-07';
update feed3 
set "Desk_id" = 1;





select * from price_feed
where  "Business_date"='2023-04-06';



insert into postion
select 
 current_date,
 f."Desk_id",
 case
	 when (sum("Quantity held 0-30")+sum("Quantity held 30-60")+sum("Quantity held 60-90")+sum("Quantity held 90-180"))+sum("Quantity held 180-360")+sum("Quantity held GT360")>0 then '7A'
	 else '7B'
 end,
 sum("Quantity held 0-30"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) ),
 sum("Quantity held 30-60"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) ),
 sum("Quantity held 60-90"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) ),
 sum("Quantity held 90-180"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) ),
 sum("Quantity held 180-360"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) ),
 sum("Quantity held GT360"*(select pf."Price" from price_feed pf where pf."Product_id" = f."Product_id" and pf."Business_date" = '2023-04-07' ) )
from feed3 f
group by 
f."Desk_id";



create or replace function fn_feed3_position(input_date date)
return table ()
as
$$
	
insert into position
select 
 current_date,
 f.desk_id,
 case
	 when (sum("Quantity held 0-30")+sum("Quantity held 30-60")+sum("Quantity held 60-90")+sum("Quantity held 90-180"))+sum("Quantity held 180-360")+sum("Quantity held GT360")>0 then '7A'
	 else '7B'
 end,
 sum("Quantity held 0-30"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 30-60"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 60-90"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 90-180"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 180-360"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held GT360"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) )
from  acutual_feed3 f
group by 
f.desk_id;

return query 

select * from position
truncate position
$$
language plpgsql;


truncate position
select * from position

select
	current_date,
	f3."Desk_id",
	case
	 when (f3."Quantity held 0-30"+f3."Quantity held 30-60"+f3."Quantity held 60-90"+f3."Quantity held 90-180"+f3."Quantity held 180-360")>0 then '7A'
	 else '7B'
	end,
 	sum("Quantity held 0-30") *(select f."Product_id",pf."Price" from price_feed pf join feed3 f on f."Product_id"=pf."Product_id" where  pf."Business_date" = '2023-04-07'),
	sum("Quantity held 30-60") *(select pf."Price" from price_feed pf join feed3 f on f."Product_id"=pf."Product_id" where pf."Business_date" = '2023-04-07'),
	sum("Quantity held 60-90") *(select pf."Price" from price_feed pf join  feed3 f on f."Product_id"=pf."Product_id" where pf."Business_date" = '2023-04-07'),
	sum("Quantity held 90-180") *(select pf."Price" from price_feed pf join feed3  f on f."Product_id"=pf."Product_id" where pf."Business_date" = '2023-04-07'),
	sum("Quantity held 180-360") *(select pf."Price" from price_feed pf join feed3 f on f."Product_id"=pf."Product_id" where pf."Business_date" = '2023-04-07'),
	sum("Quantity held GT360") *(select pf."Price" from price_feed pf join feed3 f on f."Product_id"=pf."Product_id" where pf."Business_date" = '2023-04-07')
from feed3 f3
group by f3."Desk_id",f3."Quantity held 0-30",f3."Quantity held 30-60",f3."Quantity held 60-90",f3."Quantity held 90-180",f3."Quantity held 180-360";