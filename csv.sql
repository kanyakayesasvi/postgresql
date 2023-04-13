--csv 

create table countries_iso_codes(

country_id serial primary key,
	country_name varchar(100),
	iso_code_2  varchar(2),
	iso_code_3 varchar(3),
	region varchar(200),
	sub_region varchar(200)
)




\copy countries_iso_codes(country_name,iso_code_2,iso_code_3,region,sub_region)
from 'countries_iso_codes.csv' delimiter ',' csv header;


select * from countries_iso_codes;