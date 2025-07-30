#!/bin/bash
    echo "Type in a name to look for and then hit enter to continue."
        echo "-------------------------------------------------"
read -er inputFile
find /${DataSource}/ -iname "*$inputFile*" -print
    echo "-------------------------------------------------"