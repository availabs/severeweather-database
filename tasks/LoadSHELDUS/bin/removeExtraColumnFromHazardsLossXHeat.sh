#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

FILE="$(readlink -e ../csv/hazards_loss_1960_2012_sheldus_xheat.csv.gz)"

gunzip -c "$FILE" | cut -d',' -f6 --complement > "${FILE/.gz/}"
GZIP=-9 gzip -f "${FILE/.gz/}"

popd >/dev/null
