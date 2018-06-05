BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_by_occupancy (
	occupancy_type DECIMAL, 
	description VARCHAR, 
	record_count DECIMAL, 
	building_value DECIMAL, 
	content_value DECIMAL, 
	building_limit DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

