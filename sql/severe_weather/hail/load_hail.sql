BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".hail_:YEAR () INHERITS ("severe_weather".hail);

DELETE FROM "severe_weather_data".hail_:YEAR;

COMMIT;

