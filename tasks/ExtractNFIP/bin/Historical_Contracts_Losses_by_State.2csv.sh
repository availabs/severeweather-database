#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

. utils.sh

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='06_NFIP_Historical_Contracts_-_Premium_-_Losses_by_State.xlsx'

# This sheet really contains a bunch of sub tables.
# We output each of them to a separate CSV.
in2csv --sheet 'Exhibit' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+5 |
  sed "$SED_CLEAN_TBL_SCRIPT" |
  sed '/^[[:alpha:]]\+\sTotal,/d' |
  gzip -9 \
> "${OUT_DIR}/historical_contracts_exhibit.csv.gz"
