--cursor

-- creating a cursor using refcursor
DECLARE
    current_all_movies refcursor;

--creating a cursor bounding to query expression
DECLARE
    current_all_movies cursor for select movie_name,movie_length,movie_lang from movies;
	
--create a crusor with qurery paraeters

declare cur_all_movies_year cursor (custom_year integer)
	for select movie_name,movie_length,movie_lang,release_date  
	from movies where extract('YEAR' from release_date)=custom_year;
	
	
--openig  a cursor

--unbound crusor(we have to define the query)

open cur_director_us for 
select first_name,last_name,date_of_birth,nationality from directors where nationality='American';

--open unbound crusor with a dynamic query
 
 my_query:= 'select distinct(nationality) from directors order by $1'
 
 
 open cur_directors_nationality
 for execute my_query using sort_field;
 
 
--bound cursor(bound to qurey we ned to pass the params)
open current_all_movies; 


declare cur_all_movies_year cursor (custom_year integer)
	for 
	select movie_name,movie_length,movie_lang,release_date  
	from movies 
	where extract('YEAR' from release_date)=custom_year;
	
open cur_all_movies_year(custom_year:=2010);


--using cursor

-- fetech,move updateor delete statment 
fetch [direction {from| in }] cursor_vairable;

fetch current_all_movies into row_movie;


fetch last from row_movie into  movie_title,movie_release_date;

--move
move [direction {from| in }] cursor_vairable;
move   current_all_movies;

move last from current_all_movies relative -1 from current_all_movies move forward 4 from current_all_movies;

--update

update movies
set year(release_date)=custom_year
where current of current_all_movies;


--closing a cursor

close cursor_variable

--createing plpgsql cursor

--lets use the ccursor to get loist of movie names

select * from movies order by movie_name;

do 
$$

	declare
		output_text text default '' ;
		rec_movie record;
		
		cur_all_movies cursor for  select * from movies;	
	
	begin
		open cur_all_movies;
		
		loop
			fetch cur_all_movies into rec_movie;
			exit when not found;
			
			output_text :=output_text || ',' || rec_movie.movie_name;
			
		end loop ;
	
		raise notice 'ALL MOVIES  NAMES %',output_text;
	end;
$$ language plpgsql





--using cursor with a function

--movie name contains star -->movie name and release year

create or replace function fn_get_movie_name_by_year(custom_year integer)
 returns text language plpgsql as
 $$
 
 	declare movie_names text default '';
	 rec_movie record;
	 
	 cur_all_movies_by_year cursor (custom_year integer)
	 for
	 select movie_name,movie_lang,extract('year'from release_date) release_year from movies
	 where extract('year'from release_date) =custom_year;
	 
	
	begin
		open cur_all_movies_by_year(custom_year);
		loop
			fetch cur_all_movies_by_year into rec_movie;
			exit when not found;
			
			
			if rec_movie.movie_name like '%Star%' then
			movie_names=movie_names|| ','|| rec_movie.movie_name ||','||rec_movie.release_year; 
			
			end if;
			
		end loop;
		close cur_all_movies_by_year;
	
	return movie_names;
	end;
	
 $$


select * from fn_get_movie_name_by_year(1980);


 