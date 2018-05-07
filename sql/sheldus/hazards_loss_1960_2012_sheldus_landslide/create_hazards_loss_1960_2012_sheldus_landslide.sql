BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazards_loss_1960_2012_sheldus_landslide (
	county VARCHAR, 
	future_prob_pct DECIMAL, 
	recurrence_interval DECIMAL, 
	no_of_events_historical DECIMAL, 
	fatalities_historical DECIMAL, 
	injuries_historical DECIMAL, 
	property_damage_dollars_historical DECIMAL, 
	crop_damage_dollars_historical DECIMAL
);

COMMIT;

