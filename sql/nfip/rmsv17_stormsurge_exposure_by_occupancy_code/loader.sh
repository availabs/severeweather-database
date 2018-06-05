#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/rmsv17_stormsurge_exposure_by_occupancy_code.csv.gz)"

psql -f ./drop_rmsv17_stormsurge_exposure_by_occupancy_code.sql
psql -f ./create_rmsv17_stormsurge_exposure_by_occupancy_code.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.rmsv17_stormsurge_exposure_by_occupancy_code (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null
