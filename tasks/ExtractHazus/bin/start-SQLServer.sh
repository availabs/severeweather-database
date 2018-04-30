#!/bin/bash

set -e

pushd  "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null

source "./config/config.env"

docker run -d --rm \
	-e ACCEPT_EULA=Y \
	-e SA_PASSWORD="${MSSQL_SA_PASSWORD}" \
	-p "${MSSQL_TCP_PORT}":1433 \
	-v "$(pwd)/hazus_data":/hazus_data \
	--name="${MSSQL_CONTAINER_NAME}" \
	"microsoft/mssql-server-linux:$MSSQL_VERSION"

popd >/dev/null
