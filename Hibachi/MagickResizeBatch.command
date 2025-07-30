#!/bin/bash
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do magick convert "$f" -verbose -resize 50% "converted/${f%}"; done
