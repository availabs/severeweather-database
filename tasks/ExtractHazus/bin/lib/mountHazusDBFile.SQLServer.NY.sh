#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}")/../../" >/dev/null

source "./config/config.env"

SQL="CREATE DATABASE hazus ON ( FILENAME = N'/hazus_data/NY/NY.mdf' ) FOR ATTACH_REBUILD_LOG;"

docker exec "${MSSQL_CONTAINER_NAME}" \
  /opt/mssql-tools/bin/sqlcmd \
    -USA -P"${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" \
    -Q "${SQL}"

popd >/dev/null
