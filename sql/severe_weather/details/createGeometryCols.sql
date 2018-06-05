-- https://gis.stackexchange.com/a/145009

BEGIN;

SELECT AddGeometryColumn ('severe_weather', 'details', 'begin_coords_geom', 4326, 'POINT', 2);
UPDATE "severe_weather".details SET begin_coords_geom = ST_SetSRID(ST_MakePoint(begin_lon, begin_lat), 4326);

COMMIT;

BEGIN;

SELECT AddGeometryColumn ('severe_weather', 'details', 'end_coords_geom', 4326, 'POINT', 2);
UPDATE "severe_weather".details SET end_coords_geom = ST_SetSRID(ST_MakePoint(end_lon, end_lat), 4326);

COMMIT;
