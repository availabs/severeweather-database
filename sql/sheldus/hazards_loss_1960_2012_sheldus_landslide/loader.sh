#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/hazards_loss_1960_2012_sheldus_landslide.csv.gz)"

psql -f ./drop_hazards_loss_1960_2012_sheldus_landslide.sql
psql -f ./create_hazards_loss_1960_2012_sheldus_landslide.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.hazards_loss_1960_2012_sheldus_landslide (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

