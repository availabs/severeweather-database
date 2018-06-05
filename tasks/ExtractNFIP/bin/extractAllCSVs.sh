#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

./AIRTSv5_InlandFlood_ExposureReport.2csv.sh
./AIRTSv5_InlandFlood_ResultsSummary.2csv.sh
./AIRTSv5_StormSurge_ExposureReport.2csv.sh
./AIRTSv5_StormSurge_ResultsSummary.2csv.sh
./by_zip5_exposure.2csv.sh
./Historical_Contracts_Losses_by_State.2csv.sh
./RMSv17_StormSurge_ExposureReport.2csv.sh
./RMSv17_StormSurge_ResultsSummary.2csv.sh
./compressCSVs.sh

popd >/dev/null

