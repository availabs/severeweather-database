#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='hazard_loss.xls'
TABLE_NAME="${SS_NAME/.xls/}"
TABLE_NAME="${TABLE_NAME,,}"

in2csv --names "${IN_DIR}/${SS_NAME}" |
while read sheet_name
do
  in2csv --sheet "$sheet_name" "${IN_DIR}/${SS_NAME}" |
    sed 's/\s\+,/,/g' |
    awk '/^Total|^,/ { exit }; { print }' - |
    GZIP=-9 gzip -c \
  > "${OUT_DIR}/${TABLE_NAME}_${sheet_name,,}.csv.gz"
done

popd >/dev/null
