-- https://gis.stackexchange.com/a/145009

BEGIN;

SELECT AddGeometryColumn ('severe_weather', 'mda_tiles', 'center_coords_geom', 4326, 'POINT', 2);
UPDATE "severe_weather".mda_tiles SET center_coords_geom = ST_SetSRID(ST_MakePoint(centerlon, centerlat), 4326);

COMMIT;
