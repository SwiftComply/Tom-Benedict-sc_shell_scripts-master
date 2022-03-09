# !/bin/bash

# Script to copy and run the compare_testers script from the city3 repo to my Windows environment

# Set input and output folder names
while getopts d:f:c: flag; do
    case "${flag}" in
        d) d=${OPTARG};; # DataDir -- directory with the input files to read in (both new testers -- 'testers.csv' -- and the existing testers file)
        f) f=${OPTARG};; # ExistingTestersFilename -- name of CSV file with existing tester data
        c) c=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the current import script from the WSL git repo to Windows
cp -r /home/zeke_pfeifer/city3/import/customers/scripts/compare_testers /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/compare_testers
go build .

# Run the scripts with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/compare_testers
./main -datadir=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$d -filename=$f

# Delete the import scripts from my Windows environment after running them
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/compare_testers