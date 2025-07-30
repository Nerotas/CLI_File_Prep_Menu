#!/bin/bash
echo "Drag in video file and then hit enter to continue:"
read -er inputFile
echo "Choose an output filename."
read -e outputFile
echo "------------------------------------------------------"

magick convert  {$inputFile} -alpha set   {$outputfile}.png