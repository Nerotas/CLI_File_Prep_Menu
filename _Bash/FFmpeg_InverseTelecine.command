#!/bin/bash
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