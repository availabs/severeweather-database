-- https://gis.stackexchange.com/a/145009

BEGIN;

SELECT AddGeometryColumn ('severe_weather', 'hail', 'coords_geom', 4326, 'POINT', 2);
UPDATE "severe_weather".hail SET coords_geom = ST_SetSRID(ST_MakePoint(lon, lat), 4326);

COMMIT;
