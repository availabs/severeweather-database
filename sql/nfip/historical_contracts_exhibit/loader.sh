#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/nfip/historical_contracts_exhibit.csv.gz)"

psql -f ./drop_historical_contracts_exhibit.sql
psql -f ./create_historical_contracts_exhibit.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY nfip.historical_contracts_exhibit (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

