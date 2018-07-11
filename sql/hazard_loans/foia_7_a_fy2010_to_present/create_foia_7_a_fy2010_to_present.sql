BEGIN;

CREATE SCHEMA IF NOT EXISTS hazard_loans;

CREATE TABLE hazard_loans.foia_7_a_fy2010_to_present (
	program VARCHAR, 
	borrname VARCHAR, 
	borrstreet VARCHAR, 
	borrcity VARCHAR, 
	borrstate VARCHAR, 
	borrzip VARCHAR, 
	bankname VARCHAR, 
	bankstreet VARCHAR, 
	bankcity VARCHAR, 
	bankstate VARCHAR, 
	bankzip VARCHAR, 
	grossapproval DECIMAL, 
	sbaguaranteedapproval DECIMAL, 
	approvaldate VARCHAR, 
	approvalfiscalyear DECIMAL, 
	firstdisbursementdate VARCHAR, 
	deliverymethod VARCHAR, 
	subpgmdesc VARCHAR, 
	initialinterestrate DECIMAL, 
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
	revolverstatus DECIMAL, 
	jobssupported DECIMAL
);

COMMIT;

