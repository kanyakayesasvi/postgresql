create table Feed1(
	Date date,
	Desk_id  integer,
	Product_id integer,
	Quantity	integer,
	Amount  numeric
);
create table Actual_Feed1(
	Date date,
	Desk_id  integer,
	Product_id integer,
	Quantity	integer,
	Amount  numeric
);
-- create or replace 
-- function fn_load()
-- returns void 
-- as
-- $$
-- begin
-- 	delete from actual_feed1 where date = '2023-04-01';
-- 	insert into actual_feed1
-- 	select * from feed1;
-- end;
-- $$
-- Language plpgsql

select fn_load();
select * from feed1;
select * from actual_feed1;

-- create or replace 
-- function load_feed1_date(feed_1 text)
-- returns void as 
-- $$
-- 	begin
-- 		truncate feed1;
-- 		copy feed1(date,desk_id,product_id,quantity,amount) from feed_1 delimiter ',' csv header;		
-- 	end;
-- $$
-- Language plpgsql;

CREATE OR REPLACE FUNCTION load_feed1_date(feed_1 text)
RETURNS void AS $$
BEGIN
    TRUNCATE TABLE feed1;
    EXECUTE 'COPY feed1(date, desk_id, product_id, quantity, amount) FROM ' || quote_literal(feed_1) || ' WITH (FORMAT CSV, HEADER)';
-- 	delete from actual_feed1 where date = (select date from feed1 group by date);
-- 	insert into actual_feed1
-- 	select date,desk_id,product_id,sum(quantity),sum(amount) 
-- 	from feed1 
-- 	group by date,desk_id,product_id;	
END;
$$ LANGUAGE plpgsql;

truncate feed1,actual_feed1;

select load_feed1_date('D:/udemy/sample_data/feeds/feed1day1.csv');
select * from feed1 order by desk_id,product_id;
select * from actual_feed1 order by date,desk_id;


create table Position(
	Business_date date,
	Desk_id int,
	"Section_name(7A or 7B)" varchar(5),
	Value_held_0_30 numeric,
	Value_held_31_60 numeric,
	Value_held_61_90 numeric,
	Value_held_91_180 numeric,
	Value_held_181_360 numeric,
	Value_held_GR360 numeric
);
drop function fn_feed1_position(date);
create or replace function fn_feed1_position(report_date date,input_desk_id integer)
returns table 
(	
	B_date date,
	D_id int,
	"S_name(7A or 7B)" varchar(5),
	V_held_0_30 numeric,
	V_held_31_60 numeric,
	V_held_61_90 numeric,
	V_held_91_180 numeric,
	V_held_181_360 numeric,
	V_held_GR360 numeric
)
as
$$
begin
--actual table insertion
delete from actual_feed1 where date = (select date from feed1 group by date);
insert into actual_feed1
	select date,desk_id,product_id,sum(quantity),sum(amount) 
	from feed1 
	group by date,desk_id,product_id;
--postition table insertion
insert into Position
select
	current_date,
	Desk_id,
	case
		when sum( Amount ) > 0 then '7A'
		else '7L'
	end,
	case
		when current_date-report_date between 0 and 30  then sum( Amount )
		else 0
	end,
	case
		when  current_date- report_date between 31 and 60 then sum( Amount )
		else 0
	end,
	case
		when current_date-report_date between 61 and 90 then sum( Amount )
		else 0
	end,
	case
		when current_date-report_date between 91 and 180 then sum( Amount )
		else 0
	end,
	case
		when current_date-report_date between 181 and 360 then sum( Amount )
		else 0
	end,
	case
		when current_date-report_date > 360 then sum(Amount)
		else 0
	end	
from actual_feed1
where Date =report_date
group by  Desk_id ;


return query
select * from position
where desk_id = input_desk_id;
truncate position;
end;
$$ language plpgsql;

select (fn_feed1_position('2023-04-03',5)).*;

select * from position;
------------------------------


 
