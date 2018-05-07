#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

IN_DIR="$(readlink -e ../csv)"
OUT_DIR="$(readlink -f ../tmp-sql)"

mkdir -p "${OUT_DIR}"

SS_NAME='hazard_loss.xls'
TABLE_NAME="${SS_NAME/.xls/}"
TABLE_NAME="${TABLE_NAME,,}"

DROP_TABLE_SQL='BEGIN;

DROP TABLE IF EXISTS sheldus.__TABLE_NAME__ CASCADE;

COMMIT;
'

CREATE_TABLE_SQL='BEGIN;

CREATE SCHEMA IF NOT EXISTS sheldus;

__CREATE_TABLE_DDL__

COMMIT;
'

LOADER_SCRIPT='#!/bin/bash

set -a

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

source ../../../config/postgres.env

CSV_PATH="$(readlink -e ../../../data/sheldus/__TABLE_NAME__.csv.gz)"

psql -f ./drop___TABLE_NAME__.sql
psql -f ./create___TABLE_NAME__.sql

header="$(gunzip -c "$CSV_PATH" | head -1)"

gunzip -c "$CSV_PATH" | psql -c "
  COPY sheldus.__TABLE_NAME__ (${header})
    FROM STDIN WITH CSV HEADER;
"

popd >/dev/null
'

find "$IN_DIR" -type f -name '*.csv.gz' |
sort |
while read csvName
do
  TABLE_NAME="$(basename "$csvName")"
  TABLE_NAME="${TABLE_NAME/.csv.gz/}"

  echo "$TABLE_NAME"

  TABLE_SQL_DIR="${OUT_DIR}/${TABLE_NAME}"

  mkdir -p "$TABLE_SQL_DIR"

  echo "${DROP_TABLE_SQL//__TABLE_NAME__/$TABLE_NAME}" \
    > "${TABLE_SQL_DIR}/drop_${TABLE_NAME}.sql"

  CREATE_TABLE_DDL="$(
    gunzip -c "${csvName}" | sed '/^#.* .*$/d; s/#//g;' |
    csvsql -i postgresql --tables "${TABLE_NAME}" --no-constraints 2>/dev/null |
        sed "
          s/\(\".*\"\)/\L\1/g;         # Lowercase all column names
          s/\"//g;                     # Remove the double quotes everywhere
          s/BOOLEAN/DECIMAL/g;         # Change BOOLEAN datatype to DECIMAL
          s/${TABLE_NAME}/sheldus.&/g; # Add the schema to the column name
        "
  )"

  echo "${CREATE_TABLE_SQL/__CREATE_TABLE_DDL__/$CREATE_TABLE_DDL}" \
    > "${TABLE_SQL_DIR}/create_${TABLE_NAME}.sql"

  echo "${LOADER_SCRIPT//__TABLE_NAME__/$TABLE_NAME}" \
    > "${TABLE_SQL_DIR}/loader.sh"
  
  chmod +x "${TABLE_SQL_DIR}/loader.sh"
done

popd >/dev/null
