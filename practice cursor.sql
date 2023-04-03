create table yesasvi(
	name varchar(100),
	email varchar(100)
);


insert into yesasvi (name,email) values
('yesasvi','tyesasvi2001@gmail.com'),
('yesasvi','kanyaka.yesasvi@accolitedigital.com'),
('yesasvi','tyesasvi2017@gmail.com'),
('geeta','geeta2001@gmail.com'),
('geeta','geeta@gmail.com')
returning *;



create or replace function fn_get_emails_name(custom_name varchar(100))
 returns text 
 language plpgsql as
 $$
 
 	declare name_email text default '';
		
	 rec_yesasvi record;
	 
	 cur_all_names cursor (custom_name varchar(100))
	 for
	 select * from yesasvi
	 where name =custom_name;
	 
	
	begin
		open cur_all_names(custom_name);
		loop
			fetch cur_all_names into rec_yesasvi;
			exit when not found;
			
			
			if rec_yesasvi.name like '%yesasvi%' then
			name_email= name_email || rec_yesasvi.name  ||','||rec_yesasvi.email; 
			
			end if;
			
		end loop;
		close cur_all_names;
	
	return name_email;
	end;
	
 $$
 
select fn_get_emails_name('yesasvi');


















SELECT name, STRING_AGG(email, ',') as emails
FROM yesasvi
GROUP BY name;