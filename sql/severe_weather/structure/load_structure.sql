BEGIN;

CREATE TABLE IF NOT EXISTS "severe_weather_data".structure_:YEAR () INHERITS ("severe_weather".structure);

DELETE FROM "severe_weather_data".structure_:YEAR;

COMMIT;

