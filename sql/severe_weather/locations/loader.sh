#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/locations)"

psql -f ./create_locations.sql

find "$DATADIR" -type f |
sort |
while read f
do
  YEAR="$(echo "$f" | grep -Po '_d[[:digit:]]{4}_' | cut -c3-6)"
  psql -v YEAR="$YEAR" -f ./load_locations.sql
  header="$(gunzip -c "$f" | head -1)"
  gunzip -c "$f" | tail -n+2 | psql -c "
    COPY \"severe_weather_data\".locations_${YEAR} (${header})
      FROM STDIN WITH CSV NULL '';
  "
done

popd >/dev/null
