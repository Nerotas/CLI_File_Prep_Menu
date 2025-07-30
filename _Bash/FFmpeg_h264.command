#!/bin/bash
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
4 )echo "Exiting to main menu"
;;
*) echo "Invaild Option"
;;
esac
done