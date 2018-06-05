BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_results_gross_loss_by_state (
	state VARCHAR, 
	gross_aal DECIMAL, 
	limits DECIMAL, 
	locations DECIMAL
);

COMMIT;

