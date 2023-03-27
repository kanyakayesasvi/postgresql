-- decimal nu,mbers

create table table_decimal(
col_numeric numeric(20,5),
	col_real real,
	col_double double precision
)

select * from table_decimal


insert into table_decimal(col_numeric,col_real,col_double)
values
(.9,.9,.9),
(3.12345,3.12345,3.12345),
(1.1234567890,1.1234567890,1.1234567890)

returning *



insert into table_decimal(col_numeric,col_real,col_double)
values
(1.1234567891,1.1234567891,1.1234567891)