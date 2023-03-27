--primary key on multiple columnc=comp0sit key

create table t_grades(
	
	cour_id varchar(5) not null,
	std_id varchar(5) not null,
	grade int not null
	
);
select * from t_grades;

drop table  t_grades;


insert into t_grades(cour_id,std_id,grade)
values
('math','s2',60),
('chem','s2',50),
('eng','s1',60),
('phy','s2',60);





create table t_grades(
	
	cour_id varchar(5) not null,
	std_id varchar(5) not null,
	grade int not null,
	primary key(cour_id,std_id)
);



create table t_grades(
	
	cour_id varchar(5) not null,
	std_id varchar(5) not null,
	grade int not null
	
);


alter table t_grades
add constraint 	t_grades_cour_id_std_id_pkey primary key ( cour_id , std_id);




