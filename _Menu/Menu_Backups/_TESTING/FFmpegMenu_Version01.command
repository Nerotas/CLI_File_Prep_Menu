#!/bin/bash

#Current version is V1 as of 02/01/2018 - NEROTAS

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

function MojoMezz_FUNC
{
echo "This command will procuce an Apple Pro Res 422 (HQ) file with PCM audio."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -c:a pcm_s24be -y "${inputFile%.*}_FFmpeg.mov"
echo "-------------------------------------------------"
echo "Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!"
echo "${inputFile%.*}_FFmpeg.mov"
echo "-------------------------------------------------"
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
ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -vf subtitles="$subtitle" -c:a copy -y "${inputFile%.*}_enSUB_FFmpeg.mov"
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
ffmpeg -i $inputFile -pass 1 -map 0:v -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 00:00:00:00 -vf yadif -map 0:a -c:a pcm_s24be -y "${inputFile%.*}_TEMP_Pass01.mov"
ffmpeg -i "${inputFile%.*}_TEMP.mov" -pass 2 -map 0:v -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 00:00:00:00 -vf decimate -map 0:a -c:a pcm_s24be -y "${inputFile%.*}_InverseTelecine.mov"
echo "-------------------------------------------------"
echo "Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!"
echo "${inputFile%.*}_InverseTelecine.mov"
echo "-------------------------------------------------"
}

function AudioExtract_FUNC
{
echo "This command will extract all audio from a muxed file."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -vn -c:a copy -y "${inputFile%.*}_AudioOnly.mov"
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

ffmpeg -i "$inputFile" -map 0 -c:v copy -c:a pcm_s24be -af loudnorm -y "${inputFile%.*}_Normalized.mov"
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
ffmpeg -i "$inputFile" -map 0:v -c:v libx264 -preset medium -c:a libfdk_aac -ac 2 -b:a 192k -y "${inputFile%.*}_h264.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mov"
echo "-------------------------------------------------"
;;
2 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -filter_complex "[0:1][0:2]amerge=inputs=2[aout]" -map 0:v -c:v libx264 -preset medium  -map "[aout]" -c:a libfdk_aac -ac 2 -b:a 192k -y "${inputFile%.*}_h264.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mov"
echo "-------------------------------------------------"
;;
3 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -filter_complex "[0:7][0:8]amerge=inputs=2[aout]" -map 0:v -c:v libx264 -preset medium  -map "[aout]" -c:a libfdk_aac -ac 2 -b:a 192k -y "${inputFile%.*}_h264.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_h264.mov"
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

#This is mostly for testing since it quick and simple. It's also kinda fun.

function FortuneTelling_FUNC
{
fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n 1)
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
until [ "$option" = "9" ]; do
echo "  1.) Corruption Detection"
echo "  2.) Mojo Mezzanine Pro Res"
echo "  3.) Subtitile Burn-in"
echo "  4.) Inverse Telecine"
echo "  5.) Audio Extraction"
echo "  6.) Simple h.264"
echo "  7.) ERB-128 Audio Loudness"
echo "  8.) System Status"
echo "  9.) Fortune Telling"

echo -n "Enter choice: "
read option
echo ""
case $option in
    1 ) CorruptionDetection_FUNC;;
    2 ) MojoMezz_FUNC;;
    3 ) Sub_FUNC;;
    4 ) InverseTelecine_FUNC;;
    5 ) AudioExtract_FUNC;;
    6 ) H264_FUNC;;
    7 ) Loudness_FUNC;;
    8 ) SystemStatus_FUNC;;
    9 ) FortuneTelling_FUNC;;
    * ) tput setf 9;echo "Invalid option.";tput setf 9;
esac
done
 }

main_menu