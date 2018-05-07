BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazard_loss_drought (
	county VARCHAR, 
	count DECIMAL, 
	fatal DECIMAL, 
	injury DECIMAL, 
	propdam DECIMAL, 
	cropdam DECIMAL
);

COMMIT;

