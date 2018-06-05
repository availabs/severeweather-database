BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_stormsurge_exposure_by_year_built (
	yearbuilt VARCHAR, 
	locations DECIMAL, 
	building_value DECIMAL, 
	contents_value DECIMAL, 
	building_limit DECIMAL, 
	contents_limit DECIMAL
);

COMMIT;

