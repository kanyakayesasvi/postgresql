--stored procedure

--create a tranaction




create table t_account(
	recid serial primary key,
	name varchar not null,
	balance dec(15,2) not null
		);
insert into t_account(name,balance) values
	('Adam',100),
	('Linda',100)returning *;
		
--create a procedure money transfer

create or replace  procedure pr_money_transfer(sender int,
	reciver int,
	amount dec)
	as
	$$
	begin 
		update t_account 
		set  balance=balance - amount
		where recid=sender;
		
		update t_account 
		set  balance=balance + amount
		where recid=reciver;
		commit;
		
	end;
	
	$$  language plpgsql
	
call pr_money_transfer(1,2,100);
	
select * from t_account;
	
	
--returning vakue in stored procedure (inout parameter_mode)

create  or replace  procedure pr_orders_count(inout total_count integer  default 0) as 
$$

	begin
		select count(*) into total_count from orders; 
	end;

$$ language plpgsql

call pr_orders_count();
	
--drop a procedure

drop procedure 
	