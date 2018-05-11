#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='wildfire_SHELDUS_10312013.xls'
TABLE_NAME="${SS_NAME/.xls/}"
TABLE_NAME="${TABLE_NAME,,}"

in2csv --sheet "Sheet1" "${IN_DIR}/${SS_NAME}" |
  cut -f 1 -d ',' --complement |
  sed '
    s/\s\+,/,/g;
    1 s/Count/County/i;
    1 s/Count_2/Count/i;
  ' |
  GZIP=-9 gzip -c \
> "${OUT_DIR}/${TABLE_NAME}.csv.gz"

popd >/dev/null
