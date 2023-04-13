create table feed3
(
	Date date,
	Desk_id integer,
	Product_id integer,
	"Quantity held 0-30" integer,
	"Quantity held 30-60" integer,
	"Quantity held 60-90" integer,
	"Quantity held 90-180" integer,
	"Quantity held 180-360" integer,
	"Quantity held GT360" integer
);
create table actual_feed3
(
	Date date,
	Desk_id integer,
	Product_id integer,
	"Quantity held 0-30" integer,
	"Quantity held 30-60" integer,
	"Quantity held 60-90" integer,
	"Quantity held 90-180" integer,
	"Quantity held 180-360" integer,
	"Quantity held GT360" integer
);
select * from actual_feed3;

CREATE OR REPLACE FUNCTION load_feed3_date(feed_3 text)
RETURNS void AS $$
BEGIN
    TRUNCATE TABLE feed3;
    EXECUTE 'COPY feed3(date, desk_id, product_id, "Quantity held 0-30" ,
	"Quantity held 30-60" ,
	"Quantity held 60-90" ,
	"Quantity held 90-180" ,
	"Quantity held 180-360" ,
	"Quantity held GT360"  ) FROM ' || quote_literal(feed_3) || ' WITH (FORMAT CSV, HEADER)';
	delete from actual_feed3 where date = (select date from feed3 group by date);
	insert into actual_feed3
	select 
		date,
		desk_id,
		product_id,
		sum("Quantity held 0-30"),
		sum("Quantity held 30-60"),
		sum("Quantity held 60-90"),
		sum("Quantity held 90-180"),
		sum("Quantity held 180-360"),
		sum("Quantity held GT360")
	from feed3
	group by date,desk_id,product_id;	
END;
$$ LANGUAGE plpgsql;

select load_feed3_date('D:/udemy/sample_data/feeds/feed3_day2.csv');
select * from feed3 ;

select * from actual_feed3 order by date,desk_id;

truncate position;

create or replace function fn_feed3_position(input_date date)
returns table (
	Business_date date,
	Desk_id int,
	"Section_name(7A or 7B)" varchar(5),
	Value_held_0_30 numeric,
	Value_held_31_60 numeric,
	Value_held_61_90 numeric,
	Value_held_91_180 numeric,
	Value_held_181_360 numeric,
	Value_held_GR360 numeric
)
as
$$
begin
insert into position
select
 current_date,
 f.desk_id,
 case
	 when (sum("Quantity held 0-30")+sum("Quantity held 30-60")+sum("Quantity held 60-90")+sum("Quantity held 90-180"))+sum("Quantity held 180-360")+sum("Quantity held GT360")>0 then '7A'
	 else '7L'
 end,
 sum("Quantity held 0-30"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 30-60"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 60-90"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 90-180"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held 180-360"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) ),
 sum("Quantity held GT360"*(select pf.price from price_feed pf where pf.product_id = f.product_id and pf.business_date = input_date ) )
from  actual_feed3 f
where f.date = input_date
group by
f.desk_id;
return query
select * from position;
truncate position;
end;
$$
language plpgsql;


select * from fn_feed3_position('2023-04-02');

select * from position;

	


