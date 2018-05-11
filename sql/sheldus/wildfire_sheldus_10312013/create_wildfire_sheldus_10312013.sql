BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.wildfire_sheldus_10312013 (
	county VARCHAR, 
	count DECIMAL, 
	fatal DECIMAL, 
	injury DECIMAL, 
	propdam DECIMAL, 
	cropdam DECIMAL
);

COMMIT;

