#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/airtsv5_stormsurge_results_gross_loss_by_state.csv.gz)"

psql -f ./drop_airtsv5_stormsurge_results_gross_loss_by_state.sql
psql -f ./create_airtsv5_stormsurge_results_gross_loss_by_state.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.airtsv5_stormsurge_results_gross_loss_by_state (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

