BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_inlandflood_results_gross_loss_by_occupancy (
	occupancy_code DECIMAL, 
	description VARCHAR, 
	gross_aal DECIMAL, 
	limits DECIMAL, 
	locations DECIMAL
);

COMMIT;

