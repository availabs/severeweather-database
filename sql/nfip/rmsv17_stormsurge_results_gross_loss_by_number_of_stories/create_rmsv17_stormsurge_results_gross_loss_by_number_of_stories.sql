BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.rmsv17_stormsurge_results_gross_loss_by_number_of_stories (
	number_of_stories DECIMAL, 
	gross_aal DECIMAL, 
	limits DECIMAL, 
	recordcount DECIMAL
);

COMMIT;

