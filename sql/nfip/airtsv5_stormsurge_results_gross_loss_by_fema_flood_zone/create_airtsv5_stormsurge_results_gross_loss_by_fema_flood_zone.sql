BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.airtsv5_stormsurge_results_gross_loss_by_fema_flood_zone (
	fema_flood_zone VARCHAR, 
	gross_aal DECIMAL, 
	limits DECIMAL, 
	locations DECIMAL
);

COMMIT;

