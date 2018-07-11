BEGIN;

CREATE SCHEMA IF NOT EXISTS hazard_loans;

CREATE TABLE hazard_loans.foia_504_fy1991_to_present (
	program VARCHAR, 
	borrname VARCHAR, 
	borrstreet VARCHAR, 
	borrcity VARCHAR, 
	borrstate VARCHAR, 
	borrzip VARCHAR, 
	cdc_name VARCHAR, 
	cdc_street VARCHAR, 
	cdc_city VARCHAR, 
	cdc_state VARCHAR, 
	cdc_zip VARCHAR, 
	thirdpartylender_name VARCHAR, 
	thirdpartylender_city VARCHAR, 
	thirdpartylender_state VARCHAR, 
	thirdpartydollars DECIMAL, 
	grossapproval DECIMAL, 
	approvaldate VARCHAR, 
	approvalfiscalyear INTEGER, 
	firstdisbursementdate VARCHAR, 
	deliverymethod VARCHAR, 
	subpgmdesc VARCHAR, 
	terminmonths DECIMAL, 
	naicscode VARCHAR, 
	naicsdescription VARCHAR, 
	franchisecode VARCHAR, 
	franchisename VARCHAR, 
	projectcounty VARCHAR, 
	projectstate VARCHAR, 
	sbadistrictoffice VARCHAR, 
	congressionaldistrict VARCHAR, 
	businesstype VARCHAR, 
	loanstatus VARCHAR, 
	chargeoffdate VARCHAR, 
	grosschargeoffamount DECIMAL, 
	jobssupported DECIMAL
);

COMMIT;

