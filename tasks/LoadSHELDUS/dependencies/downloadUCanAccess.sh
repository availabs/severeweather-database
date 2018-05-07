#!/bin/bash

# NOTE: The accdb database contained in the 2014_SHMP_SHELDUS_Files.zip contains redundant data.
#       It is ignored.
#       The steps to view the accdb file in Linux are preserved here for future reference.
# REFERENCE: https://askubuntu.com/questions/187389/is-it-possible-to-open-an-access-2010-database-file-without-using-wine-or-virtua/519571

set -e

pushd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null

URL='https://downloads.sourceforge.net/project/ucanaccess/UCanAccess-4.0.4-bin.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fucanaccess%2Ffiles%2FUCanAccess-4.0.4-bin.zip%2Fdownload&ts=1525658281'
FILE_NAME='UCanAccess-4.0.4-bin.zip'

LIB_DIR="$(readlink -f ../lib)"
mkdir -p "$LIB_DIR"

curl "$URL" > "${LIB_DIR}/$FILE_NAME"

popd >/dev/null
