#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../config/config

docker exec -it hazus_db bash

popd >/dev/null

