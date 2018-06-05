#!/bin/bash

SED_CLEAN_TBL_SCRIPT='
  1 s/#/num/g;                 # Replace "#" with "num"
  1 s/\*\|\.\|\///g;           # Remove asterisks, dots, or backslashes from column names.
  1 s/\s\+/_/g;                # Spaces to underscore in column names.
  s/\s+,\|\s+$/,/g;            # Remove trailing white spaces everywhere
  /^Total\|^Grand Total/,$d;   # Delete the Total row, and all subsequent rows.
'

export SED_CLEAN_TBL_SCRIPT
