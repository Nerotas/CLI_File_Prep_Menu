#!/bin/bash

#Current version is V1 as of 02/01/2018 - NEROTAS

#This sections is for functions. Functions serve as the different codes that can be used. Each one should be self contained. Funcations need to be before the menu.

# This is a simple function template. Avoid spaces in the name.
# function NAME_FUNC
# { command }

function CorruptionDetection_FUNC 
{
python /home/PythonScripts/FFmpeg_CorruptionDetect.py
}

function CorruptionDetectionProxy_FUNC 
{
python /home/PythonScripts/CorruptionDetect_QC_DoubleCheck.py
}

function AssetCheck_FUNC 
{
/home/BashScripts/AssetCheck.command
}


function MojoMezz_FUNC 
{ 
python /home/PythonScripts/FFmpeg_MojoMezz.py    
}

function StandsCon_FUNC 
{ 
/home/BashScripts/FFmpeg_StandardsConform.command
}

function Sub_FUNC 
{ 
/home/BashScripts/FFmpeg_subburnin.command    
}

function InverseTelecine_FUNC 
{ 
/home/BashScripts/FFmpeg_InverseTelecine.command
}

function AudioExtract_FUNC 
{ 
/home/BashScripts/FFmpeg_AudioExtract.command
}

function Loudness_FUNC 
{ 
/home/BashScripts/FFmpeg_Loudness.command
}

function H264_FUNC 
{ 
/home/BashScripts/FFmpeg_h264.command
}

function VUDU_FUNC 
{ 
/home/BashScripts/FFmppeg_VUDU.command
}


#This is mostly for testing since it quick and simple. It's also kinda fun.

function FortuneTelling_FUNC
{ 
fortune | cowsay -f $(ls /usr/share/cowsay/ | shuf -n 1)
    echo "-------------------------------------------------"
}


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
           for each in $(seq 1 20);do
           $E "   x                                                    x"
           done
           WRITE;MARK;TPUT 1 5
           $E "                    FFmpeg MENU                     ";UNMARK;}
           i=0; CLEAR; CIVIS;NULL=/dev/null
   FOOT(){ MARK;TPUT 20 5
           printf "ENTER - SELECT,NEXT                                ";UNMARK;}
  ARROW(){ read -s -n3 key 2>/dev/null >&2
           if [[ $key = $ESC[A ]];then $e up;fi
           if [[ $key = $ESC[B ]];then $e dn;fi;}
     M0(){ TPUT  4 20; $e "Corruption Detection";}
     M1(){ TPUT  5 20; $e "QC Double Check";}
     M2(){ TPUT  6 20; $e "Asset Check";}
     M3(){ TPUT  7 20; $e "Mojo Mezzanine";}
     M4(){ TPUT  8 20; $e "Standards Conform";}
     M5(){ TPUT  9 20; $e "Vudu Transcode";}
     M6(){ TPUT  10 20; $e "Inverse Telecine";}     
     M7(){ TPUT  11 20; $e "Audio Extraction";}
     M8(){ TPUT  12 20; $e "Simple h.264";}
     M9(){ TPUT  13 20; $e "Subtitle Burn-in";}
     M10(){ TPUT  14 20; $e "ERB-128 Audio Loudness";}
     M11(){ TPUT 15 20; $e "Fortune Telling";}
      LM=11
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
        3) S=M3;SC;if [[ $cur == "" ]];then R;MojoMezz_FUNC;ES;fi;;  
        4) S=M4;SC;if [[ $cur == "" ]];then R;StandsCon_FUNC;ES;fi;;
        5) S=M5;SC;if [[ $cur == "" ]];then R;VUDU_FUNC;ES;fi;;
        6) S=M6;SC;if [[ $cur == "" ]];then R;InverseTelecine_FUNC;ES;fi;;
        7) S=M7;SC;if [[ $cur == "" ]];then R;AudioExtract_FUNC;ES;fi;;
        8) S=M8;SC;if [[ $cur == "" ]];then R;H264_FUNC;ES;fi;;
        9) S=M9;SC;if [[ $cur == "" ]];then R;Sub_FUNC;ES;fi;;
        10) S=M10;SC;if [[ $cur == "" ]];then R;Loudness_FUNC;ES;fi;;
        11) S=M11;SC;if [[ $cur == "" ]];then R;FortuneTelling_FUNC;ES;fi;;
 esac;POS;done
}

main_menu