BEGIN;

CREATE TABLE severe_weather.nldn_tiles (
	zday INTEGER, 
	centerlon FLOAT, 
	centerlat FLOAT, 
	total_count INTEGER
);

COMMIT;
