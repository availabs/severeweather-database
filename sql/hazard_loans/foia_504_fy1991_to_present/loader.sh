#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/hazard_loans/foia_504_fy1991_to_present.csv.gz)"

psql -f ./drop_foia_504_fy1991_to_present.sql
psql -f ./create_foia_504_fy1991_to_present.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY hazard_loans.foia_504_fy1991_to_present (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null

