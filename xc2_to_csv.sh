# !/bin/bash

# Script to copy and run the xc2_to_csv script from city3 to my Windows environment

# Set input and output folder names
while getopts d:o:c: flag; do
    case "${flag}" in
        d) d=${OPTARG};; # DataDir -- directory with the input files to read in
        o) o=${OPTARG};; # Outputdir -- directory to spit out the migration report CSVs
        c) c=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the current import script from the WSL git repo to Windows
cp -r /home/zeke_pfeifer/city3/import/customers/scripts/xc2_to_csv /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/xc2_to_csv
go build .

# Run the scripts with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/xc2_to_csv
./main -datadir=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$d -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$o

# Delete the import scripts from my Windows environment after running them
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/xc2_to_csv