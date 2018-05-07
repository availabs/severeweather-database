#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/sheldus_ny_1960_2012_tsunami.csv.gz)"

psql -f ./drop_sheldus_ny_1960_2012_tsunami.sql
psql -f ./create_sheldus_ny_1960_2012_tsunami.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.sheldus_ny_1960_2012_tsunami (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

