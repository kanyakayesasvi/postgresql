--intro to pl/pgsql lang;


create or replace function fn_api_products_max_price() returns bigint as
$$
begin
	return max(unit_price) from products;
end;
$$
language plpgsql


select fn_api_products_max_price();

--block structure
--decler a variBLE
-- declare
-- 	mynum integer:=1;
-- 	first_name  varchar(100):='yesasvi';
-- 	hire_date date:=now();
-- 	empvae integer;

do
$$
	declare 
		mynum integer:=1;
		first_name  varchar(100):='yesasvi';
		hire_date date:='2022-03-04';
		start_time timestamp:=now();
		empvae integer;
	begin
		raise notice 'my notice % % % % %',
				mynum,first_name,hire_date,start_time,empvae;
	
end;
$$
	
	


create or replace function fn_my_sum_2(integer,integer) returns integer as
$$
declare
	ret integer;
begin 
	ret:=$1+$2;
	return ret;
end;

$$ language plpgsql 


select fn_my_sum_2(10,40);

--declearing vairable with alias


create or replace function fn_my_sum_2_alias(integer,integer) returns integer as
$$
declare
	ret integer;
	x alias for $1;
	y alias for $2;
begin 
	ret:=x+y;
	return ret;
end;

$$ language plpgsql 

select fn_my_sum_2_alias(2,4);


--vairable initialization timming

-- select pg_sleep()
---perform  is null

DO $$


	declare
		start_time time :=now();
	begin

			Raise Notice 'starting time %',start_time;
			perform pg_sleep(2);
			Raise Notice 'starting time %',start_time;
	end;


$$ LANGUAGE PLPGSQL;



--copying data type

do $$
declare
	empl_first_name employees.first_name%type;
	products_name products.product_name%type;
	
begin
raise notice '% %' ,empl_first_name,products_name;
	
end;
$$ language plpgsql



--assign vairable form query

select * from products             into product_row limit 1;

select product_row.product_name    into product_name;

DO $$

	declare
		product_title products.product_name%type;

	begin

			select
				product_name into product_title
			 from products
			 where 
			 	product_id=1
			 limit 1;

			raise notice 'First product name is %',product_title;

	end;


$$ LANGUAGE PLPGSQL

--for whole roe set

DO $$

	declare
		row_record record;

	begin

			select
				* 
			 from products
			 into row_record
			 where 
			 	product_id=1
			 limit 1;

			raise notice 'First product name is %',row_record.product_name;

	end;


$$ LANGUAGE PLPGSQL

--create a  in out

create or replace function fn_my_sum_2_par(in x integer ,in y integer, out z  integer)as
$$
begin
		z:=x+y;
end;

$$ language plpgsql;

select fn_my_sum_2_par(1,2);




create or replace function fn_my_sum_2_par_2(in x integer ,in y integer, out z integer,out w integer)
 as $$
begin
		z:=x+y;
		w:=x*y;
end;

$$ language plpgsql;

select fn_my_sum_2_par_2(1,2);

--block and subblock

do $$
 	<<parent>>
	declare counter  integer :=0;
	begin 
		counter :=counter+1;
		raise notice 'the current value counter is %',counter;
		--another block
		declare
			counter integer:=0;
-- 			i integer:=90;
		begin 
		counter :=counter+5;
		raise notice 'the current value of subblock counter is %',counter;
		raise notice 'the current value of parent counter is %',parent.counter;
		end;
-- 		raise notice '%',i;
		end parent;
		

$$ language plpgsql


--return querey result
-- syntax
-- create or replace function fun_name() returns setof table_name as
-- $$


-- begin
-- 	return query select....
-- end;
-- $$ language plpgsql;

create or replace function fun_api_orders_lastest_top10_orders() returns setof orders as
$$
begin
	return query select * from orders order by order_date desc limit 10;
end;
$$ language plpgsql;


select * from fun_api_orders_lastest_top10_orders();



--control structue

-- if else 
 create or replace function fn_my_check(x integer default 0 ,y integer default 0) returns text as
 $$
 
 begin 
 	if x>y then
		return 'x>y';
	elsif x=y then
		return 'x=y';
	else
		return 'x<y';
	end if;
 
 end;
 
 $$ language plpgsql
 
 
select fn_my_check(2,1);
 
select fn_my_check(1,2);
 
select fn_my_check(2,2);



--using if with table
 
 create or replace function fn_api_product_category(price real) returns text  as
 $$
 
 begin 
 
 	if price >50 then return 'high';
	elsif price>25 then return 'medium';
	else return 'sweet_spot';
	
	end if;
 	
 
 end;
 
 $$ language plpgsql



select fn_api_product_category(unit_price),* from products order by unit_price desc;

	
--case statement

create or replace function fn_my_check_value(x integer default 0) returns text  as
 $$
 
 begin 
 	case x 
	when 10  then return 'value=10';
	when 20  then return 'value=20';
	else
	return 'else';
	end case;
 
 end;
 
 $$ language plpgsql
 
select fn_my_check_value(20);





create or replace function fn_api_order_ship_via(x integer default 0) returns text  as
 $$
 begin 
 	case x 
	when 1 then return 'speddy';
	when 2  then return 'united';
	when 3 then return 'fereral';
	else
	return 'no available';
	end case;
 
 end;
 
 $$ language plpgsql


