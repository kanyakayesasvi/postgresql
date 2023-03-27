--upsert 

create table t_tags(
	id serial PRIMARY key,
	tag text unique,
	update_date timestamp default now()
	);

select * from t_tags
insert into t_tags(tag) values
('pen'),
('pencile')
returning *;

--on conflict do nothing

insert into t_tags(tag)
values ('pen')

on conflict(tag)
do nothing;


--if tag exist update update_date with current time
insert into t_tags(tag)
values ('pen')
on conflict(tag)
do 
update set
tag=excluded.tag,
update_date=now()
returning *;


alter table t_tags add unique(id,tag)
select * from t_tags

insert into t_tags(id,tag)
values (4,'pencil1')

on conflict(id,tag)
do 
update set
tag=excluded.tag,
update_date=now()
returning *;




