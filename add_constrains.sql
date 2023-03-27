create table web_links(
	link_id serial primary key,
	link_url varchar(255) not null,
	link_target varchar (20)
)

insert into web_links(link_url,link_target)
values
('https://ammazon.com','blank')


alter table web_links
add constraint unique_web_url unique(link_url)


select * from web_links

--accept onlu def or allowwed values

alter table web_links
add column is_enable varchar(2)



insert into web_links(link_url,link_target,is_enable)
values
('https://zon.com','blank','y')


alter table web_links
add check (is_enable in ('y','n'))



insert into web_links(link_url,link_target,is_enable)
values
('https://on.com','blank','q')


update web_links
set is_enable ='y'
where link_id =1
