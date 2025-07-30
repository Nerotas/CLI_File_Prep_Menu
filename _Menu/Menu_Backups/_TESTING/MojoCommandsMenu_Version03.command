#/bin/bash

#Current version is V3 as of 02/08/2018 - NEROTAS

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
for f in *; do openssl "md5" "$f"; done
;;
3 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2;
esac
done
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
{
echo "This command will half the size of all image files in the given folder"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -resize 50% "converted/${f%}"; done
}

function GridSearch_FUNC
{
    echo "Type in a name to look for and then hit enter to continue. Search is case sensitive, Alex!!"
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
1 ) du -h --max-depth=1 --threshold=5M /${DataSource}/
    echo "-------------------------------------------------"
    ;;
2 ) du -h --max-depth=2 --threshold=5M /${DataSource}/
    echo "-------------------------------------------------"
    ;;
3 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2;
esac
done
}

function Proxy_FUNC
{
option=0
until [ "$option" = "3" ]; do
echo " What is framerate of the asset?"
echo "  1.) 23.98"
echo "  2.) 24"
echo "  3.) 25"
echo "  4.) 29.97"
echo "  5.) Exit to Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ln --verbose $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_2398_TimeCode/
echo "-------------------------------------------------"
echo  "Proxy has started! Proxy take between 45 minutes and an hour. Proxy will be in the 8_Proxy folder when finished."
echo "-------------------------------------------------"
    ;;
2 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ln --verbose $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_24_TimeCode/
echo "-------------------------------------------------"
echo "Proxy has started! Proxy take between 45 minutes and an hour. Proxy will be in the 8_Proxy folder when finished."
echo "-------------------------------------------------"
    ;;
 3 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ln --verbose $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_25_TimeCode/
echo "-------------------------------------------------"
echo "Proxy has started! Proxy take between 45 minutes and an hour. Proxy will be in the 8_Proxy folder when finished."
echo "-------------------------------------------------"
    ;;
 4 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ln --verbose $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_2997_TimeCode/
echo "-------------------------------------------------"
echo "Proxy has started! Proxy take between 45 minutes and an hour. Proxy will be in the 8_Proxy folder when finished."
echo "-------------------------------------------------"
    ;;
5 ) main_menu ;;
* ) tput setf 5;echo "Please enter 1 - 5";tput setf 5;
esac
done
}

function SystemStatus_FUNC
 {
            echo "-------------------------------------------------"
            echo "Disk Space"
            echo "-------------------------------------------------"
            df -h;
            echo "-------------------------------------------------"
            echo "Network Connections"
             echo "-------------------------------------------------"
            ifconfig -s;
           echo "-------------------------------------------------"
    echo "List of users and processes"
    echo "-------------------------------------------------"
    w;
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
      E='echo -e';e='echo -en';trap "R;exit" 2
    ESC=$( $e "\e")
   TPUT(){ $e "\e[${1};${2}H";}
  CLEAR(){ $e "\ec";}
  CIVIS(){ $e "\e[?25l";}
   DRAW(){ $e "\e%@\e(0";}
  WRITE(){ $e "\e(B";}
   MARK(){ $e "\e[7m";}
 UNMARK(){ $e "\e[27m";}
       R(){ CLEAR ;stty sane;};
   HEAD(){ DRAW
           for each in $(seq 1 18);do
           $E "   x                                          x"
           done
           WRITE;MARK;TPUT 1 5
           $E "MOJO SELECTION MENU                       ";UNMARK;}
           i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 18 5
           printf "ENTER - SELECT,NEXT                       ";UNMARK;}
  ARROW(){ read -s -n3 key 2>/dev/null >&2
           if [[ $key = $ESC[A ]];then $e up;fi
           if [[ $key = $ESC[B ]];then $e dn;fi;}
     M0(){ TPUT  4 20; $e "Corruption Detection";}
     M1(){ TPUT  5 20; $e "Hard Link";}
     M2(){ TPUT  6 20; $e "Checksum";}
     M3(){ TPUT  7 20; $e "Magick Batch";}
     M4(){ TPUT  8 20; $e "Image Resize";}
     M5(){ TPUT  9 20; $e "Grid Seach";}
     M6(){ TPUT 10 20; $e "Grid Space";}
     M7(){ TPUT 11 20; $e "Proxy Create";}
     M8(){ TPUT 12 20; $e "System Status";}
     M9(){ TPUT 13 20; $e "Fortune Telling";}
     M10(){ TPUT 14 20; $e "ABOUT   ";}
      LM=10
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
     ES(){ MARK;$e "ENTER = main menu ";$b;read;INIT;};INIT
    while [[ "$O" != " " ]]; do case $i in
        0) S=M0;SC;if [[ $cur == "" ]];then R;CorruptionDetection_FUNC;ES;fi;;
        1) S=M1;SC;if [[ $cur == "" ]];then R;HardLink_FUNC;ES;fi;;
        2) S=M2;SC;if [[ $cur == "" ]];then R;Checksum_FUNC;ES;fi;;
        3) S=M3;SC;if [[ $cur == "" ]];then R;MagickBatch_FUNC;ES;fi;;
        4) S=M4;SC;if [[ $cur == "" ]];then R;ImageResize_FUNC;ES;fi;;
        5) S=M5;SC;if [[ $cur == "" ]];then R;GridSearch_FUNC;ES;fi;;
        6) S=M6;SC;if [[ $cur == "" ]];then R;GridSpace_FUNC;ES;fi;;
        7) S=M7;SC;if [[ $cur == "" ]];then R;Proxy_FUNC;ES;fi;;
        8) S=M8;SC;if [[ $cur == "" ]];then R;SystemStatus_FUNC;ES;fi;;
        9) S=M9;SC;if [[ $cur == "" ]];then R;FortuneTelling_FUNC;ES;fi;;
        10) S=M10;SC;if [[ $cur == "" ]];then R;$e "\n$($e Template by oTo. Menu built by N. Erotas and is current as of 02/08/2018.)\n";ES;fi;;
 esac;POS;done
}

main_menu
