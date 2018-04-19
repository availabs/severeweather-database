#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/fatalities)"

psql -f ./create_fatalities.sql

find "$DATADIR" -type f |
sort |
while read f
do
  YEAR="$(echo "$f" | grep -Po '_d[[:digit:]]{4}_' | cut -c3-6)"
  psql -v YEAR="$YEAR" -f ./load_fatalities.sql
  header="$(gunzip -c "$f" | head -1)"
  gunzip -c "$f" | psql -c "
    COPY \"severe_weather_data\".fatalities_${YEAR} (${header})
      FROM STDIN WITH CSV HEADER NULL '';
  "
done

popd >/dev/null
