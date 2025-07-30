#!/bin/bash
echo "This command will tar a package and then list it's contents"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
find $inputFolder -name "*.DS*" -exec rm {} \;
find $inputFolder -name "*._*" -exec rm {} \;
cd $inputFolder
tar -cvf $inputFolder.tar ./*
tar -tvf $inputFolder.tar