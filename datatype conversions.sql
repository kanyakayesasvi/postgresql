select * from movies

select 
cast ('10' as integer )




--string to date
select
cast('2022-09-01' as date)


--string to boolean

select 
cast('true' as boolean),
cast('t' as boolean),
cast('1' as boolean),
cast('false' as boolean),
cast('f' as boolean),
cast('0' as boolean)


select 
10::integer,
'2022-06-01 10:30:25.456'::timestamp,
'2022-06-01 10:30:25.456'::timestamptz,
'10 minute'::interval,
'4 hour'::interval,
'1 week'::interval,
'2 weeks'::interval,
'5 month'::interval



--explicit and implicit
select round(10,4)
as result

select round(cast(10 as numeric),4)
as result


