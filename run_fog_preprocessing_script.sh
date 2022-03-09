# !/bin/bash

# Script to copy and run a Python preprocessing script on customer data from WSL to my Windows environment

# Set customer folder name, other variables
# TO DO: Figure out how to use longer shell variable names ... I could only get it to work with one-letter ones
while getopts d:c: flag; do
    case "${flag}" in
        d) d=${OPTARG};; # DataDir -- directory with the input files to read in
        c) c=${OPTARG};; # customer -- directory name for the customer in the city3 repo
    esac
done

# Copy the preprocessing script from the WSL git repo to Windows
cp /home/zeke_pfeifer/city2/vendor/xc2/customers/$c/main.py /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$d

# Run the script
cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$d
python main.py

# Delete the preprocessing script from my Windows environment after running it
rm /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/FOG/$c/$d/main.py
