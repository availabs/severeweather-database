#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

DATA_DIR='../data'

mkdir -p ../data/

curl 'https://www.fema.gov/media-library-data/1524073645228-2bae29908f8040e7d9fabffa469d3826/03_NFIP_2018_AIRTSv5_StormSurge_ExposureReport.xlsx' > "$DATA_DIR/03_NFIP_2018_AIRTSv5_StormSurge_ExposureReport.xlsx"

curl 'https://www.fema.gov/media-library-data/1524073444034-84be821a2e628d7dfae4c4395b81a154/02_NFIP_2018_By_Zip5_Exposure.xlsx' > "$DATA_DIR/02_NFIP_2018_By_Zip5_Exposure.xlsx"

curl 'https://www.fema.gov/media-library-data/1524073144729-ee9b4bd7686e3f79171f3c3a59ed11cd/04_NFIP_2018_RMSv17_StormSurge_ResultsSummary.xlsx' > "$DATA_DIR/04_NFIP_2018_RMSv17_StormSurge_ResultsSummary.xlsx"

curl 'https://www.fema.gov/media-library-data/1524072767660-bdf37ce973ccae58e05c3eba0ab952df/03_NFIP_2018_AIRTSv5_InlandFlood_ExposureReport.xlsx' > "$DATA_DIR/03_NFIP_2018_AIRTSv5_InlandFlood_ExposureReport.xlsx"

curl 'https://www.fema.gov/media-library-data/1524072537762-aa5df852718621bf95863f5dd684996c/03_NFIP_2018_RMSv17_StormSurge_ExposureReport.xlsx' > "$DATA_DIR/03_NFIP_2018_RMSv17_StormSurge_ExposureReport.xlsx"

curl 'https://www.fema.gov/media-library-data/1524072099086-319cbb987558c4ce3ea344689ee275f8/04_NFIP_2018_AIRTSv5_InlandFlood_ResultsSummary.xlsx' > "$DATA_DIR/04_NFIP_2018_AIRTSv5_InlandFlood_ResultsSummary.xlsx"

curl 'https://www.fema.gov/media-library-data/1524071965750-27f1c7680763f6498b7f7743b1f0d807/06_NFIP_Historical_Contracts_-_Premium_-_Losses_by_State.xlsx' > "$DATA_DIR/06_NFIP_Historical_Contracts_-_Premium_-_Losses_by_State.xlsx"

curl 'https://www.fema.gov/media-library-data/1524071841846-951c6a9acd38ad8299ac4d96545861ad/04_NFIP_2018_AIRTSv5_StormSurge_ResultsSummary.xlsx' > "$DATA_DIR/04_NFIP_2018_AIRTSv5_StormSurge_ResultsSummary.xlsx"

popd >/dev/null
