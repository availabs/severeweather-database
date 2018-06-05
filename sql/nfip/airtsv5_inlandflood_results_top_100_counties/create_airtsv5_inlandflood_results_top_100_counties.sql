BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_results_top_100_counties (
	state VARCHAR, 
	county VARCHAR, 
	locations DECIMAL, 
	building_value DECIMAL, 
	contents_value DECIMAL, 
	building_limit DECIMAL, 
	contents_limit DECIMAL, 
	gross_aal DECIMAL
);

COMMIT;

