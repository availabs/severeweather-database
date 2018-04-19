BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather";

CREATE TABLE IF NOT EXISTS severe_weather.plsr (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	event VARCHAR, 
	magnitude FLOAT, 
	city VARCHAR, 
	county VARCHAR, 
	state VARCHAR, 
	source VARCHAR, 
	wfo VARCHAR, 
	remarks VARCHAR
);

COMMIT;
