BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather".hail (
	ztime BIGINT, 
	lon FLOAT, 
	lat FLOAT, 
	wsr_id VARCHAR, 
	cell_id VARCHAR, 
	range INTEGER, 
	azimuth INTEGER, 
	sevprob INTEGER, 
	prob INTEGER, 
	maxsize FLOAT
);

COMMIT;
