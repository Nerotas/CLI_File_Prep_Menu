#!/bin/bash
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
ls -l
for f in *; do openssl "md5" "$f"; done
