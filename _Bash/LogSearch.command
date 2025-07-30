#!/bin/bash
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Simple. Look for names of logs."
echo "  2.) Indepth. Look for information inside logs"
echo "  3.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) echo "Type in a name to look for it on the Aspera Log Server. Search is case sensitive!"
    echo "-------------------------------------------------"
	read -er inputFile
	find /Volumes/LOGS/ -name "*$inputFile*" -print
    echo "-------------------------------------------------"
    echo "Search has finished"
    echo "-------------------------------------------------"
    ;;
2 ) echo "Type in a name to look for it on the Aspera Log Server."
    echo "This command is not case sensitive and will read each individual log."
    echo "This command will take a long a time to complete."
    echo "-------------------------------------------------"
	read -er inputFile
	grep -Ri "$inputFile" /Volumes/LOGS/
    echo "-------------------------------------------------"
    echo "Search has finished"
    echo "-------------------------------------------------"
    ;;
3 ) echo "Exiting to main menu" ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2;
esac
done