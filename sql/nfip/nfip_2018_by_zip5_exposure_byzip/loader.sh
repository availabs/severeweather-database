#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/nfip_2018_by_zip5_exposure_byzip.csv.gz)"

psql -f ./drop_nfip_2018_by_zip5_exposure_byzip.sql
psql -f ./create_nfip_2018_by_zip5_exposure_byzip.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.nfip_2018_by_zip5_exposure_byzip (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

