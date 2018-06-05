BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_by_occupancy_code (
	state VARCHAR, 
	occupancy_type DECIMAL, 
	description VARCHAR, 
	recordcount DECIMAL, 
	building_value DECIMAL, 
	content_value DECIMAL, 
	building_limit DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

