#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${DIR}/config/config.env"

# Connect to the MSSQL Server using mssql-cli
if docker ps | grep -q "$PGLOADER_CONTAINER_NAME"; # pgloader container is running
then
  docker exec -it "${PGLOADER_CONTAINER_NAME}" bash
else # use the docker committed snapshot of the pgloader image
  docker run -it "${PGLOADER_IMAGE_TAG}" bash
fi

