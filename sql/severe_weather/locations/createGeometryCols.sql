-- https://gis.stackexchange.com/a/145009

BEGIN;

SELECT AddGeometryColumn ('severe_weather', 'locations', 'coords_geom', 4326, 'POINT', 2);
UPDATE "severe_weather".locations SET coords_geom = ST_SetSRID(ST_MakePoint(longitude, latitude), 4326);

COMMIT;
