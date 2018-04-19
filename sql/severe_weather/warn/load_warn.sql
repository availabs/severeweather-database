BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather_data".warn_:YEAR () INHERITS ("severe_weather".warn);

TRUNCATE "severe_weather_data".warn_:YEAR;

COMMIT;