select fn_api_order_ship_via(ship_via),* from orders

--searched case

do
$$	
	declare 
	total_amount numeric;
	order_type varchar(50);
	
	begin
	
	
	select 
	sum((unit_price * quantity)-discount) into  total_amount
	from order_details
	where order_id=10248;
	
	if found then
		case 
		when total_amount>200 then order_type='PLatinum';		
		when total_amount>100 then order_type='gold';
		else
		order_type='siliver';
		end case;
		raise notice 'OrderAmount, Order type % % ',total_amount,order_type;
	else raise notice 'no order found';
	end if;	
	end;
$$
language plpgsql


--loop	
do $$

declare i_counter integer=0;
begin

loop

	raise notice '%',i_counter;
	i_counter:=i_counter+1;
	exit when i_counter=10 ;
	
	
	
end loop;
end;
$$ language plpgsql


--for


do
$$


begin
	for counter in 1..10
	loop
		raise notice 'counter: %',counter;
	end loop;

end;
$$
language plpgsql




do
$$
begin
	for counter in reverse 10..1
	loop
		raise notice 'counter: %',counter;
	end loop;

end;
$$	
language plpgsql


--stepping	


do
$$


begin
	for counter in 1..10 by 2
	loop
		raise notice 'counter: %',counter;
	end loop;

end;
$$
language plpgsql


--for loop iteratoeover result set






do
$$
declare rec record;
	
begin
	for rec in 
	select order_id,customer_id from orders limit 10
	loop
	raise notice '%, %', rec.order_id,rec.customer_id;
	
	end loop;
end;
$$
language plpgsql


--print  odd numbers only
do
$$
declare i_counter integer=0;

begin
	loop
		i_counter=i_counter+1;
	exit when i_counter > 20;
	continue when mod(i_counter,2)=0;
	raise notice 'i_counter: %',i_counter;
	end loop; 
	
end;
$$
language plpgsql

--foreach
do
$$
declare
	arr1 int[] :=array[1,2];
	var int;
begin
foreach var in array arr1
loop
	raise info '%',var;
end loop;

end;
$$
language plpgsql




--foreach
do
$$
declare
	arr1 int[] :=array[1,2];
	arr2 int[] :=array[3,4,5,6,7,8];
	var int;
begin
foreach var in array arr1 || arr2
loop
	raise info '%',var;
end loop;

end;
$$
language plpgsql


--while loop

create or replace function fn_while_loop_sum_all(x integer ) returns numeric  as
 $$
 declare 
 counter integer:=1;
 sum_all integer:=0;
 
 
 begin 
 while counter <=x
 loop
 	sum_all:=sum_all+counter;
 counter:=counter+1;
 end loop;
 return sum_all;
 end;
 
 $$ language plpgsql


select fn_while_loop_sum_all(8)


--t_table

create 	or replace function fn_create_table_insert_values(x integer) returns boolean as

$$
declare
	counter integer=1;
	done boolean =false;

begin
	execute format('  create table if not exists t_tabele(id int) ');

	while counter<=x
	loop
		insert into t_tabele(id) values (counter);
		counter=counter+1;
	
	end loop;
	return done;
end;

$$
language plpgsql

select fn_create_table_insert_values(20);


select * from t_tabele;

--using query

create or replace function fn_api_products_sold_more_than_val(p_total_sales real)
returns setof products as
$$
begin
	return query 
	select * from products where product_id in 
	(select product_id from 
	
			(select product_id,sum((unit_price * quantity)*discount) as total_amount 
			from order_details 
			group by 1
			having sum((unit_price * quantity)*discount)>p_total_sales)as filter_products);
			
	if not found then
	raise exception 'product_id not foind';	
	end if;

end;

$$ language plpgsql


select * from fn_api_products_sold_more_than_val(1000);


select * from fn_api_products_sold_more_than_val(50000);



--returning a table
drop function fn_api_products_by_names
create or replace function fn_api_products_by_names(p_pattren varchar) returns table(productname varchar,unitprice real)as
$$
begin
		return query
		select product_name,unit_price from products where product_name like p_pattren;
end;

$$ language plpgsql

select * from products;

select * from  fn_api_products_by_names('C%');

--returningh next

--error handaling

do
$$

declare r record;
orderid smallint=10248;
begin
	select customer_id,order_date from orders into strict r  where order_id=orderid ;
	raise notice '%',r.customer_id;
	exception 
	when no_data_found 
	then raise exception'no data found';
	
	end;

$$ language plpgsql



--	too_many rows

do
$$
declare
r record;

begin
	select customer_id,company_name 
	from customers 
	into strict r
	where company_name like 'A%'
	limit 1;
	raise notice '%,%',r.customer_id,r.company_name;
	exception when too_many_rows then
	raise  exception 'your query returns to many rows';
end;



$$ language plpgsql;


--exception

create or replace  function  fn_div_exception(x real,y real) returns  real as
$$
declare re real;
begin
re=x/y;
return re;
exception when division_by_zero then  raise info 'division by zero';
raise info 'error %,%',sqlstate,sqlerrm;
end;

$$ language plpgsql;


select fn_div_exception(4,2);

select fn_div_exception(2,0);












































	





