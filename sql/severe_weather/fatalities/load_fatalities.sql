BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data;

CREATE TABLE IF NOT EXISTS "severe_weather_data".fatalities_:YEAR () INHERITS ("severe_weather".fatalities);

DELETE FROM "severe_weather_data".fatalities_:YEAR;

COMMIT;

