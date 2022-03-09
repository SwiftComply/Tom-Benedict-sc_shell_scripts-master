# !/bin/bash

# Script to convert a CSV of tester data from one of our enrollment forms to CSVs for import to the city3 DB

# Set customer folder name, other variables
# TO DO: Figure out how to use longer shell variable names ... I could only get it to work with one-letter ones
while getopts i:o:f:l: flag; do
    case "${flag}" in
        i) i=${OPTARG};; # DataDir -- directory with the input files to read in
        o) o=${OPTARG};; # Outputdir -- directory to spit out the migration report CSVs
        f) f=${OPTARG};; # FileName -- name of the testers CSV file
        l) l=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the import script from the WSL git repo to the correct customer folder in my Windows environment
cp -r /home/zeke_pfeifer/city3/import/customers/scripts/import_testers /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/import_testers
go build .

# Run the script with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/import_testers
./main -datadir=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$o -filename=$f

# Delete the import script from my Windows environment after running it
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/import_testers