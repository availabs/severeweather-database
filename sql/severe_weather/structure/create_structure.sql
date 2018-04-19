BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather";

CREATE TABLE IF NOT EXISTS "severe_weather".structure (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	wsr_id VARCHAR, 
	cell_id VARCHAR, 
	range FLOAT, 
	azimuth FLOAT, 
	base_height FLOAT, 
	top_height FLOAT, 
	vil INTEGER, 
	max_reflect INTEGER, 
	height FLOAT
);

COMMIT;
