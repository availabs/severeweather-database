#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/sheldus_ny_1960_2012_wind.csv.gz)"

psql -f ./drop_sheldus_ny_1960_2012_wind.sql
psql -f ./create_sheldus_ny_1960_2012_wind.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.sheldus_ny_1960_2012_wind (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

