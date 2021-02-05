BEGIN;

ALTER TABLE "severe_weather_data_staging".details___YEAR__
  ADD CONSTRAINT details_year_chk CHECK (year = __YEAR__);

CREATE INDEX details_geoid___YEAR___idx
  ON "severe_weather_data_staging".details___YEAR__ (geoid);

CREATE INDEX details_geoid2___YEAR___idx
  ON "severe_weather_data_staging".details___YEAR__ (substring(geoid, 1, 2));

CREATE INDEX details_geoid5___YEAR___idx
  ON "severe_weather_data_staging".details___YEAR__ (substring(geoid, 1, 5));

CREATE INDEX details_cousub_geoid___YEAR___idx
  ON "severe_weather_data_staging".details___YEAR__ (cousub_geoid);

CREATE INDEX details___YEAR___event_type_idx
  ON "severe_weather_data_staging".details___YEAR__ (event_type);

CREATE INDEX details___YEAR___property_damage_idx
  ON "severe_weather_data_staging".details___YEAR__ (property_damage);

CLUSTER "severe_weather_data_staging".details___YEAR__ USING details_geoid___YEAR___idx;

COMMIT;

-- Cannot be called within a transaction
ANALYZE "severe_weather_data_staging".details___YEAR__;

BEGIN;

CREATE SCHEMA IF NOT EXISTS "severe_weather_data_backups";

ALTER TABLE IF EXISTS "severe_weather_data".details___YEAR__
  NO INHERIT "severe_weather".details,
  RENAME TO details___YEAR__backup_:TIMESTAMP,
  SET SCHEMA "severe_weather_data_backups";

ALTER TABLE "severe_weather_data_staging".details___YEAR__
  INHERIT "severe_weather".details;

COMMIT;
