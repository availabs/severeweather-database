#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/hazard_loss_wildfire.csv.gz)"

psql -f ./drop_hazard_loss_wildfire.sql
psql -f ./create_hazard_loss_wildfire.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.hazard_loss_wildfire (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

