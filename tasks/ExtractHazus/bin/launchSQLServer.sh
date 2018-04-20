#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../config/config

DB_DIR="$(readlink -f '../docker/mssql_db')"
DATA_DIR="$(readlink -f '../docker/data')"
SCRIPTS_DIR="$(readlink -f '../docker/admin_scripts')"

docker run -e 'ACCEPT_EULA=Y' -e "MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}" \
   -v "$DB_DIR":/var/opt/mssql \
   -v "$DATA_DIR":/data \
   -v "$SCRIPTS_DIR":/admin_scripts \
   -p "$MSSQL_PORT":1433 --name hazus_db \
   -d microsoft/mssql-server-linux:2017-latest

popd >/dev/null
