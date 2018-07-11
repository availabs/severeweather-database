#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/details)"

psql -f ./create_details.sql

find -L "$DATADIR" -type f |
sort |
while read f
do
  YEAR="$(echo "$f" | grep -Po '_d[[:digit:]]{4}_' | cut -c3-6)"
  psql -v YEAR="$YEAR" -f ./load_details.sql
  header="$(gunzip -c "$f" | head -1)"
  gunzip -c "$f" | psql -c "
    COPY \"severe_weather_data\".details_${YEAR} (${header})
      FROM STDIN WITH CSV HEADER;
  "
  sed "s/__YEAR__/$YEAR/g" ./optimize_details.sql | psql 
done

psql -f ./createGeometryCols.sql

popd >/dev/null
