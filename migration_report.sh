# !/bin/bash

# Script to move the migration_report scripts from WSL to my Windows environment so I can run them on customer data

# Set customer name, other variables
# TO DO: Figure out how to use longer shell variable names ... I could only get it to work with one-letter ones
while getopts i:c:f:l: flag; do
    case "${flag}" in
        i) i=${OPTARG};; # XMLdir -- directory with the XML files to read in
        c) c=${OPTARG};; # CSVdir -- directory with the CSV files to count
        f) f=${OPTARG};; # fromdate -- the cutoff date requested by the customer
        l) l=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the current migration report scripts from the WSL git repo to Windows
# cp -r /home/zeke_pfeifer/city3/import/customers/scripts/migration_report /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts
cp -r /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/scripts/migration_report /Users/tgbpbp/Documents/conversion_scripts

# Copy the config file into the right directory on the Windows file system
# cp /home/zeke_pfeifer/city3/import/customers/$l/config.yaml /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i
cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$l/config.yaml /Users/tgbpbp/Documents/city_data/$l/$i

# Build the Go scripts into a single executable
# cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/migration_report
cd /Users/tgbpbp/Documents/conversion_scripts/migration_report
go build .

# Run the scripts with the right flag info
# cd /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/migration_report
# ./main -xml=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$i -csv=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l/$c -out=/mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$l -fromdate=$f
cd /Users/tgbpbp/Documents/conversion_scripts/migration_report
./main -xml=/Users/tgbpbp/Documents/city_data/$l/$i -csv=/Users/tgbpbp/Documents/city_data/$l/$c -out=/Users/tgbpbp/Documents/city_data/$l -fromdate=$f

# Delete the migration report scripts from my Windows environment after running them
# rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/conversion_scripts/migration_report
rm -r /Users/tgbpbp/Documents/conversion_scripts/migration_report