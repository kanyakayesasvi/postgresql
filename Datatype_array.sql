--array

--name varchar[] 

create table table_array(
	id serial,
	name varchar(32),
	phone text[]

)


insert into table_array(name,phone)
values
('mohan',array['99668574','547893214']),
('geeta',array['9966855274','5478973214']),
('sreeya',array['99668574','547893214'])
returning *;



select 
name,
phone[1]
from table_array




select 
name
from table_array
where
phone[1]='99668574'