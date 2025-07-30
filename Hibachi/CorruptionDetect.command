#!/bin/bash
cowsay -f OptimusPrime "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
cowsay -f DarthVader "What Is the title of the asset? Do NOT use any spaces or I will destroy your galaxy!"
read -er assetTitle
echo "-------------------------------------------------"
echo Any red lines of text that appear indicate corruption.

FFREPORT=file=/${DataSource}/5_QC/_Logs/"$assetTitle"_CorruptionDetect_%t.log ~/bin/ffmpeg -i "$inputFile" -map 0 -f null -an -y /${DataSource}/2_Transcoding/_TEMP/Dummy.mov

echo "Corruption Decetion is complete! Any red lines indicate corruption"
