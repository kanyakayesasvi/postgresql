create table opening_pairs(
    team_name varchar(20),
    player_name varchar(20));

insert into opening_pairs values('India','Rahul'),('India','Rohit'),
('Australia','Khwaja'),('Australia','Warner'),
('South Africa','De Kock'),('South Africa','Miller');

insert into opening_pairs values ('India','C') returning *;

select op1.team_name,min(op1.player_name),max(op2.player_name )from opening_pairs op1 join opening_pairs op2 on 
op1.player_name = op2.player_name
group by 1;


with a as (
select team_name, max(player_name) player_1, min(player_name) player_2
from   opening_pairs op1
where team_name = 'India'
group by team_name
    )
select a.*, op.player_name from a, opening_pairs op
where a.team_name = op.team_name
and   player_1 <> player_name
and   player_2 <> player_name



select a.first_name,a.last_name,  'actors' as people_type  from actors a where gender='F'
except
select d.first_name,d.last_name, 'directors' as people_type  from directors d

select d.first_name,d.last_name, 'directors' as people_type  from directors d
except
select a.first_name,a.last_name,  'actors' as people_type  from actors a where gender='F'













