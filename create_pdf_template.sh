# !/bin/bash
# Script to do the following: Run the relevant test report script to create a PDF template and sample PDF for a backflow customer
# 3/8/21 TGB Add optional image file name argument
while getopts c:l: flag; do
    case "${flag}" in
        c) c=${OPTARG};; # customer -- directory name for the customer in and city3 repo  
        l) l=${OPTARG};; # logo  -- file name for the image file (file name of customer's logo)
    esac
done

# Create a temporary directory for the customer in the PDF Service repo
mkdir /Users/tgbpbp/Documents/city3-PDFService/customers/$c
echo "Phase 1 Complete"

# Copy the report form script and the test_data.json files to the PDF Service repo
cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/pdf_template/custom_test_report.go /Users/tgbpbp/Documents/city3-PDFService/customers/$c
cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/pdf_template/test_data.json /Users/tgbpbp/Documents/city3-PDFService/customers/$c
echo "Phase 2 Complete"

# if image file name was passed (file name of customer's logo)
if [ $# -eq 4 ] 
then
   # Copy the logo image file from the pdf_template directory to the /tmp/pdf-images directory 
    mkdir -p /tmp/pdf-images
    cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/pdf_template/$l /tmp/pdf-images
    echo "Phase 2a Complete"
fi

# Create the template.json
cd /Users/tgbpbp/Documents/city3-PDFService/customers/$c
go run custom_test_report.go
echo "Phase 3 Complete"

# Copy the template.json script from the city3-PDFService repo to the right PDFs directory
cp /Users/tgbpbp/Documents/city3-PDFService/customers/$c/template.json /Users/tgbpbp/Documents/PDFs/$c
echo "Phase 4 Complete"

# Build the PDF
cd /Users/tgbpbp/Documents/city3-PDFService/cmd
GO111MODULE=auto go run main.go -in /Users/tgbpbp/Documents/PDFs/$c/template.json -out /Users/tgbpbp/Documents/PDFs/$c/$c.pdf -data /Users/tgbpbp/Documents/city3-PDFService/customers/$c/test_data.json
echo "Phase 5 Complete"

# Copy the resulting PDF over to Windows
# cd /home/zeke_pfeifer/PDFs/$c
cp /Users/tgbpbp/Documents/PDFs/$c/$c.pdf /Users/tgbpbp/Documents/city_data/$c
cp /Users/tgbpbp/Documents/PDFs/$c/template.json /Users/tgbpbp/Documents/city_data/$c
echo "Phase 6 Complete"

# Delete the PDF script, the template.json and the PDF from your WSL dir
rm /Users/tgbpbp/Documents/PDFs/$c/$c.pdf
rm /Users/tgbpbp/Documents/PDFs/$c/template.json
echo "Phase 7 Complete"

# Delete the temporary customer directory from the PDF Service repo
rm -rf /Users/tgbpbp/Documents/city3-PDFService/customers/$c
echo "Phase 8 Complete"
echo "All Done"


# bash create_pdf_template.sh -c fayetteville_nc
#