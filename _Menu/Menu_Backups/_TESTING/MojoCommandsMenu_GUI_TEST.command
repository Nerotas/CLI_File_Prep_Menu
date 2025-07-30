#!/bin/bash
# Bash Menu Script Example
HEIGHT=20
WIDTH=40
CHOICE_HEIGHT=6
BACKTITLE="Mojo Commands Menu"
TITLE="Commands"
MENU="Choose one of the following options:"
REPEAT=true

OPTIONS=(1 "Corruption Detection"
         2 "Hard Link"
         3 "Checksum"
         4 "MagickBatch"
         5 "Image Resize"
         6 "Quit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear
case $CHOICE in
        1)
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
            ;;
        2)
            echo "This command will create a hard link of any file on the MediaGrid"
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
            ;;
        3)
            echo "Beginning Checksum"
            echo "Drag in file and then hit enter to continue:"
read -er inputFile
ls -l $inputFile
openssl "md5" $inputFile
            ;;
        4)
echo "This command will elimate alpha channels in .png files "
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
            ;;
        5)
Echo "This command will half the size of all image files in the given folder"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -resize 50% "converted/${f%}"; done
            ;;
        6)
            exit
            ;;
    esac