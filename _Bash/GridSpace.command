#!/bin/bash
    option=0
until [ "$option" = "5" ]; do
echo "  1.) Simple"
echo "  2.) Indepth"
echo "  3.) Packaging"
echo "  4.) Deep Storage"
echo "  5.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) du -h --max-depth=1 --threshold=5M /${DataSource}/
    echo "-------------------------------------------------"
    ;;
2 ) du -h --max-depth=2 --threshold=5M /${DataSource}/ | sort -rh
    echo "-------------------------------------------------"
    ;;
3 ) du -h --max-depth=1 --threshold=5M /${DataSource}/6_Packaging/ | sort -rh
    echo "-------------------------------------------------"
    ;;
4 ) du -h --max-depth=1 --threshold=5M ${Deep Storage Location} | sort -rh
    echo "-------------------------------------------------"
    ;;
5 ) echo "Exiting to main menu" ;;
* ) tput setf 2;echo "Please enter 1 - 5";tput setf 2;
esac
done