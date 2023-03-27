--to_date
select
to_date('2022-03-01','yyyy-mm-dd')



select
to_date('2022-03-01','yyyymmdd')



select
to_date('20220301','yyyy-mm-dd')

select
to_date('20220101','yyyymmdd')


select
to_date('03-01-2022','dd-mm-yyyy')


select
to_date('03-01-2022','yyyy-mm-dd')
-- ERROR:  date/time field value out of range: "03-01-2022"
-- SQL state: 22008


select
to_date('December 1,2002','Month DD,yyyy')

select
to_date('Dec 1,2002','Mon DD,yyyy')



SELECT TO_DATE('8th Dec,2022',

								'ddth Mon,yyyy')




--timestamp



select
to_timestamp('2022-03-01 11:02:52','yyyy-mm-dd hh:mi:ss')

select
to_timestamp('2022-03-01 11:02:52','yyyy-mm-dd hh:mi')

select
to_timestamp ('2022-03-01 11:02:52','yyyy-mm-dd hh')


SELECT TO_TIMESTAMP('2022-03-01 02:52',

								'yyyy-mm-dd ss:ms')


--formating dates

select current_timestamp


SELECT CURRENT_TIMESTAMP,
	TO_CHAR('2023-03-23 10:44:11'::timestamp,

		'yyyy-mm-dd')


SELECT CURRENT_TIMESTAMP,
	TO_CHAR('2023-03-23 10:44:11'::timestamp,

		'yyyy-mm-dd'),
	TO_CHAR('2023-03-23 10:44:11'::TIMESTAMPTZ,

		'yyyy-mm-dd'),
	TO_CHAR('2023-03-23 10:44:11-05:30'::TIMESTAMPTZ,

		'yyyy-mm-dd hh:mm:ss tz')


SELECT MOVIE_NAME,
	RELEASE_DATE,
	TO_CHAR(RELEASE_DATE,

		'fmMonth,ddth, yyyy tz')
FROM MOVIES

--date constructor

SELECT MAKE_DATE(2012,02,25)

select
make_time(11,5,6.5)

select make_timestamp(2022,01,01,11,5,6)
--makke_intervel(year,moths,weeks,days,hrs,min,sec)
--week+days=result days
select
make_interval(2022,1,1,85,10,22,2)


select
make_interval(months=>10,days=>2,mins=>4)



select
make_interval(weeks=>1)


--timestamptz
select
make_timestamptz(2022,02,15,11,41,21.2,'ist')



--date value extraction
select
extract('DAY' from current_timestamp)


--seconds since 1970-01-01 00:00:00 utc
select
extract('epoch' from current_timestamp )

select
date '20200201' +10


SELECT '20200201'::date + 10

select time '13:56:59' +interval '1 second'
--overlaps
select
(date '2022-01-01', date '2020-12-31') overlaps (date '2022-10-01', date '2020-12-01')





select
now(),
transaction_timestamp(),
statement_timestamp(),
clock_timestamp()




select timeofday()



select
age('2023-09-26','2001-09-26')


select
age(current_date,'2001-09-26')
select
age(current_date,'1975-11-12')

select
age(current_date,'1974-10-05')



select current_date-1

select current_time


-- date accuracy in epoch


SELECT AGE(timestamp '2023-09-26',timestamp '2001-09-26')

select extract(epoch from timestamptz '2023-09-26')-
	extract(epoch from timestamptz '2001-09-26') "diff in seco"


select 	(extract(epoch from timestamptz '2023-09-26')-
	extract(epoch from timestamptz '2001-09-26'))/60/60/24 "diff in hrs"


