--
drop table p1
drop table p2
create table p1(
	id int,
	name varchar(133))


create table p2(
	id int,
	name varchar(133))


insert into p2(id,name)
values
(1,'yesasvi'),
(2,'geeta'),
(3,'sreeya'),
(5,'mohan')
returning *;



insert into p1(id,name)
values
(1,'yesasvi'),
(2,'geeta'),
(3,'sreeya'),
(4,'jayjanth'),
(5,'pavan')
returning *;

select id,name
from p1
union
select id,name
from p2

select id,name
from p1
union all
select id,name
from p2

select id,name
from p1
intersect
select id,name
from p2



select id,name
from p1
except
select id,name
from p2





select id,name
from p2
except
select id,name
from p1

select id from p1
except
select id from p2 



select * from p1 
where id in
(select id from p2 );

select * from p1 
where (id) not in
(select (id) from p2 );

select * from p1 
where  not exists
(select * from p2 where p1.id=p2.id);

select * from p1 left join p2 on p1.id=p2.id
where p2.id is null;

select * from p2 right join p1 on p1.id=p2.id
where p2.id is null;




select 
COALESCE(p2.id, p1.id) AS id, 
p2.id,
p1.name,
p2.name
from p1 full outer join p2 on p1.id=p2.id


select 
*
from p2 full outer join p1 on p1.id=p2.id;



select * from p1 left join p2 on p1.id=p2.id
union 
select * from p1 right join p2 on p1.id=p2.id






