#!/bin/bash
echo "Drag in ITMSP and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputITMSP
echo "-------------------------------------------------"
echo "Who is the provider? Use provider name from the 3rd line of the iTunes metadata"
read -er inputProvider
echo "-------------------------------------------------"
echo "Name the output log. Format should be: PROVIDER_TITLE_YEAR_MONTH_DAY"
read -er inputLog
echo "-------------------------------------------------"
echo "Set the upload speed in kilobytes (10000-100000)"
read -er inputSpeed
echo "-------------------------------------------------"
/usr/local/itms/bin/iTMSTransporter -u upload@mojomakers.com -p 1990Mojo -m upload -f $inputITMSP -v eXtreme -s $inputProvider -o /${DataSource}/6_Packaging/_Itunes_Upload_Logs/$inputLog.txt -t Aspera -k $inputSpeed
