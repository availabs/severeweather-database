#!/bin/bash

# https://docs.docker.com/engine/reference/builder/#arg
# 

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../config/config.env

docker build --build-arg PGLOADER_VERSION="$PGLOADER_VERSION" -t "${PGLOADER_IMAGE_TAG}" .

popd >/dev/null
