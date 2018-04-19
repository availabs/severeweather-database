BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather_data".structure_tiles_:YEAR () INHERITS ("severe_weather".structure_tiles);

DELETE FROM "severe_weather_data".structure_tiles_:YEAR;

COMMIT;

