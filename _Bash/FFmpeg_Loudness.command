#!/bin/bash
echo "This command will normailze audio to ERB-128 standards without touching video."
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v copy -c:a pcm_s24be -af loudnorm -ar 48000 -y "${inputFile%.*}_Normalized.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}_Normalized.mov"
echo "-------------------------------------------------"