#!/bin/bash

#Current version is V3 as of 02/08/2018 - NEROTAS

#This sections is for functions. Functions serve as the different codes that can be used. Each one should be self contained. Funcations need to be before the menu.

# This is a simple function template. Avoid spaces in the name.
# function NAME_FUNC
# { command }

function CorruptionDetection_FUNC 
{
python /mnt/DATA/Scripts/Mojo/_Python/FFmpeg_CorruptionDetect.py
}

function CorruptionDetectionProxy_FUNC 
{
python /mnt/DATA/Scripts/Mojo/_Python/CorruptionDetect_QC_DoubleCheck.py
}

function AssetCheck_FUNC 
{
/mnt/DATA/Scripts/Mojo/_Bash/AssetCheck.command
}

function Validate_FUNC
{
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Automatic"
echo "  2.) Manual"
echo "  3.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) python /mnt/DATA/Scripts/Mojo/_Python/MojoValidator.py
    ;;
2 ) /mnt/DATA/Scripts/Mojo/_Bash/MojoValidator.command
    ;;
3 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2; 
esac
done
}

function HardLink_FUNC
{            
python /mnt/DATA/Scripts/Mojo/_Python/Hardlink.py
}

function QUICKCOPY_FUNC
{
python /mnt/DATA/Scripts/Mojo/_Python/CopyFile.py
}

function Checksum_FUNC
{
/mnt/DATA/Scripts/Mojo/_Bash/Checksum.command
}

function Tar_FUNC
{ 
/mnt/DATA/Scripts/Mojo/_Bash/Tarballer.command
}

function ImageResize_FUNC
{ 
/mnt/DATA/Scripts/Mojo/_Bash/ImagesMenu.command
}

function GridSearch_FUNC
{
python /mnt/DATA/Scripts/Mojo/_Python/GridSearch.py
}

#The Grid Space is the first successful attempt at a submenu. It does require an option to go back to the main menu.

function GridSpace_FUNC
{
/mnt/DATA/Scripts/Mojo/_Bash/GridSpace.command
}

function Proxy_FUNC
{    
python /mnt/DATA/Scripts/Mojo/_Python/ProxyMaker.py
}

function UPLOAD_FUNC
{
echo "Do you wish upload an ITMSP package to iTunes?"
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Auto upload"
echo "  2.) Manual upload"
echo "  3.) Status Check"
echo "  4.) Exit to Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) python /mnt/DATA/Scripts/Mojo/_Python/MojoUploader.py
    ;;
2 ) /mnt/DATA/Scripts/Mojo/_Bash/MojoTransporter.command
    ;;    
3 ) python /mnt/DATA/Scripts/Mojo/_Python/MojoiTunesStatus.py
    ;;        
4 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2; 
esac
done
}

function LogSearch_FUNC
{
/mnt/DATA/Scripts/Mojo/_Bash/LogSearch.command
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

function INSTALL_FUNC
{
echo "FFmpeg Installer"
    option=0
until [ "$option" = "3" ]; do
echo "  1.) Yes"
echo "  2.) No"
echo "Are you sure? You cannot interupt the process once it starts!!"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) /mnt/DATA/Scripts/Mojo/_Bash/FFmpeg_InstallCentOS_V2.command
    ;;
2 ) main_menu ;;
* ) tput setf 2;echo "Please enter 1, or 2";tput setf 2; 
esac
done
}

#This is mostly for testing since it quick and simple. It's also kinda fun.

function FortuneTelling_FUNC
{ 
fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n 1)
    echo "-------------------------------------------------"
}

function ABOUT_FUNC
{
python /mnt/DATA/Scripts/Mojo/_Python/About.py
}

