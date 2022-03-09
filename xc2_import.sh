# !/bin/bash

# Script to move the XC2 migration scripts from WSL to my Windows environment so I can run them on customer data

# Set customer name to grab their config.yaml
while getopts i:o:f:c:l: flag; do
    case "${flag}" in
        i) i=${OPTARG};;
        o) o=${OPTARG};;
        f) f=${OPTARG};;
        c) c=${OPTARG};;
        l) l=${OPTARG};;
    esac
done

# Copy the current migration scripts from the WSL git repo to Windows
cp -r /home/zeke_pfeifer/city3/import/xc2 /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts

# Copy the config file into the right directory on the Windows file system
cp /home/zeke_pfeifer/city3/import/customers/$l/config.yaml /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i

# Build the Go scripts into a single executable
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/xc2
go build

# Run the scripts with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/xc2
./main -in=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$o -fromdate=$f -country=$c

# Delete the xc2 import scripts from my Windows environment after running them
rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/xc2

