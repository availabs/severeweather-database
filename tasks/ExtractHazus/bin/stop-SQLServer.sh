#!/bin/bash

set -e

pushd  "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null

source "./config/config.env"

docker stop "${MSSQL_CONTAINER_NAME}"

popd >/dev/null
