#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

find ../csv -type f -name '*csv' -exec gzip -9 {} \;

popd >/dev/null
