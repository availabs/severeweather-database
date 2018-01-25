#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${DIR}"

cd ../../

BAD_DATA_DIR="$(pwd)/bad_data"

cd data

for d in */;
do
  pushd "$d" > /dev/null

  for f in *;
  do
    if ! [[ $f =~ ^.*\.csv\.gz$ ]]
    then
      echo "${f} is not a gzipped csv"
      mkdir -p "${BAD_DATA_DIR}/${d}"
      mv "${f}" "${BAD_DATA_DIR}/${d}"
    else
      gunzip -t "${f}"

      if [[ $? -ne 0 ]];
      then
        echo "${f} did not pass the integrity test"
        mkdir -p "${BAD_DATA_DIR}/${d}"
        mv "${f}" "${BAD_DATA_DIR}/${d}"
      fi
    fi
  done

  popd > /dev/null
done
