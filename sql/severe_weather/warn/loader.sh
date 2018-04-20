#!/bin/bash

set -e
set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

DATADIR="$(readlink -e ../../../data/severe_weather/warn)"

psql -f ./create_warn.sql

find -L "$DATADIR" -type f |
sort |
while read f
do
  YEARMO="$(echo "$f" | grep -Po '[[:digit:]]{4,6}')"
  TABLE="\"severe_weather_data\".warn_${YEARMO}"
  echo "$TABLE"

  if ! psql -c "\d ${TABLE}" > /dev/null 2>&1 || "$CLOBBER"
  then
    psql -v YEAR="$YEARMO" -f ./load_warn.sql
    header="$(gunzip -c "$f" | sed '/^#.* /d; s/^#//g' | head -1)"
    gunzip -c "$f" | sed '/^#/d' | psql -c "
      COPY ${TABLE} (${header})
        FROM STDIN WITH CSV NULL '' ESCAPE '\';
    "
  fi
done

popd >/dev/null
