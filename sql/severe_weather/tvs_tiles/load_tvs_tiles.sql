BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather_data".tvs_tiles_:YEAR () INHERITS ("severe_weather".tvs_tiles);

TRUNCATE "severe_weather_data".tvs_tiles_:YEAR;

COMMIT;

