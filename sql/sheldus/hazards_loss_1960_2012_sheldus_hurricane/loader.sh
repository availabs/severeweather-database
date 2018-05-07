#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/hazards_loss_1960_2012_sheldus_hurricane.csv.gz)"

psql -f ./drop_hazards_loss_1960_2012_sheldus_hurricane.sql
psql -f ./create_hazards_loss_1960_2012_sheldus_hurricane.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.hazards_loss_1960_2012_sheldus_hurricane (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

