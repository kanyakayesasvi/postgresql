create table price_feed
(
	business_date date,
	product_id integer,
	price numeric 
);
drop function load_price_feed(text);
CREATE OR REPLACE FUNCTION load_price_feed(price_feed text)
RETURNS text AS $$
BEGIN
    EXECUTE 'COPY price_feed(business_date,product_id,price) FROM ' || quote_literal(price_feed) || ' WITH (FORMAT CSV, HEADER)';
	return 'Successfull';
END;
$$ LANGUAGE plpgsql;

truncate price_feed;

select load_price_feed('D:/udemy/sample_data/feeds/price_feed_day2.csv');

select * from price_feed;
