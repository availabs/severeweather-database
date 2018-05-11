#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/wildfire_sheldus_10312013.csv.gz)"

psql -f ./drop_wildfire_sheldus_10312013.sql
psql -f ./create_wildfire_sheldus_10312013.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.wildfire_sheldus_10312013 (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

