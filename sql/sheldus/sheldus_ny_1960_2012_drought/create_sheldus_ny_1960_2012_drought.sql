BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.sheldus_ny_1960_2012_drought (
	county VARCHAR, 
	count_of_hazard_id DECIMAL, 
	sum_of_fatalities DECIMAL, 
	sum_of_injuries DECIMAL, 
	sum_of_property_damage DECIMAL, 
	sum_of_crop_damage DECIMAL
);

COMMIT;

