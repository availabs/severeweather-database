BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".locations_:YEAR () INHERITS ("severe_weather".locations);

DELETE FROM "severe_weather_data".locations_:YEAR;

COMMIT;

