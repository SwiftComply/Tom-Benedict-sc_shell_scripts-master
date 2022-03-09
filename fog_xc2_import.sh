# !/bin/bash

# Script to move the XC2 migration scripts from WSL to my Windows environment so I can run them on customer data

# Set customer name to grab their config.yaml
while getopts i:o:f:c:s:p: flag; do
    case "${flag}" in
        i) i=${OPTARG};; # DataDir -- directory with the input files to read in
        o) o=${OPTARG};; # Outputdir -- directory to spit out the migration report CSVs
        f) f=${OPTARG};; # FromDate -- starting date we should import data from YYYY-MM-DD (required)
        c) c=${OPTARG};; # customer -- directory name for the customer in all the various places
        s) s=${OPTARG};; # stage -- stage one or two of the import script ('1' or '2') (required)
        p) p=${OPTARG};; # prefix -- customer reference number prefix, needed for the fse permit import (required)
    esac
done

# Copy the current migration scripts from the WSL git repo to Windows
cp -r /home/zeke_pfeifer/city2/vendor/xc2/import /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts

# Copy the config file into the right directory on the Windows file system
cp /home/zeke_pfeifer/city2/vendor/xc2/customers/$c/config.yaml /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$i

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/import
go build

# Run the scripts with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/import
./main -in=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$i -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$o -fromdate=$f -stage=$s -prefix=$p

# Delete the xc2 import scripts from my Windows environment after running them
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/import

