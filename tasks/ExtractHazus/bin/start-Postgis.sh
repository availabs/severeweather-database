#!/bin/bash

set -e

pushd  "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null

source "./config/config.env"

docker run -d --rm \
	-e POSTGRES_USER="${PGUSER}" \
	-e POSTGRES_PASSWORD="${PGPASSWORD}" \
	-e POSTGRES_DB=hazus \
	-e PGDATA=/pg_data \
	-p "${PGPORT}":5432 \
	-v "$(pwd)/pg_data/":/pg_data \
	--name="${PG_CONTAINER_NAME}" \
	"mdillon/postgis:$PG_VERSION"

popd >/dev/null
