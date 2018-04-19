BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".meso_:YEAR () INHERITS ("severe_weather".meso);

DELETE FROM "severe_weather_data".meso_:YEAR;

COMMIT;

