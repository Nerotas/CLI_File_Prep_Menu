#!/bin/bash

#Current version is V2 as of 02/01/2018 - NEROTAS

#This sections is for functions. Functions serve as the different codes that can be used. Each one should be self contained. Funcations need to be before the menu.

# This is a simple function template. Avoid spaces in the name.
# function NAME_FUNC
# { command }

function CorruptionDetection_FUNC
{
    echo "This command will scan a video file for corruption"
            cowsay -f OptimusPrime "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
cowsay -f DarthVader "What Is the title of the asset? Do NOT use any spaces or I will destroy your galaxy!"
read -er assetTitle
echo "-------------------------------------------------"
echo Any red lines of text that appear indicate corruption.
echo "-------------------------------------------------"
FFREPORT=file=/${DataSource}/5_QC/_Logs/"$assetTitle"_CorruptionDetect_%t.log ffmpeg -i "$inputFile" -map 0 -f null -an -y /${DataSource}/2_Transcoding/_TEMP/Dummy.mov
cowsay "Corruption Detection is complete! Any red lines indicate corruption. Moo!"
    echo "-------------------------------------------------"
}

function HardLink_FUNC
{
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
}

function Checksum_FUNC
{
    echo "Beginning Checksum"
cowsay -f turtle "Drag in file and then hit enter to continue:"
read -er inputFile
ls -l $inputFile
openssl "md5" $inputFile
    echo "-------------------------------------------------"
}

function MagickBatch_FUNC
{
echo "This command will elimate alpha channels in .png files"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -alpha set "converted/${f%}.png"; done
cd ./converted
rename .png.png .png *.png
rename .jpeg .png *.jpeg
rename .jpg .png *.jpg
rename .JPG .png *.JPG
    echo "-------------------------------------------------"
}

function ImageResize_FUNC
{ echo "This command will half the size of all image files in the given folder"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -resize 50% "converted/${f%}"; done
}

function GridSearch_FUNC
{
    echo "Type in name to look for and then hit enter to continue:"
read -er inputFile
find /${DataSource}/ -name "*$inputFile*" -print
    echo "-------------------------------------------------"
}

#The Grid Space is the first successful attempt at a submenu. It does require an option to go back to the main menu.

function GridSpace_FUNC
{
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Simple"
echo "  2.) Indepth"
echo "  3.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) du -h --max-depth=1 /${DataSource}/
    echo "-------------------------------------------------"
    ;;
2 ) du -h --max-depth=2 /Volume/MediaGrid/
    echo "-------------------------------------------------"
    ;;
3 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, or 2";tput setf 2;
esac
done
}

function SystemStatus_FUNC
 {
    echo "-------------------------------------------------"
    echo "List of users and processes"
    echo "-------------------------------------------------"
    w;
            echo "-------------------------------------------------"
            echo "Disk Space"
            echo "-------------------------------------------------"
            df -h;
            echo "-------------------------------------------------"
            echo "Network Connections"
             echo "-------------------------------------------------"
            ifconfig -s
           echo "-------------------------------------------------"
        }

#This is mostly for testing since it quick and simple. It's also kinda fun.

function FortuneTelling_FUNC
{
fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n 1)
    echo "-------------------------------------------------"
}

#This is line for the Main Menu. This function allows submenus to return to the main menu.

function main_menu
{
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#(/////////////(#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@&(/////////(((/////////(&@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@&//////(@@@@@@@@@@@@@(//////@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@(////#@@@@@@@@@@@@@@@@@@@#//@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@#////@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@&////@@@@@&(/(&@@@@@@@&(/(&@@@@@&%%%%&@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@&(///@@@@@@/////@@@@@@@/////@@@@@%%%%%%@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@(///#&&@@&(/////(&@@@&(/////(&@@&&&&&&@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@(/////////////////@@@//////////////////@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@/////////////@////(&(////@/////////////@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@(////(@@@(///////(@@@(/////@@///(@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@(//(@@@@@#/////(@@@@@(//(@@#///#@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///@@@@@@@@@@@@(///(@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#(#@@@@@@@@@@@#////@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&(///(@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@&//(#@@@@@@@@@@@@@@@@@&(////#@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@#//////#@@@@@@@@@@@#//////(@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#(/////////////////(#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@((///////((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@&&&@@@@@@&&&@@@@@@@&&&&&&@@@@@@@@@@&&&&&&&@@@@@@&&&&&&&@@@@@@@@@@@@@
@@@@@@@@@@@&%%%@@@@%%%&@@@@@&%%%%%%%%%@@@@@@@@%%%%%%&@@@@&%%%%%%%%%@@@@@@@@@@@@
@@@@@@@@@@@&%@%%%%%%%%&@@@@%%%@@@@@@&%&@@@@@@@@@@@%%&@@@&%%@@@@@@@%&@@@@@@@@@@@
@@@@@@@@@@@&%@@%%%%@&%&@@@@%%&@@@@@@&%&@@@&&&@@@@@%%%@@@%%%@@@@@@@%&@@@@@@@@@@@
@@@@@@@@@@@&%@@@@@@@&%&@@@@%%%%@@@@&%%@@@@@%%&@@@&%%@@@@@%%%@@@@&%%@@@@@@@@@@@@
@@@@@@@@@@@&%@@@@@@@&%&@@@@@@%%%%%%%%@@@@@@%%%%%%%%@@@@@@@%%%%%%%%@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
option=0
until [ "$option" = "10" ]; do
echo "  1.) Corruption Detection"
echo "  2.) Hard Link"
echo "  3.) Checksum"
echo "  4.) Magick Batch"
echo "  5.) Image Resize"
echo "  6.) Grid Search"
echo "  7.) Grid Space"
echo "  8.) System Status"
echo "  9.) Fortune Telling"
echo "  10.) Quit"

echo -n "Enter choice: "
read option
echo ""
case $option in
    1 ) CorruptionDetection_FUNC;;
    2 ) HardLink_FUNC;;
    3 ) Checksum_FUNC;;
    4 ) MagickBatch_FUNC;;
    5 ) ImageResize_FUNC;;
    6 ) GridSearch_FUNC;;
    7 ) GridSpace_FUNC;;
    8 ) SystemStatus_FUNC;;
    9 ) FortuneTelling_FUNC;;
    10 ) exit;;
    * ) tput setf 10;echo "Invalid option.";tput setf 10;
esac
done
 }

main_menu