BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather_data";

CREATE TABLE IF NOT EXISTS "severe_weather_data".plsr_:YEAR () INHERITS ("severe_weather".plsr);

DELETE FROM "severe_weather_data".plsr_:YEAR;

COMMIT;

