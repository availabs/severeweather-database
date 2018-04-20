#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../config/config

docker exec -it hazus_db /opt/mssql-tools/bin/sqlcmd -Slocalhost -USA -P"${MSSQL_SA_PASSWORD}"

popd >/dev/null

