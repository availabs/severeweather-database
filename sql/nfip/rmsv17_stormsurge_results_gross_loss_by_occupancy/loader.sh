#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/rmsv17_stormsurge_results_gross_loss_by_occupancy.csv.gz)"

psql -f ./drop_rmsv17_stormsurge_results_gross_loss_by_occupancy.sql
psql -f ./create_rmsv17_stormsurge_results_gross_loss_by_occupancy.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.rmsv17_stormsurge_results_gross_loss_by_occupancy (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

