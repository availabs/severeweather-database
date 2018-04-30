#!/bin/bash

# https://docs.docker.com/engine/reference/run/#env-environment-variables
# https://stackoverflow.com/a/32167165/3970755

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source "../config/config.env"

docker run --rm \
  -v "$(pwd)/lib/":/hazus_transfer \
  -e MSSQL_SA_PASSWORD="${MSSQL_SA_PASSWORD}" \
  -e MSSQL_IP_ADDRESS="${MSSQL_IP_ADDRESS}" \
  -e MSSQL_TCP_PORT="${MSSQL_TCP_PORT}" \
  -e PGUSER="${PGUSER}" \
  -e PGPASSWORD="${PGPASSWORD}" \
  -e PGHOST="${PGHOST}" \
  -e PGPORT="${PGPORT}" \
  -e PGLOADER_VERSION="${PGLOADER_VERSION}" \
  ${PGLOADER_IMAGE_TAG} bash /hazus_transfer/mssql2pg.sh
