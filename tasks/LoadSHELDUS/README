# Instructions

## Create the CSVs
1. `./bin/hazard_loss.2csv.sh`
2. `./bin/hazards_loss_1960_2012_SHELDUS.2csv.sh`
3. `./bin/SHELDUS_NY_1960_2012.2csv.sh`

# Clean up the CSVs
1. `./bin/deleteNoDataCSVs.sh`
2. `./bin/removeExtraColumnFromHazardsLossXHeat.sh`

# Generate the SQL & Bash
1. `./bin/generateTableDDLFiles.sh`

# Wrap up
1. # inspect the generated SQL and Bash files.
2. `mv csv ../../data/sheldus`
3. `mv tmp-sql ../../sql/sheldus`
4. find ../../sql/sheldus -type f -name 'loader.sh' -exec {} \;
