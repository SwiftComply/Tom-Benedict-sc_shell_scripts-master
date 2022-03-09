# !/bin/bash

# Script to copy and run the tester_info.py script from city3 to my Windows environment

# Set input and output folder names
while getopts d:y:c: flag; do
    case "${flag}" in
        d) d=${OPTARG};; # DataDir -- directory with the input files to read in
        y) y=${OPTARG};; # Year -- cutoff year being used for the data migration
        c) c=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the script from the WSL git repo to Windows
cp /home/zeke_pfeifer/city3/import/customers/scripts/tester_info.py /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$d

# Run the script with the right flag info
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$d
python tester_info.py $y

# Delete the import scripts from my Windows environment after running them
rm /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/$d/tester_info.py