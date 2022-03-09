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
#mkdir /home/zeke_pfeifer/city3-PDFService/customers/$c
mkdir /Users/tgbpbp/Documents/city3-PDFService/customers/$c
echo "Phase 1 Complete"

# Copy the report form script and the test_data.json files to the PDF Service repo
#cp /home/zeke_pfeifer/city3/import/customers/$c/scripts/survey_pdf_template/custom_survey.go /home/zeke_pfeifer/city3-PDFService/customers/$c
#cp /home/zeke_pfeifer/city3/import/customers/$c/scripts/survey_pdf_template/test_data.json /home/zeke_pfeifer/city3-PDFService/customers/$c
cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/survey_pdf_template/custom_survey.go /Users/tgbpbp/Documents/city3-PDFService/customers/$c
cp /Users/tgbpbp/Documents/GitHub/city3-Implementations/import/customers/$c/scripts/survey_pdf_template/test_data.json /Users/tgbpbp/Documents/city3-PDFService/customers/$c
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
#cd /home/zeke_pfeifer/city3-PDFService/customers/$c
cd /Users/tgbpbp/Documents/city3-PDFService/customers/$c
go run custom_survey.go
echo "Phase 3 Complete"

# Copy the template.json script from the city3-PDFService repo to the right PDFs directory
#cp /home/zeke_pfeifer/city3-PDFService/customers/$c/template.json /home/zeke_pfeifer/PDFs/$c
cp /Users/tgbpbp/Documents/city3-PDFService/customers/$c/template.json /Users/tgbpbp/Documents/PDFs/$c
echo "Phase 4 Complete"

# Build the PDF
#cd /home/zeke_pfeifer/city3-PDFService/cmd
#GO111MODULE=auto go run main.go -in /home/zeke_pfeifer/PDFs/$c/template.json -out /home/zeke_pfeifer/PDFs/$c/survey_$c.pdf -data /home/zeke_pfeifer/city3-PDFService/customers/$c/test_data.json
cd /Users/tgbpbp/Documents/city3-PDFService/cmd
GO111MODULE=auto go run main.go -in /Users/tgbpbp/Documents/PDFs/$c/template.json -out /Users/tgbpbp/Documents/PDFs/$c/survey_$c.pdf -data /Users/tgbpbp/Documents/city3-PDFService/customers/$c/test_data.json
echo "Phase 5 Complete"

# Copy the resulting PDF over to Windows
# cd /home/zeke_pfeifer/PDFs/$c
#cp /home/zeke_pfeifer/PDFs/$c/survey_$c.pdf /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c
#cp /home/zeke_pfeifer/PDFs/$c/template.json /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c
cp /Users/tgbpbp/Documents/PDFs/$c/survey_$c.pdf /Users/tgbpbp/Documents/city_data/$c
cp /Users/tgbpbp/Documents/PDFs/$c/template.json /Users/tgbpbp/Documents/city_data/$c
echo "Phase 6 Complete"

# Delete the PDF script, the template.json and the PDF from your WSL dir
#rm /home/zeke_pfeifer/PDFs/$c/survey_$c.pdf
#rm /home/zeke_pfeifer/PDFs/$c/template.json
rm /Users/tgbpbp/Documents/PDFs/$c/survey_$c.pdf
rm /Users/tgbpbp/Documents/PDFs/$c/template.json
echo "Phase 7 Complete"

# Delete the temporary customer directory from the PDF Service repo
#rm -rf /home/zeke_pfeifer/city3-PDFService/customers/$c
rm -rf /Users/tgbpbp/Documents/city3-PDFService/customers/$c
echo "Phase 8 Complete"
echo "All Done"

# # BELOW IS THE OLD SCRIPT
# # Script to do the following:
# # - Copy the script for creating a template.json file for a new customer's test form PDF to from WSL to my Windows environment
# # - Run the script in my Windows environment
# # - Maybe eventually also automatically put the created template.json file into the proper customer folder in the city3 repo back on my WSL system

# while getopts c: flag; do
#     case "${flag}" in
#         c) c=${OPTARG};; # customer -- directory name for the customer in the city3-PDFService and city3 repos
#     esac
# done

# # Copy the assembly_test_report.go script from the city3-PDFService repo on my WSL system to Windows
# cp /home/zeke_pfeifer/city3-PDFService/customers/$c/assembly_test_report.go /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c

# # Build the Go scripts into a single executable
# cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c
# go build assembly_test_report.go

# # Run the script
# cd /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c
# ./assembly_test_report

# # Delete the PDF script from my Windows environment after running it
# rm /mnt/c/Users/Zeke\ Pfeifer/Documents/city_data/$c/assembly_test_report.go