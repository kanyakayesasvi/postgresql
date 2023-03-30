--triggers

drop table players
drop table playersaudits
create table players(
	player_id serial PRIMARY key,
	name varchar(100)
);


--player_audit it will have all the changes
create table playersaudits(
	player_audit_id serial primary key,
	player_id int not null,
	name varchar(100) not null,
	edit_date timestamp not null
);

--let create function

create or replace function fn_players_name_changes_log()
returns trigger 
language plpgsql as
$$
begin
	if new.name <> old.name
	then  
	insert into playersaudits(player_id,name,edit_date)
	values(
		old.player_id,
		old.name,
		now());
	end if;
	return new;
end;
$$


create trigger trg_players_name_changes
before update on players
for each row
execute procedure fn_players_name_changes_log();

--inseting data

insert into players(name) values
('Adam'),('yesasvi') returning *;


update players  set name='yeshu2'
where player_id=2;


select * from playersaudits;
select * from players;


--modify data at insert event

create table t_temp_log
(	id_temp_log serial primary key, add_date timestamp,temprature numeric	);

--fun to creaet data

create or replace function fn_temp_value_check_at_insert()
returns trigger
language plpgsql
as
$$
	begin
		--temp<-30:temp=0
		if new.temprature < -30 then
		new.temprature:=0;
		raise notice 'temp is changed to 0';
		end if;
		return new;
		
	end;
$$

create or replace trigger trg_temp_value_check_at_insert
before insert on t_temp_log 
for each row
execute procedure fn_temp_value_check_at_insert();

insert into t_temp_log(add_date,temprature) values
('2022-06-04',55);



select * from t_temp_log;




--view  trigger  variables
--disalowing delete

create table test_delete(
	id int

);

insert into test_delete (id) values (1),(2);
--create genric cancle  function

create or replace function fn_genric_cancle_op()
returns  trigger
language plpgsql
as
$$
	begin
		if TG_when='AFTER' then
			 raise exception 'your not allowed to  % row  in %.%',TG_OP,TG_TABLE_SCHEMA,TG_TABLE_NAME;
		End if;
		RAISE NOTICE  '% ON ROWS  IN %.%  WONT HAPPEN',TG_OP,TG_TABLE_SCHEMA,TG_TABLE_NAME;
		RETURN NULL;
	end;
$$

--LET BIND THE FUN AFTER FUNCTION AFTER DELETE

create or replace trigger  trg_disallow_delete
AFTER delete 
on test_delete
for each row
execute procedure fn_genric_cancle_op();

select * from test_delete;

delete from test_delete where id=1;



--before

create or replace trigger  trg_skip_delete
before delete 
on test_delete
for each row
execute procedure fn_genric_cancle_op();


delete from test_delete where id=1;



--diallowing a truncate


create trigger trg_disallow_truncate
after truncate
on  test_delete
for each statement
execute  procedure  fn_genric_cancle_op();

truncate test_delete;



--creating audit triger

create table audit(
	id int
);

create table audit_log(
	
	username text, 
	add_time timestamp,
	table_name text,
	operation text,
	row_before json,
	row_after json

);



create or replace function fn_audit_triger()
returns trigger
language plpgsql as
$$
declare 
	old_row json=null;
	new_row json=null;
	
begin
	--tg_op
	
	
	--updat,delete
		--old_row
		if TG_OP in('UPDATE','DELETE') then
			old_row=row_to_json(old);
		end if;
		
	--insert, update
			--new_row
		if TG_OP in ('INSERT','UPDATE') then
		new_row=row_to_json(new);
		
		end if;
			
-- 	insert audit_log
			insert into audit_log(
					
					username, 
					add_time,
					table_name,
					operation,
					row_before,
					row_after
			)values
			(
				session_user,
				current_timestamp at time zone 'utc',
				TG_TABLE_SCHEMA || '.'|| TG_TABLE_NAME,
				TG_OP,
				old_row,
				new_row			
			);
			
	
	return new;
end;
$$


create or replace trigger trg_audit_trigger
after insert or update or delete on
audit
for each row
execute procedure fn_audit_triger();



select * from audit;
select * from audit_log;



insert into audit (id) values (1);

insert into audit (id) values (2);

delete from audit where id=1;

update audit set id=100 where id=1;

--trigger on conditions

create table mytask(
	id serial  primary key,
	task text
)


create or replace function fn_cancle_message()
returns trigger
language plpgsql as
$$

	begin
		raise exception '%',TG_ARGV[0];
		
		return null;
	end;
$$


create or replace trigger trg_no_update_on_friday_afernoon
before insert or delete or truncate
on mytask
for each statement
when 
(
	extract('DOW' from current_timestamp)=4
	and current_time>'21:00'
)
execute procedure fn_cancle_message('No update are allowed at Thursday');


select * from mytask;

insert into mytask(task) values('yesasvi');

--diswoll data to change on pk

create table pk_key(
	id serial primary key,
	t text
);


create or replace function fn_genric_cancle_op()
returns  trigger
language plpgsql
as
$$
	begin
		if TG_when='AFTER' then
			 raise exception 'your not allowed to  % row  in %.%',TG_OP,TG_TABLE_SCHEMA,TG_TABLE_NAME;
		End if;
		RAISE NOTICE  '% ON ROWS  IN %.%  WONT HAPPEN',TG_OP,TG_TABLE_SCHEMA,TG_TABLE_NAME;
		RETURN NULL;
	end;
$$


create or replace trigger trg_disaollw_clm_change
AFTER update of id on pk_key
for each row
execute procedure fn_genric_cancle_op();

select * from pk_key;

insert into pk_key(t) values('yesasvi');

update pk_key set id=10
where id=1;

--event triggeres
-- create event trigger 
--returns event_trigger
--crate a n audit trail event trigger

create table audit_ddl(
	audit_ddl_id serial primary key,
	username text,
	ddl_event text,
	ddl_command text,
	ddl_add_time timestamptz
);

create or replace function fn_evnt_auidit_ddl()
returns event_trigger
language plpgsql
security definer
as 
$$

	begin
		insert into audit_ddl
		(
		username,
		ddl_event,
		ddl_command,
		ddl_add_time	
		)values
		(
			session_user,
			TG_EVENT,
			TG_TAG,
			now());
		raise notice 'ddl activity is added';
	end;
$$;


create or replace event trigger trg_event_audit_ddl
on ddl_command_start
execute procedure fn_evnt_auidit_ddl();


create event trigger trg_event_audit_ddl
on ddl_command_start
when tag in ('create table')
execute procedure fn_evnt_auidit_ddl();
	
select * from audit_ddl


create table audit_ddl_test(
i int
);


drop event trigger trg_event_audit_ddl








