BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather";

CREATE TABLE IF NOT EXISTS "severe_weather".tvs (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	wsr_id VARCHAR, 
	cell_id VARCHAR, 
	cell_type VARCHAR, 
	range INTEGER, 
	azimuth INTEGER, 
	avgdv INTEGER, 
	lldv INTEGER, 
	mxdv INTEGER, 
	mxdv_height INTEGER, 
	depth FLOAT, 
	base FLOAT, 
	top FLOAT, 
	max_shear INTEGER, 
	max_shear_height FLOAT
);

COMMIT;
