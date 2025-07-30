#!/bin/bash

#Current version is V1 as of 02/01/2018 - NEROTAS

#This sections is for functions. Functions serve as the different codes that can be used. Each one should be self contained. Funcations need to be before the menu.

# This is a simple function template. Avoid spaces in the name.
# function NAME_FUNC
# { command }

function CorruptionDetectionProxy_FUNC
{
    echo "This command will scan a video file for corruption"
            cowsay -f OptimusPrime "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
ln -v $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/CorruptionDetectProxies
cowsay -f DarthVader "What Is the title of the asset? Do NOT use any spaces or I will destroy your galaxy!"
read -er assetTitle
echo "-------------------------------------------------"
echo Any red lines of text that appear indicate corruption.
echo "-------------------------------------------------"
FFREPORT=file=/${DataSource}/5_QC/_Logs/"$assetTitle"_CorruptionDetect_%t.log ffmpeg -i "$inputFile" -map 0:v -f null -an -y /dev/null/
cowsay "Corruption Detection is complete! Any red lines indicate corruption. Moo!"
    echo "-------------------------------------------------"
}

function MojoMezz_FUNC
{
python /home/PythonScripts/FFmpeg_MojoMezz.py
#echo "This command will procuce an Apple Pro Res 422 (HQ) file with PCM audio."
#echo "Drag in video file and then hit enter to continue:"
#echo "-------------------------------------------------"
#read -er inputFile
#ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -c:a pcm_s24be -y "${inputFile%.*}_FFmpeg.mov"
#echo "-------------------------------------------------"
#echo "Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!"
#echo "${inputFile%.*}_FFmpeg.mov"
#echo "-------------------------------------------------"
}

function Sub_FUNC
{
echo "This command will burn subtitles into a Mojo Mezz file."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "Drag in subtitle file (.ass) and then hit enter to continue:"
echo "-------------------------------------------------"
read -er subtitle
ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -vf subtitles="$subtitle" -c:a copy -sn -y "${inputFile%.*}_enSUB_FFmpeg.mov"
echo "-------------------------------------------------"
echo "Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!"
echo "${inputFile%.*}_enSUB_FFmpeg.mov"
echo "-------------------------------------------------"
}

function InverseTelecine_FUNC
{
echo "This command will convert a 29.97 interlaced asset into a 23.98 progressive Apple Pro Res 422 (HQ) file with PCM audio."
echo "Any cropping needed in Compressor should be done before running this command,"
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
# pass 1
ffmpeg -i $inputFile -map 0:v -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 00:00:00:00 -vf yadif -map 0:a -c:a pcm_s24be -y "${inputFile%.*}_TEMP_Pass01.mov"
# pass 2
ffmpeg -i "${inputFile%.*}_TEMP_Pass01.mov" -map 0:v -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 00:00:00:00 -vf decimate -map 0:a -c:a pcm_s24be -y "${inputFile%.*}_InverseTelecine.mov"
echo "-------------------------------------------------"
echo "Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!"
echo "${inputFile%.*}_InverseTelecine.mov"
echo "-------------------------------------------------"
rm "${inputFile%.*}_TEMP_Pass01.mov"
}

function AudioExtract_FUNC
{
echo "This command will extract all audio from a muxed file."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -vn -map 0:a -c:a copy -y "${inputFile%.*}_AudioOnly.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_AudioOnly.mov"
echo "-------------------------------------------------"
}

function Loudness_FUNC
{
echo "This command will normailze audio to ERB-128 standards without touching video."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v copy -c:a pcm_s24be -af loudnorm -ar 48000 -y "${inputFile%.*}_Normalized.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_Normalized.mov"
echo "-------------------------------------------------"
}

function H264_FUNC
{
echo "This command will procuce a h.264 file with stereo AAC audio. Working on added more audio options."
echo "Audio Layout?"
    option=0
until [ "$option" = "4" ]; do
echo "  1.) Stereo"
echo "  2.) 2CH"
echo "  3.) 8CH"
echo "  4.) Return to Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v libx264 -preset medium -c:a libfdk_aac -b:a 192k -y "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
;;
2 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -filter_complex "[0:1][0:2]amerge=inputs=2[aout]" -map 0:v -c:v libx264 -preset medium  -map "[aout]" -c:a libfdk_aac -ac 2 -b:a 192k -y "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
;;
3 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -filter_complex "[0:7][0:8]amerge=inputs=2[aout]" -map 0:v -c:v libx264 -preset medium  -map "[aout]" -c:a libfdk_aac -ac 2 -b:a 192k -y "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mp4"
echo "-------------------------------------------------"
;;
4 ) main_menu
;;
*) echo "Invaild Option"
;;
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

function AssetStatus_FUNC
 {
echo "This command will give you a basic read out of the asset's stats"
echo "-------------------------------------------------"
echo "Drag in video file and then hit enter to continue:"
read -er inputFile
ffmpeg -hide_banner -i "$inputFile"
echo "-------------------------------------------------"
}


#This is mostly for testing since it quick and simple. It's also kinda fun.

function FortuneTelling_FUNC
{
fortune | cowsay -f $(ls /usr/share/cowsay/ | shuf -n 1)
    echo "-------------------------------------------------"
}

#This is line for the Main Menu. This function allows submenus to return to the main menu.

function main_menu
{
echo -E "
..................................................................
::'########:'########:'##::::'##:'########::'########::'######::::
:: ##.....:: ##.....:: ###::'###: ##.... ##: ##.....::'##... ##:::
:: ##::::::: ##::::::: ####'####: ##:::: ##: ##::::::: ##:::..::::
:: ######::: ######::: ## ### ##: ########:: ######::: ##::'####::
:: ##...:::: ##...:::: ##. #: ##: ##.....::: ##...:::: ##::: ##:::
:: ##::::::: ##::::::: ##:.:: ##: ##:::::::: ##::::::: ##::: ##:::
:: ##::::::: ##::::::: ##:::: ##: ##:::::::: ########:. ######::::
::..::::::::..::::::::..:::::..::..:::::::::........:::......:::::"
option=0
until [ "$option" = "10" ]; do
echo "  1.) Corruption Detection With Proxy"
echo "  2.) Mojo Mezzanine Pro Res"
echo "  3.) Subtitle Burn-in"
echo "  4.) Inverse Telecine"
echo "  5.) Audio Extraction"
echo "  6.) Simple h.264"
echo "  7.) ERB-128 Audio Loudness"
echo "  8.) Asset Status"
echo "  9.) System Status"
echo "  10.) Fortune Telling"

echo -n "Enter choice: "
read option
echo ""
case $option in
    1 ) CorruptionDetectionProxy_FUNC;;
    2 ) MojoMezz_FUNC;;
    3 ) Sub_FUNC;;
    4 ) InverseTelecine_FUNC;;
    5 ) AudioExtract_FUNC;;
    6 ) H264_FUNC;;
    7 ) Loudness_FUNC;;
    8 ) AssetStatus_FUNC;;
    9 ) SystemStatus_FUNC;;
    10 ) FortuneTelling_FUNC;;
    * ) tput setf 10;echo "Invalid option.";tput setf 10;
esac
done
 }

main_menu