#!/bin/bash
echo "This command will create a hard link of any file on the MediaGrid"
            cowsay -f dragon "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
cowsay -f dragon "Where do you want the hard link to go"
read -er finaldirectory
echo "-------------------------------------------------"
echo Creating hard link now!.
echo "-------------------------------------------------"
ln --verbose "$inputFile" "$finaldirectory"
cowsay -f dragon "IMPORTANT!!! A Hard link is the same as the original file! Anything you do to the link will happen to the original too!!!!!!!!" 
    echo "-------------------------------------------------"