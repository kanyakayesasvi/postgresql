--To get a list of all tables in the current database

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;



--To get a list of indexes on a specific table
SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'actors'




--To get the particular table structure using information_schema.tables,
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'actors';



--List all columns in a table
SELECT column_name FROM information_schema.columns WHERE table_name = 'actors';











