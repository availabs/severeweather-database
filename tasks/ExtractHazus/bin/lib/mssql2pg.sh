#!/bin/bash

# https://stackoverflow.com/a/24584130/3970755

set -e

pushd /hazus_transfer >/dev/null

export TDSPORT="${MSSQL_TCP_PORT}"
export TDSVER=8.0
export GZIP=-9

"/opt/pgloader-bundle-${PGLOADER_VERSION}/bin/pgloader" <(
  sed "
    s/MSSQL_SA_PASSWORD/${MSSQL_SA_PASSWORD}/g;
    s/MSSQL_IP_ADDRESS/${MSSQL_IP_ADDRESS}/g;
    s/MSSQL_TCP_PORT/${MSSQL_TCP_PORT}/g;
    s/PGUSER/${PGUSER}/g;
    s/PGPASSWORD/${PGPASSWORD}/g;
    s/PGHOST/${PGHOST}/g;
    s/PGPORT/${PGPORT}/g;
  " './loader.initialize'
)

LIST_TABLES_SQL="set nocount on; SELECT TABLE_NAME FROM hazus.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'"

# Need to go table by table because of this issue with pgloader:
#   https://github.com/dimitri/pgloader/issues/337
/opt/mssql-tools/bin/sqlcmd \
  -USA -"P${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" -dhazus \
  -h -1 -Q "${LIST_TABLES_SQL}" |
sort |
while read table_name
do
  # First we drop the geometry columns from the PostgreSQL table
  GEOM_COLS_SQL="
    SET NOCOUNT ON;
    SELECT column_name
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE (
        (table_name = '${table_name}')
        AND
        (data_type = 'geometry')
      )
    ;
  "
  # https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-2017#syntax
  # For each geometry column in MS SQLServer...
  /opt/mssql-tools/bin/sqlcmd \
    -USA -"P${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" -dhazus \
    -s" " -h-1 -W -Q "${GEOM_COLS_SQL}" |
  while read col
  do
    # drop the column from postgres
    psql --dbname=hazus -c "ALTER TABLE hazus.${table_name} DROP COLUMN IF EXISTS ${col};"
  done

  # Get all the non-geometry columns for this table
  NONGEOM_COLS_SQL="
    SET NOCOUNT ON;
    SELECT column_name
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE (
        (table_name = '${table_name}')
        AND
        (data_type <> 'geometry')
      )
    ;
  "

  COLS="$(
    /opt/mssql-tools/bin/sqlcmd \
      -USA -"P${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" -dhazus \
      -s"," -h-1 -W -Q "${NONGEOM_COLS_SQL}"
  )"

  # For outputting to CSV, quote all the column values
  QUOTED_COLS="$(
    echo "$COLS" |
    sed 's/^/QUOTENAME(/g; s/$/,'\''"'\'')/g' |
    tr -s '\n' ',' |
    sed 's/,$//g; s/,/, /g'
  )"
    
  # Turn the newline separated list of NONGEOM_COLS into a comma-separated list
  COLS_LIST="$(
    echo "$COLS" |
    tr -s '\n' ',' |
    sed 's/,$//g; s/,/, /g'
  )"

  ### Transfer the nongeometry data from MSSQL to PostgreSQL ###
  # 1. Dump the MSSQL table to CSV to stdout
  # 2. Stop on the first blank line of the stream (bcp noise after blank lines)
  # 3. Sending streaming CSV to the respective PostgreSQL database table
  /opt/mssql-tools/bin/bcp \
    "select ${QUOTED_COLS} from ${table_name}" \
    queryout "/dev/stdout" -c -t"," -r"\n" \
    -USA -"P${MSSQL_SA_PASSWORD}" -S"${MSSQL_IP_ADDRESS},${MSSQL_TCP_PORT}" -dhazus |
  awk '!NF { exit }; { print }' |
  psql --dbname=hazus -c "COPY hazus.${table_name} (${COLS_LIST}) FROM STDIN CSV;"

done
