BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazard_loss_flood (
	county VARCHAR, 
	count DECIMAL, 
	fatal DECIMAL, 
	injury DECIMAL, 
	propdam DECIMAL, 
	cropdam DECIMAL
);

COMMIT;

