--sql function

-- create or replace  function_name() return void as
-- '
-- --sql command
-- '
-- language sql


create or replace function  fn_mysum(int,int) 
returns int as
'
	select $1 +$2;

'language sql

select fn_mysum(1,2);

select fn_mysum(15,20);

--intro to dOLLAR QUOTING

select 'I'',m  yesasvi';


create or replace function  fn_mysum(int,int) 
returns int as
$$
	select $1 +$2;

$$ language sql

select fn_mysum(1,2);


create or replace function  fn_mysum(int,int) 
returns int as
$body$
	select $1 +$2;

$body$ language sql


--return no value(void)

create or replace function fn_employees_update_country() returns void as
$$
update employees
set country='N/A'
where  country is NULL	
$$
language sql


select * from employees;

select fn_employees_update_country();

--function return a single value

 select * from products order by unit_price;
 
create or replace function  fn_product_min_price_integer()    
 returns integer as
 $$
  select min(unit_price) from products ;
 $$ language sql
 
 
create or replace function  fn_product_min_price_real()    
 returns real as
 $$
  select min(unit_price) from products ;
 $$ language sql
 
 
select fn_product_min_price_integer();

select fn_product_min_price_real();


create or replace function fn_product_max_unit_price()
returns real as
$$
	select max(unit_price) from products;

$$ language sql

select fn_product_max_unit_price();


--get the biggest order palce

create or replace function 	fn_biggest_order() returns double precision as
$$

	select max(amount) from
	(
	select  order_id ,sum(unit_price * quantity) amount
	from order_details  
	group by 1 
	order by 2 desc)as total_amt;

$$ language sql

select fn_biggest_order();

create or replace function 	fn_smallest_order() returns double precision as
$$

	select min(amount) from
	(
	select  order_id ,sum(unit_price * quantity) amount
	from order_details  
	group by 1 
	order by 2 desc)as total_amt;

$$ language sql

select fn_smallest_order();


--total count of customers

select count(customer_id) from customers;



create or replace function fn_api_get_total_customers() returns bigint as
$$
	select count(customer_id) from customers;
$$
language sql;


select fn_api_get_total_customers();



--get total product
select count(*) from products;

select count(product_id) from products;

create or replace function fn_api_get_total_products() returns bigint as
$$
select count(product_id) from products;
$$ language sql;

select fn_api_get_total_products();

--all orders

select * from orders;

select count(*) from orders;

create or replace function fn_api_get_total_orders() returns bigint as
$$
select count(*) from orders;
$$ language sql;


select fn_api_get_total_orders();

--create fun to get empty data
select * from customers;


create or replace function fn_api_total_customers_empty_fax() returns bigint as 
$$
	select count(*) from customers where fax is null
$$
language sql

select fn_api_total_customers_empty_fax()

--empty regeion


create or replace function fn_api_total_customers_empty_region() returns bigint as 
$$
	select count(*) from customers where region is null
$$
language sql

select fn_api_total_customers_empty_region();

--fun passing parameters

-- create or replace  function function_name(p1 typr,p2 type...) returns return_typre as 
-- $$
-- $$ language name





create or replace  function fn_mid(p_string varchar,p_starting_point int) returns varchar as 
$$
	select substring(p_string,p_starting_point);
$$ language sql


select fn_mid('Yesasi kanyaka',3);



--get total  customer by city

select * from customers;


create or replace function fn_api_get_total_customers_by_city(p_city varchar) returns bigint as
$$

select count(*)
from customers
where city =p_city;
$$
language sql
select fn_api_get_total_customers_by_city('London');


create or replace function fn_api_get_total_customers_by_country(p_country varchar) returns bigint as
$$

select count(*)
from customers
where country =p_country;
$$
language sql

select fn_api_get_total_customers_by_country('USA');


--get total orders by customer

select * from customers;
create or replace function fn_api_customer_total_ordres(p_customer_id varchar) returns bigint as

$$
select count(*)
from
orders
natural join customers
where customer_id=p_customer_id

$$ language sql;

select fn_api_customer_total_ordres('VINET');


--biggest order placed by a customer

