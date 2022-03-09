# !/bin/bash

 GATOR=true
# SNAKE=false

# # if
# if [ $GATOR ]; then
#   echo "We have a gator"
# fi
logoName=$c"_logo.*"
if [ -e /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/pdf_template/$logoName ]; then
  echo "We have a gator"
else
  echo "We don't have a gator"
fi


# if logo file exists
if [ -e /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/pdf_template/$logoName ]
echo "logo file exists"
else
echo "logo file does NOT exist"
fi