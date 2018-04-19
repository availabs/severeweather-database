BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".hail_tiles_:YEAR () INHERITS ("severe_weather".hail_tiles);

DELETE FROM "severe_weather_data".hail_tiles_:YEAR;

COMMIT;

