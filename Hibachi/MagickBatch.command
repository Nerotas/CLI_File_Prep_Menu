#!/bin/bash
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -alpha set "converted/${f%}.png"; done
cd ./converted
rename .png.png .png *.png
rename .jpeg .png *.jpeg
rename .jpg .png *.jpg
rename .JPG .png *.JPG
