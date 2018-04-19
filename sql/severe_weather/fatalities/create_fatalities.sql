BEGIN;

CREATE TABLE severe_weather.fatalities (
	fat_yearmonth INTEGER, 
	fat_day INTEGER, 
	fat_time INTEGER, 
	fatality_id INTEGER, 
	event_id INTEGER, 
	fatality_type VARCHAR, 
	fatality_date TIMESTAMP WITHOUT TIME ZONE, 
	fatality_age INTEGER, 
	fatality_sex VARCHAR, 
	fatality_location VARCHAR, 
	event_yearmonth INTEGER
);

COMMIT;
