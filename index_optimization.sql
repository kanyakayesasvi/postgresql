--index



create index idx_orders_order_date on orders (order_date);


select order_date,ship_city from orders

create index idx_orders_ship_city on orders (ship_city);



create index idx_orders_customer_id_order_id on orders (customer_id,order_id);


create unique index idx_u_products_product_id on products(product_id)

create index idx_u_orders_order_id_customer_id on orders (order_id,customer_id);


select * from employees


insert into employees (employee_id,first_name,last_name) values(1,'yesasvi','t')

create table t1(id serial primary key,tag text)
insert into t1(tag) values('b'),('c') returning *;

create UNIQUE index idx_u_t1_tag on t1(tag);
-- ERROR:  could not create unique index "idx_u_t1_tag"
-- DETAIL:  Key (tag)=(b) is duplicated.
-- SQL state: 23505


--all indices
select
* 
from pg_indexes


select
* 
from pg_indexes
where  schemaname='public'


--for particular table

select
* 
from pg_indexes
where  tablename='employees'



--size of indices
select pg_indexes_size('orders')

select pg_size_pretty(pg_indexes_size('orders'))

select count(*) from orders;


-- size bfr indexs and after

select count(*) from suppliers

--before
select pg_size_pretty(pg_indexes_size('suppliers'))
--16kb

--after 

create index idx_suppliers_region on suppliers (region);

select pg_size_pretty(pg_indexes_size('suppliers'));
--32kb


create unique index idx_u_suppliers_supplier_id on suppliers (supplier_id);

--list counts for all indexes

select * from pg_stat_all_indexes

--particular schema
select * from pg_stat_all_indexes where schemaname='public'

--particular table
select * from pg_stat_all_indexes where relname='orders'


--drop a indexes

drop index idx_suppliers_region;


--WHAT KIND EOF NODES SYSYTEM IS PROVIDING
SELECT* FROM PG_AM

explain select * from orders

--index scan
explain select * from orders where order_id=1;

--index only scan
explain select order_id  from orders where order_id=1;

--join node

show work_mem

explain select * from orders natural join customers

--hash index
create index idx_orders_orderdate on orders
using hash(order_date);

select * from orders order by order_date

explain select * from orders where order_date='1996-08-16' order by order_date

explain  select company_name from suppliers
order by company_name

--basisc order from ,where, select ,orderby

--explain output formate


	





