#!/bin/bash
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