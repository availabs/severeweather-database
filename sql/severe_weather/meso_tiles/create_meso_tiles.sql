BEGIN;

CREATE TABLE IF NOT EXISTS severe_weather.meso_tiles (
	zday INTEGER, 
	centerlon FLOAT, 
	centerlat FLOAT, 
	total_count INTEGER
);

COMMIT;
