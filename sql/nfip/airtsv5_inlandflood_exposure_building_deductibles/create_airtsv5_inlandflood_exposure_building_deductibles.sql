BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_exposure_building_deductibles (
	building_deductible DECIMAL, 
	locations DECIMAL, 
	building_value DECIMAL, 
	building_limit DECIMAL
);

COMMIT;

