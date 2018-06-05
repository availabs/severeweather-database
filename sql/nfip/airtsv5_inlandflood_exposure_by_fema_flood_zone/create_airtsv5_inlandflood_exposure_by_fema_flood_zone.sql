BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_exposure_by_fema_flood_zone (
	fema_flood_zone VARCHAR, 
	locations DECIMAL, 
	building_value DECIMAL, 
	contents_value DECIMAL, 
	building_limit DECIMAL, 
	contents_limit DECIMAL
);

COMMIT;

