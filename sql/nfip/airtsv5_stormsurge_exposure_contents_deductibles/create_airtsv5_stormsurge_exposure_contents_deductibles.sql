BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_stormsurge_exposure_contents_deductibles (
	content_deductible DECIMAL, 
	locations DECIMAL, 
	content_value DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

