#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/mda-tiles)"

psql -f ./create_mda_tiles.sql

find -L "$DATADIR" -type f |
sort |
while read f
do
  YEARMO="$(echo "$f" | grep -Po '[[:digit:]]{4,6}')"
  psql -v YEAR="$YEARMO" -f ./load_mda_tiles.sql
  header="$(gunzip -c "$f" | sed '/^#.* /d; s/^#//g' | head -1)"
  gunzip -c "$f" | sed '/^#/d' | psql -c "
    COPY \"severe_weather_data\".mda_tiles_${YEARMO} (${header})
      FROM STDIN WITH CSV NULL '';
  "
done

popd >/dev/null
