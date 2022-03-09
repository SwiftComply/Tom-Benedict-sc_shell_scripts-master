# !/bin/bash

# Script to copy over the latest code for the form_builder (and, critically, the latest form_field_types.json file) to my Windows system and run it

rm -r /mnt/c/Users/Zeke\ Pfeifer/Documents/form_builder

cp -r /home/zeke_pfeifer/city3/tools/form_builder /mnt/c/Users/Zeke\ Pfeifer/Documents/

cd /mnt/c/Users/Zeke\ Pfeifer/Documents/form_builder
go run form_builder.go
