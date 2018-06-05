#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/airtsv5_inlandflood_exposure_by_fema_flood_zone.csv.gz)"

psql -f ./drop_airtsv5_inlandflood_exposure_by_fema_flood_zone.sql
psql -f ./create_airtsv5_inlandflood_exposure_by_fema_flood_zone.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.airtsv5_inlandflood_exposure_by_fema_flood_zone (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

