BEGIN;

CREATE SCHEMA IF NOT EXISTS nfip;

CREATE TABLE nfip.historical_contracts_exhibit (
	state_name VARCHAR, 
	contract_year_loss_year DECIMAL, 
	earned_contract_count DECIMAL, 
	earned_premium1 DECIMAL, 
	losses_paid2 DECIMAL, 
	allocated_loss_adj_exp DECIMAL, 
	num_of_closed_losses DECIMAL, 
	num_of_open_losses DECIMAL
);

COMMIT;