#This is line for the Main Menu. This function allows submenus to return to the main menu.
#The size L/R can be increased by adding spaces under the HEAD & FOOT sections
#T/B size can be increased by the "FOOT(){ MARK;TPUT # 5" line
# Whenever a new section is added, the M#, TPUT, LM=, lines MUST be increased. M# lines under the "while" section also needs to be increased.

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
           for each in $(seq 1 26);do
           $E "   x                                                    x"
           done
           WRITE;MARK;TPUT 1 5
           $E "MOJO SELECTION MENU                                ";UNMARK;}
           i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 26 5
           printf "ENTER - SELECT,NEXT                                ";UNMARK;}
  ARROW(){ read -s -n3 key 2>/dev/null >&2
           if [[ $key = $ESC[A ]];then $e up;fi
           if [[ $key = $ESC[B ]];then $e dn;fi;}
     M0(){ TPUT  4 20; $e "Corruption Detection";}
     M1(){ TPUT  5 20; $e "QC Double Check";}
     M2(){ TPUT  6 20; $e "Asset Check";}
     M3(){ TPUT  7 20; $e "ITMSP Validator";}
     M4(){ TPUT  8 20; $e "Hard Link";}
     M5(){ TPUT  9 20; $e "Quick Copy";}     
     M6(){ TPUT  10 20; $e "Checksum";}
     M7(){ TPUT  11 20; $e "Tar Package";}
     M8(){ TPUT  12 20; $e "Image Resize";}
     M9(){ TPUT  13 20; $e "Grid Search";}
     M10(){ TPUT 14 20; $e "Grid Space";}
     M11(){ TPUT 15 20; $e "Proxy Create";}
     M12(){ TPUT 16 20; $e "iTunes Uploader";}
     M13(){ TPUT 17 20; $e "Aspera Log Search";}
     M14(){ TPUT 18 20; $e "System Status";}
     M15(){ TPUT 19 20; $e "FFmpeg Installer";}
     M16(){ TPUT 20 20; $e "Fortune Telling";}
     M17(){ TPUT 21 20; $e "ABOUT   ";}
      LM=17
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
        1) S=M1;SC;if [[ $cur == "" ]];then R;CorruptionDetectionProxy_FUNC;ES;fi;;
        2) S=M2;SC;if [[ $cur == "" ]];then R;AssetCheck_FUNC;ES;fi;;       
        3) S=M3;SC;if [[ $cur == "" ]];then R;Validate_FUNC;ES;fi;;  
        4) S=M4;SC;if [[ $cur == "" ]];then R;HardLink_FUNC;ES;fi;;
        5) S=M5;SC;if [[ $cur == "" ]];then R;QUICKCOPY_FUNC;ES;fi;;
        6) S=M6;SC;if [[ $cur == "" ]];then R;Checksum_FUNC;ES;fi;;
        7) S=M7;SC;if [[ $cur == "" ]];then R;Tar_FUNC;ES;fi;;
        8) S=M8;SC;if [[ $cur == "" ]];then R;ImageResize_FUNC;ES;fi;;
        9) S=M9;SC;if [[ $cur == "" ]];then R;GridSearch_FUNC;ES;fi;;
        10) S=M10;SC;if [[ $cur == "" ]];then R;GridSpace_FUNC;ES;fi;;
        11) S=M11;SC;if [[ $cur == "" ]];then R;Proxy_FUNC;ES;fi;;
        12) S=M12;SC;if [[ $cur == "" ]];then R;UPLOAD_FUNC;ES;fi;;
        13) S=M13;SC;if [[ $cur == "" ]];then R;LogSearch_FUNC;ES;fi;;
        14) S=M14;SC;if [[ $cur == "" ]];then R;SystemStatus_FUNC;ES;fi;;
        15) S=M15;SC;if [[ $cur == "" ]];then R;INSTALL_FUNC;ES;fi;;
	      16) S=M16;SC;if [[ $cur == "" ]];then R;FortuneTelling_FUNC;ES;fi;;
        17) S=M17;SC;if [[ $cur == "" ]];then R;ABOUT_FUNC;ES;fi;;
 esac;POS;done
}

main_menu
 