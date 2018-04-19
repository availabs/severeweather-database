BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".mda_:YEAR () INHERITS ("severe_weather".mda);

DELETE FROM "severe_weather_data".mda_:YEAR;

COMMIT;

