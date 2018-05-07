#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

find ../csv -type f -size -22c -delete

popd >/dev/null
