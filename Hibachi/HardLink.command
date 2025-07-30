#!/bin/bash
cowsay -f dragon "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
cowsay -f vader-koala "Where do you want the hard link to go"
read -er finaldirectory
echo "-------------------------------------------------"
echo Creating hard link now!.
echo "-------------------------------------------------"

ln --verbose "$inputFile" "$finaldirectory"

cowsay -f turtle "IMPORTANT!!! A Hard link is the same as the original file! Anything you do to the link will happen to the original too!!!!!!!!"

read -n 1 -p "Would you like to repeat or exit? (R/E) " ans;

case $ans in
    r|R)
        ./HardLink.command;;
    *)
        exit;;
esac
