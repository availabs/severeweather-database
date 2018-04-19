BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".nldn_tiles_:YEAR () INHERITS ("severe_weather".nldn_tiles);

DELETE FROM "severe_weather_data".nldn_tiles_:YEAR;

COMMIT;

