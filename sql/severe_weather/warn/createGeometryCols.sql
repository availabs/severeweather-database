-- https://gis.stackexchange.com/a/145009
BEGIN;

-- NOTE: In the downloaded CSV, the polygon column points are not separated by commas.
--       PostGIS requires that they are.
--       The following inserts a comma between every other coordinate.

SELECT AddGeometryColumn ('severe_weather', 'warn', 'center_coords_geom', 4326, 'MULTIPOLYGON', 2);
UPDATE "severe_weather".warn SET center_coords_geom =
  ST_Multi(
    ST_GeomFromText(
      regexp_replace(
        regexp_replace(
          regexp_replace(
            polygon,
            '([0-9.]+ [0-9.]+)', -- capture each pair of space delimited decimals
            '\1,',               -- append a comma after each pair
            'g'                  -- g regex flag
          ),
          ',\)',                 -- remove the last appended comma
          ')',                   -- ...
          'g'
        ),
        '\) \(',
        '), (',
        'g'
      ) , 4326
    )
  )
;

COMMIT;
