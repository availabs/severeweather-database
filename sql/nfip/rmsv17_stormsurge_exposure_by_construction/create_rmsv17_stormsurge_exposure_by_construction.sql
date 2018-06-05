BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_by_construction (
	construction_class DECIMAL, 
	description VARCHAR, 
	record_count DECIMAL, 
	building_value DECIMAL, 
	content_value DECIMAL, 
	building_limit DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

