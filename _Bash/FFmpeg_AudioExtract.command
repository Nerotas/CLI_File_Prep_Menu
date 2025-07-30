#!/bin/bash
echo "This command will extract all audio from a muxed file."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -vn -map 0:a -c:a copy -y "${inputFile%.*}_AudioOnly.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_AudioOnly.mov"
echo "-------------------------------------------------"