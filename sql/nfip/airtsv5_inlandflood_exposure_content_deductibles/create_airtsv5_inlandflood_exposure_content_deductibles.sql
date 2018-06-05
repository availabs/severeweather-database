BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_exposure_content_deductibles (
	content_deductible DECIMAL, 
	locations DECIMAL, 
	content_value DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

