#!/bin/bash

set -e

docker stop hazus_db >/dev/null
docker rm hazus_db >/dev/null
