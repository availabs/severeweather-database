BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_by_fema_flood_zone (
	fema_flood_zone VARCHAR, 
	record_count DECIMAL, 
	building_value DECIMAL, 
	content_value DECIMAL, 
	building_limit DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

