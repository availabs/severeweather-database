BEGIN;

CREATE SCHEMA IF NOT EXISTS severe_weather_data_staging;

CREATE TABLE IF NOT EXISTS "severe_weather_data_staging".details_:YEAR (
  LIKE "severe_weather".details INCLUDING ALL
) WITH (fillfactor=100,a, autovacuum_enabled=false);

COMMIT;
