BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_exposure_content_deductibles (
	content_deductible DECIMAL, 
	record_count DECIMAL, 
	content_value DECIMAL, 
	content_limit DECIMAL
);

COMMIT;

