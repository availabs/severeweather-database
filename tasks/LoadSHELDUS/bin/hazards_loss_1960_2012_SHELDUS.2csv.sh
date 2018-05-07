#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='hazards_loss_1960_2012_SHELDUS.xlsx'
TABLE_NAME="${SS_NAME/.xlsx/}"
TABLE_NAME="${TABLE_NAME,,}"

in2csv --names "${IN_DIR}/${SS_NAME}" |
while read sheet_name
do
  if [ "$sheet_name" == 'notes' ]
  then
    continue
  fi

  in2csv --sheet "$sheet_name" -K 1 "${IN_DIR}/${SS_NAME}" 2>/dev/null |
    sed '
      s/\s\+,/,/g;
      1 s/ /_/g;
      1 s/\.//g;
      1 s/\(.*\)/\L\1/;
      1 s/\%/pct/g;
      1 s/(\$)/dollars/g;
      1 s/fatalities/&_historical/;
      1 s/injuries/&_historical/;
      1 s/property_damage_dollars/&_historical/;
      1 s/crop_damage_dollars/&_historical/;
      1 s/no_of_events/&_historical/;
      1 s/fatalities_2/fatalities_recent_record/;
      1 s/injuries_2/injuries_recent_record/;
      1 s/property_damage_dollars_2/property_damage_dollars_recent_record/;
      1 s/crop_damage_dollars_2/crop_damage_dollars_recent_record/;
      1 s/no_of_events_2/no_of_events_recent_record/;
    ' |
    awk '/^Total|^,/ { exit }; { print }' - |
    GZIP=-9 gzip -c \
  > "${OUT_DIR}/${TABLE_NAME}_${sheet_name,,}.csv.gz"
done
