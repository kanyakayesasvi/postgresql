-- ALTER SCHEMA yesasvi RENAME TO my_schema


--creating same table from public to my_schema
CREATE TABLE my_schema.new_table AS
SELECT * FROM public.accounts;

select * from my_schema.new_table


DO $$ 
DECLARE
  table_name text;
BEGIN
  FOR table_name IN SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public' 
  LOOP
    EXECUTE 'CREATE TABLE yesasvi.' || table_name || ' (LIKE public.' || table_name || ' INCLUDING ALL)';
    
  END LOOP;
END $$;

SELECT table_name, column_name, data_type, character_maximum_length, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'yesasvi';


SELECT table_name, column_name, data_type, character_maximum_length, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public';


create table my_schema.t_tags(
	id serial PRIMARY key,
	tag text unique,
	update_date timestamp default now()
	);

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'my_schema';
































