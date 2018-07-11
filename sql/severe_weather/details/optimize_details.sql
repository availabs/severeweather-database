BEGIN;

ALTER TABLE "severe_weather_data".details___YEAR__
  ADD CONSTRAINT details_year_chk CHECK (year = __YEAR__);

CREATE INDEX details_geoid___YEAR___idx
  ON "severe_weather_data".details___YEAR__ (geoid);

CREATE INDEX details_geoid2___YEAR___idx
  ON "severe_weather_data".details___YEAR__ (substring(geoid, 1, 2));

CREATE INDEX details_geoid5___YEAR___idx
  ON "severe_weather_data".details___YEAR__ (substring(geoid, 1, 5));

CREATE INDEX details_cousub_geoid___YEAR___idx
  ON "severe_weather_data".details___YEAR__ (cousub_geoid);

COMMIT;

