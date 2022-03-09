# !/bin/bash

# Script to copy and run a custom import script on customer data from WSL to my Windows environment

# Set customer folder name, other variables
# TO DO: Figure out how to use longer shell variable names ... I could only get it to work with one-letter ones
while getopts i:o:l: flag; do
    case "${flag}" in
        i) i=${OPTARG};; # DataDir -- directory with the input files to read in
        o) o=${OPTARG};; # Outputdir -- directory to spit out the migration report CSVs
        l) l=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the current import script from the WSL git repo to Windows
cp -r /home/zeke_pfeifer/city3/import/customers/$l/scripts /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/scripts
go build .

# Run the scripts with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/scripts
./main -datadir=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$o

# Delete the import scripts from my Windows environment after running them
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/scripts
