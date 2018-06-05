#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

. utils.sh

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='02_NFIP_2018_By_Zip5_Exposure.xlsx'

in2csv --sheet 'Exposure_ByZip' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+6 |
  sed "$SED_CLEAN_TBL_SCRIPT" |
  gzip -9 \
> "${OUT_DIR}/nfip_2018_by_zip5_exposure_byzip.csv.gz"

popd >/dev/null
