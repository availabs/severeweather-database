BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather";

CREATE TABLE IF NOT EXISTS "severe_weather".tvs_tiles (
	zday INTEGER, 
	centerlon FLOAT, 
	centerlat FLOAT, 
	total_count INTEGER
);

COMMIT;
