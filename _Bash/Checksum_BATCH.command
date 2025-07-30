#!/bin/bash
echo "Checksum Options"
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Single"
echo "  2.) Batch"
echo "  3.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) 
    echo "Beginning Checksum"
cowsay -f turtle "Drag in file and then hit enter to continue:"
read -er inputFile
ls -l $inputFile
openssl "md5" $inputFile
    echo "-------------------------------------------------"
    ;;
2)
    echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
ls -l
for f in *; do openssl "md5" "$f"; done
;;
3 ) echo "Exiting to main menu" ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2; 
esac
done