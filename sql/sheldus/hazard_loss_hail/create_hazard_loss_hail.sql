BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazard_loss_hail (
	county VARCHAR, 
	count DECIMAL, 
	fatal DECIMAL, 
	injury DECIMAL, 
	propdam DECIMAL, 
	cropdam DECIMAL
);

COMMIT;

