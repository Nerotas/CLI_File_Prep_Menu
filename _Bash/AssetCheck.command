#!/bin/bash
echo "This command will help techs identify file assets. Drag in the file:"
echo "-------------------------------------------------"
read -er inputFile 
echo "-------------------------------------------------"
ffprobe -v error -pretty -select_streams v:0 -show_streams -i "$inputFile"
echo "-------------------------------------------------"