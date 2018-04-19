BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".mda_tiles_:YEAR () INHERITS ("severe_weather".mda_tiles);

DELETE FROM "severe_weather_data".mda_tiles_:YEAR;

COMMIT;