select 
o.order_id,
o.customer_id,
p.product_name,
od.unit_price,
od.quantity,
((od.unit_price*od.quantity)-od.discount) as total_amount
from orders o
natural join order_details od
natural join products p
where  o.customer_id='ALFKI'
order by 1



create or replace function fn_customer_largest_order(p_customer_id bpchar) returns double precision as
$$
select max(total_amount) from(
select
o.order_id,
sum((od.unit_price*od.quantity)-od.discount) as total_amount
from order_details od
natural join orders o
where o.customer_id=p_customer_id
group by 1) as total_amount


$$ language sql


select fn_customer_largest_order('ALFKI');



--most ordered product buy custumor

select 
o.order_id,
o.customer_id,
p.product_name,
od.unit_price,
od.quantity
from orders o
natural join order_details od
natural join products p
where customer_id='CACTU'


create or replace function fn_api_customer_most_order_product(p_customer_id bpchar) returns varchar as
$$
	select product_name 
	from products 
	where product_id in 
		(select product_id from (
			select 
			p.product_id,
			sum(quantity) as total_quanity
			from orders o
			natural join order_details od
			natural join products p
			where customer_id=p_customer_id
			group by 1
			order by 2 desc
			limit 1)
as product_order)


$$ language sql


select  fn_api_customer_most_order_product('CACTU');

--return composit
create or replace 	function fn_api_order_latest() returns orders as
$$
select * from  orders order by  order_date desc,order_id desc;

$$ language sql


select fn_api_order_latest();

select (fn_api_order_latest()).*;
select (fn_api_order_latest()).order_id;

select order_id(fn_api_order_latest());


create or replace 	function fn_api_order_latest_by_date_range(p_from date,p_to date) returns orders as
$$
select * from  orders 
where order_date between p_from and p_to
order by  order_date desc,order_id desc;

$$ language sql



select (fn_api_order_latest_by_date_range('1997-01-01','2020-12-31')).*;

create or replace function fn_api_employee_latest_hire() returns employees as
$$

select * from employees 
order by hire_date desc 
limit 1
$$ language sql

select (fn_api_employee_latest_hire()).*;

--multiple rows

--empole hire in particular year

create or replace function fn_api_employee_hire_date_by_year(p_year integer) returns setof employees as
$$

select * from employees 
where extract('YEAR' FROM hire_date)=p_year

$$ language sql


select (fn_api_employee_hire_date_by_year('1992')).*;

select first_name from fn_api_employee_hire_date_by_year('1992');

select * from fn_api_employee_hire_date_by_year('1992');




-- --to get all table data

-- create or replace function fn_table_data(p_table_name varchar) returns table as
-- $$
-- 	select * from p_table_name; 
-- $$ language sql


-- function returning a tabel

--top order by cutomer

create or replace  function fn_api_customer_top_orders(p_customer_id bpchar,p_limit integer) returns 
table (
	order_id smallint,
	customer_id bpchar,
	product_name varchar,
	unit_price real,
	quanitity smallint,
	total_order double precision


) as
$$

select  
o.order_id,
o.customer_id,
p.product_name,
od.unit_price,
od.quantity,
(((od.unit_price *od.quantity)-od.discount)) as total_order
from 
order_details od 
natural join orders o  
natural join products p
where o.customer_id=p_customer_id
order by total_order desc
limit  p_limit


$$
language sql

select * from fn_api_customer_top_orders('VINET',9);


--function parameter with default

create function fn_sum_3(x int,y int default 10,z int default 20) returns integer as
$$
select x+y+z
$$ language sql

select fn_sum_3(1,2,3);
select fn_sum_3(1);



select products.unit_price,
products.unit_price*107/100
from products;



create or replace function fn_api_new_prices(products,p_percentage_increase numeric default 107)
returns double precision as
$$
select $1.unit_price *p_percentage_increase/100;
$$ language sql

select product_id,product_name,unit_price,fn_api_new_prices(products.*) from products



--function on views
create or replace view c_active_quries as
select pid, usename,query_start,(current_timestamp - query_start),query from pg_stat_activity
where state='active'
order by 4 desc;


--fun using view

create or replace function fn_internal_active_quries(p_limit int) returns setof c_active_quries as
$$
select * from c_active_quries limit p_limit
$$
language sql

select * from fn_internal_active_quries(10);















