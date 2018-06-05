#!/bin/bash

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

. utils.sh

IN_DIR="$(readlink -e ../data)"
OUT_DIR="$(readlink -f ../csv)"

mkdir -p "${OUT_DIR}"

SS_NAME='03_NFIP_2018_AIRTSv5_StormSurge_ExposureReport.xlsx'
TABLE_NAME='airtsv5_stormsurge_exposure'

# This sheet really contains a bunch of sub tables.
# We output each of them to a separate CSV.
in2csv --sheet 'AIR TSv5 Exposure Summary' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+11 |
  sed '
    s/\s\+,\|\s\+$/,/g;  # remove trailing spaces
    s/,\+$//g;           # remove trailling commas
  ' |
  while read row; do
    if grep -q '^$' <<< "$row"; then
      # Sometimes there are multiple blank rows
      until ! grep -q '^$' <<< "$row"; do
        # If the current row is not empty, we have the title row.
        read row
      done

      title=$(sed 's/ /_/g; s/,.*//g;' <<< "$row")
      title="${title,,}"

      OUTFILE="${OUT_DIR}/${TABLE_NAME/_exposure}_${title}.csv"

      read header
      # Write the header to the output file, truncating it if it existed.
      sed '
        s/ \+/_/g;  # Spaces to underscores
        s/,\+$//g;  # Get rid of trailing commas
      ' <<< "$header" > "$OUTFILE" 

      # The rest of the enclosing while loop pertains only to data rows,
      #   so onto the next iteration.
      continue
    fi

    # If we haven't hit the first title row yet, continue
    if [[ -z "$title" ]]; then
      continue
    fi

    # Don't output the Total row.
    if grep -q '^Total\|^Grand Total' <<< "$row"; then
      continue
    fi

    # Write the row to the CSV, removing trailing commas
    echo "$row" >> "$OUTFILE"
  done

in2csv --sheet 'AIR TSv5 Occupancy by State' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+9 |
  sed "$SED_CLEAN_TBL_SCRIPT" |
  gzip -9 \
> "${OUT_DIR}/${TABLE_NAME}_by_occupancy_code.csv.gz"

in2csv --sheet 'AIR TSv5 Deductible Profiles' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+9 |
  sed "$SED_CLEAN_TBL_SCRIPT" |
  gzip -9 \
> "${OUT_DIR}/${TABLE_NAME}_building_deductibles.csv.gz"

in2csv --sheet 'AIR TSv5 Deductible Profiles' "${IN_DIR}/${SS_NAME}" 2>/dev/null |
  tail -n+27 |
  sed "$SED_CLEAN_TBL_SCRIPT" |
  gzip -9 \
> "${OUT_DIR}/${TABLE_NAME}_contents_deductibles.csv.gz"

popd >/dev/null
