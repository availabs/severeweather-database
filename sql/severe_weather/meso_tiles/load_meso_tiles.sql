BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".meso_tiles_:YEAR () INHERITS ("severe_weather".meso_tiles);

DELETE FROM "severe_weather_data".meso_tiles_:YEAR;

COMMIT;

