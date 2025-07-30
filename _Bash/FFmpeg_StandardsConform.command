#!/bin/bash
echo "This command will make a 23.98 fps file from a 24fps for 25fps file. Any 29.97 standards conforms need to go throught Elemental."
echo "FPS of the source file?"
    option=0
until [ "$option" = "3" ]; do
echo "  1.) 24 fps"
echo "  2.) 25 fps"
echo "  3.) Return to Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) 
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -vf setpts="N/(23.98*TB)" -r 23.98 -c:a pcm_s24be -af atempo="23.98/24" -y "${inputFile%.*}_FFmpeg_CONFORM.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}__FFmpeg_CONFORM"
echo "This file MUST be run throught Elemental, Compressor or FCP to finish the conform!"
echo "-------------------------------------------------"
;;
2 )
echo "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
ffmpeg -i "$inputFile" -map 0 -c:v prores -profile:v 3 -pix_fmt yuv422p10 -timecode 00:00:00:00 -vf setpts="N/(23.98*TB)" -r 23.98 -c:a pcm_s24be -af atempo="23.98/25" -y "${inputFile%.*}_FFmpeg_CONFORM.mov"
echo "-------------------------------------------------"
echo "Your file is complete!"
echo "${inputFile%.*}__FFmpeg_CONFORM"
echo "This file MUST be run throught Elemental, Compressor or FCP to finish the conform!"
echo "-------------------------------------------------"
;;
3 )echo "Exiting to main menu" ;;
* ) tput setf 2;echo "Please enter 1, 2 or 3";tput setf 2; 
esac
done