drop table feed2;
-- drop table actual_feed2;
create table feed2
(  		
	Trade_Date  Date,
	desk_id integer,
    Product_ID integer,
	"Buy\Sell"   varchar(5),
    Quantity numeric
);
create table Actual_Feed2
(
	Trade_Date  Date,
	desk_id integer,
    Product_ID integer,
	"Buy\Sell"  varchar(5),
    Quantity numeric
);

create or replace
function fn_load_feed2(feed_2 text)
returns text as
$$
	begin
-- 		truncate feed2;
		EXECUTE 
			'COPY feed2(
			Trade_Date,
			desk_id,
    		Product_ID,
			"Buy\Sell",
    		Quantity ) FROM ' || quote_literal(feed_2) || ' WITH (FORMAT CSV, HEADER)';
			return 'Successfully';
	end;
$$
Language plpgsql;

select fn_load_feed2('D:/udemy/sample_data/feeds/feed2day03-01-2022.csv');

update feed2
set quantity = 1 * quantity 
where "Buy\Sell" = 'Sell'

select * from feed2;


select count(*),desk_id,product_id from feed2 group by 2,3 order by 1 desc
select sum(quantity) from (select * from feed2 where desk_id = 1 and product_id =111 and "Buy\Sell" = 'Buy' order by trade_date)x group by 
select
trade_date,
desk_id,
product_id,
"Buy\Sell",
sum(quantity) as total_shares
from feed2
group by trade_date,desk_id,product_id,"Buy\Sell" 
order by desk_id,product_id,"Buy\Sell";

drop table temp1_feed2;

select * from temp1_feed2



create table temp1_Feed2(
	Trade_Date date,
	desk_id integer,
	Product_id integer,
	"Buy\Sell" varchar(5),
	"Quantity held 0-30" integer,
	"Quantity held 30-60" integer,
	"Quantity held 60-90" integer,
	"Quantity held 90-180" integer,
	"Quantity held 180-360" integer,
	"Quantity held GT360" integer
);
insert into temp1_feed2
select 
	trade_date,
	desk_id,
	product_id,
	"Buy\Sell" ,
	case
		when (current_date-trade_date) between 0 and 30 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) between 0 and 30 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q<30",
	case
		when (current_date-trade_date) between 31 and 60 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) between 31 and 60 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q<60",
	case
		when (current_date-trade_date) between 61 and 90 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) between 61 and 90 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q<90",
	case
		when (current_date-trade_date) between 91 and 180 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) between 91 and 180 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q<180",
	case
		when (current_date-trade_date) between 181 and 360 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) between 181 and 360 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q<360",
	case
		when (current_date-trade_date) >= 361 and "Buy\Sell" ='Buy'
			then sum(quantity)
		when (current_date-trade_date) >= 361 and "Buy\Sell" ='Sell'
			then -sum(quantity)
		else 0
	end as "Q>360"
from feed2
group by
	trade_date,
	desk_id,
	product_id,
	"Buy\Sell" 	
order by desk_id,product_id,"Buy\Sell";

select * from temp1_feed2;


create table temp2_Feed2(
	business_date date,
	desk_id integer,
	Product_id integer,
	"Buy\Sell" varchar(5),
	"Quantity held 0-30" integer,
	"Quantity held 30-60" integer,
	"Quantity held 60-90" integer,
	"Quantity held 90-180" integer,
	"Quantity held 180-360" integer,
	"Quantity held GT360" integer
);



insert into temp2_Feed2

select current_date,desk_id,
	product_id,
	"Buy\Sell",
	sum("Quantity held 0-30"),
	sum("Quantity held 30-60"),
	sum("Quantity held 60-90"),
	sum("Quantity held 90-180"),
	sum("Quantity held 180-360"),
	sum("Quantity held GT360")	
	from temp1_feed2 
-- 	where desk_id = 1
	group by desk_id,product_id,"Buy\Sell"
	order by "Buy\Sell";



