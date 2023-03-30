--create utf-8 database

--create utf-8 database

create database database_utf8
with owner "postgres"
with encoding 'UTF8'
lc_collate='en_us.utf-8'
lc_ctype='en_us.utf-8'
template template0;




--create a korean based database

create database database_euc_kr
with owner "postgres"
encoding 'EUC_KR'
lc_collate='ko_KR.euckr'
lc_ctype='ko_KR.euckr'
template template0;




CREATE DATABASE korean WITH ENCODING 'EUC_KR' LC_COLLATE='ko_KR.euckr' LC_CTYPE='ko_KR.euckr' TEMPLATE=template0;


--server encoding
show server_encoding;
--clinte encoding

show client_encoding;




