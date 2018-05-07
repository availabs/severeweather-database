BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.sheldus_ny_1960_2012_sheldus_ny_1960_2012 (
	hazard_id DECIMAL, 
	hazard_begin_date DATE, 
	hazard_end_date DATE, 
	hazard_type_combo VARCHAR, 
	name VARCHAR, 
	postal_code VARCHAR, 
	fips_code DECIMAL, 
	injuries DECIMAL, 
	fatalities DECIMAL, 
	property_damage DECIMAL, 
	crop_damage DECIMAL, 
	remarks VARCHAR, 
	property_damage_adjusted_2012 DECIMAL, 
	crop_damage_adjusted_2012 DECIMAL
);

COMMIT;

