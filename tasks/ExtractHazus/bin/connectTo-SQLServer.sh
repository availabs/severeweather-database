#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source "../config/config.env"

# Connect to the MSSQL Server using mssql-cli
docker run -it "${PGLOADER_IMAGE_TAG}" \
  mssql-cli -USA -P"${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" -dhazus

popd >/dev/null
