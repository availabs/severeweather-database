BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.nfip_2018_by_zip5_exposure_byzip (
	statecountyfips DECIMAL, 
	statefips DECIMAL, 
	statecode VARCHAR, 
	countyfips DECIMAL, 
	countyname VARCHAR, 
	postalcode VARCHAR, 
	locations DECIMAL, 
	building_tiv DECIMAL, 
	contents_tiv DECIMAL, 
	building_limit DECIMAL, 
	contents_limit DECIMAL
);

COMMIT;

