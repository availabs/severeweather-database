BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".details_:YEAR () INHERITS ("severe_weather".details);

DELETE FROM "severe_weather_data".details_:YEAR;

COMMIT;

