#!/bin/bash
echo "This program will copy only the needed steams into a new file. Renaming is needed after the transcode."
echo "Drag in video file to create a VUDU file and then hit enter to continue:"
read -er inputFile
echo "you have chosen "$inputFile" as the source."
echo "------------------------------------------------------"

ffmpeg -i $inputFile -map 0:v -c:v copy -map 0:1 -c:a copy -map 0:2 -c:a copy -map 0:3 -c:a copy -map 0:4 -c:a copy -map 0:5 -c:a copy -map 0:6 -c:a copy "${inputFile%.*}_VUDU.mov"

echo "Your file is complete!"
echo "${inputFile%.*}_VUDU.mov"
echo "Don't forget to rename the file and audio tracks!!"
echo "------------------------------------------------------"