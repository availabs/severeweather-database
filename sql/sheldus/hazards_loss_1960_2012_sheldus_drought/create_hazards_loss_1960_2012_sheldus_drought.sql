BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazards_loss_1960_2012_sheldus_drought (
	county VARCHAR, 
	future_prob_pct DECIMAL, 
	recurrence_interval DECIMAL, 
	number_of_events DECIMAL, 
	fatalities_historical DECIMAL, 
	injuries_historical DECIMAL, 
	property_damage DECIMAL, 
	crop_damage DECIMAL, 
	number_of_events_2 DECIMAL, 
	fatalities_recent_record DECIMAL, 
	injuries_recent_record DECIMAL, 
	property_damage_2 DECIMAL, 
	crop_damage_2 DECIMAL
);

COMMIT;

