#!/bin/bash
echo "Drag in video file and then hit enter to continue:"
read -er inputFile
echo "------------------------------------------------------"
echo "Choose an output filename."
read -e outputFile
echo "You have chosen "$outputFile".mov as the filename."
echo "------------------------------------------------------"

# pass 1
ffmpeg -i $inputFile -pass 1 -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 01:00:00:00 -vf yadif -c:a pcm_s24be /${DataSource}/2_Transcoding/_TEMP/$outputFile.mov

# pass 2
ffmpeg -i /${DataSource}/2_Transcoding/_TEMP/$outputFile.mov -pass 2 -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -field_order progressive -timecode 01:00:00:00 -vf decimate -c:a pcm_s24be -y /${DataSource}/5_QC/_TechsFolders/NJE/$outputFile.mov

rm /${DataSource}/2_Transcoding/_TEMP/$outputFile.mov
