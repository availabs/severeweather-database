#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='SHELDUS_NY_1960_2012.xlsx'
TABLE_NAME="${SS_NAME/.xlsx/}"
TABLE_NAME="${TABLE_NAME,,}"

in2csv --names "${IN_DIR}/${SS_NAME}" |
while read sheet_name
do
  if [ "$sheet_name" == 'MASTER PIVOT' ]
  then
    continue
  fi

  in2csv --sheet "$sheet_name" "${IN_DIR}/$SS_NAME" |
    sed '
      s/\s\+,/,/g;
      1 s/Row Labels/county/g;
      1 s/ /_/g;
      1 s/\.//g;
      1 s/\(.*\)/\L\1/;
    ' |
    awk '/^Total|^,|^Grand Total/ { exit }; { print }' - |
    GZIP=-9 gzip -c \
  > "${OUT_DIR}/${TABLE_NAME}_${sheet_name,,}.csv.gz"
done
