BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_building_deductibles (
	building_deductible DECIMAL, 
	record_count DECIMAL, 
	building_value DECIMAL, 
	building_limit DECIMAL
);

COMMIT;

