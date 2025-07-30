#!/bin/bash
echo "Drag in file and then hit enter to continue:"
read -er inputFile
openssl "md5" $inputFile
