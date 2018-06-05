#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/hail)"

psql -f ./create_hail.sql

find -L "$DATADIR" -type f |
sort |
while read f
do
  YEARMO="$(echo "$f" | grep -Po '[[:digit:]]{4,6}')"
  psql -v YEAR="$YEARMO" -f ./load_hail.sql
  header="$(gunzip -c "$f" | sed '/^#.* /d; s/^#//g' | head -1)"
  gunzip -c "$f" | sed '/^#/d' | psql -c "
    COPY \"severe_weather_data\".hail_${YEARMO} (${header})
      FROM STDIN WITH CSV NULL '';
  "
done

psql -f ./createGeometryCols.sql

popd >/dev/null
