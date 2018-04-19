BEGIN;

CREATE TABLE IF NOT EXISTS severe_weather.meso (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	wsr_id VARCHAR, 
	cell_id VARCHAR, 
	cell_type VARCHAR, 
	range INTEGER, 
	azimuth INTEGER, 
	base_height FLOAT, 
	top_height FLOAT, 
	height FLOAT, 
	radius FLOAT, 
	azdia FLOAT, 
	shear INTEGER
);

COMMIT;
