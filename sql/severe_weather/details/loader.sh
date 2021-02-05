#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/details)"

# psql -f ./create_details.sql

TIMESTAMP="$( date +%s )

find -L "$DATADIR" -type f |
sort |
while read -r f
do
  YEAR="$(echo "$f" | grep -Po '_d[[:digit:]]{4}_' | cut -c3-6)"
  echo "$YEAR"

  psql -v YEAR="$YEAR" -f ./create_details_data_table.sql

  # Get the CSV header to use as the COPY command's columns list
  header="$(gunzip -c "$f" | head -1)"

  # Load the data
  gunzip -c "$f" | psql -c "
    COPY \"severe_weather_data_staging\".details_${YEAR} (${header})
      FROM STDIN WITH CSV HEADER;
  "
  sed "s/__YEAR__/$YEAR/g" ./finalize.sql | psql -v TIMESTAMP="$TIMESTAMP"
done

# psql -f ./createGeometryCols.sql

popd >/dev/null
