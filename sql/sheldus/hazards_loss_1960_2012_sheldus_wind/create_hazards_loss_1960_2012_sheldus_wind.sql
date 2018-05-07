BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

CREATE TABLE sheldus.hazards_loss_1960_2012_sheldus_wind (
	county VARCHAR, 
	future_prob_pct DECIMAL, 
	recurrence_interval DECIMAL, 
	no_of_events_historical DECIMAL, 
	fatalities_historical DECIMAL, 
	injuries_historical DECIMAL, 
	property_damage_dollars_historical DECIMAL, 
	crop_damage_dollars_historical DECIMAL, 
	no_of_events_recent_record DECIMAL, 
	fatalities_recent_record DECIMAL, 
	injuries_recent_record DECIMAL, 
	property_damage_dollars_recent_record DECIMAL, 
	crop_damage_dollars_recent_record DECIMAL
);

COMMIT;

