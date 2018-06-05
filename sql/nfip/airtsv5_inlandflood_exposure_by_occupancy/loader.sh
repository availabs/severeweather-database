#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/airtsv5_inlandflood_exposure_by_occupancy.csv.gz)"

psql -f ./drop_airtsv5_inlandflood_exposure_by_occupancy.sql
psql -f ./create_airtsv5_inlandflood_exposure_by_occupancy.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.airtsv5_inlandflood_exposure_by_occupancy (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

