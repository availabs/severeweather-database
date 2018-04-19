BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather_data".tvs_:YEAR () INHERITS ("severe_weather".tvs);

TRUNCATE "severe_weather_data".tvs_:YEAR;

COMMIT;

