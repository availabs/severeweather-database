BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_results_gross_loss_by_number_of_stories (
	number_of_stories DECIMAL, 
	gross_aal DECIMAL, 
	limits DECIMAL, 
	locations DECIMAL
);

COMMIT;

