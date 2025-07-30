#!/bin/bash
    option=0
until [ "$option" = "9" ]; do
echo "  1.) Half Size Images"
echo "  2.) Manual Resize"
echo "  3.) Chapter Images"
echo "  4.) Remove Alpha Layer"
echo "  5.) Fangando Art"
echo "  6.) Hoopla Art"
echo "  7.) Tubi Poster Art"
echo "  8.) Tubi Landscape Art"
echo "  9.) Main Menu"
echo -n "Enter choice: "
read option
echo ""
case $option in
1 ) echo "This command will half the size of all image files in the given folder"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do convert "$f" -verbose -resize 50% "converted/${f%}"; done
    ;;
2 ) echo "Drag in file and then hit enter to continue:"
read -er inputFile
echo "-------------------------------------------------"
echo "Input new size in ????x???? format:"
echo "-------------------------------------------------"
read -er newSize
convert "$inputFile" -verbose -flatten -resize "$newSize"! "${inputFile%.*}_$newSize.jpg"
    ;;
3 ) echo "This command will convert all images in a directory into RGB jpeg images"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
echo "Largest cropping number on the QCR? Put 0 if the asset is 1.78."
read -er crop
cd $inputFolder
mkdir chapters
for f in *; do convert "$f" -verbose -colorspace sRGB -type truecolor -shave 0x$crop "./chapters/${f%.*}.jpg"; done
	;;
4 ) echo "This command will elimate alpha channels in .png files"
echo "Drag in folder and then hit enter to continue:"
read -er inputFolder
cd $inputFolder
mkdir converted
for f in *; do convert "$f" -verbose -alpha set "converted/${f%}.png"; done
cd ./converted
rename .png.png .png *.png
rename .jpeg .png *.jpeg
rename .jpg .png *.jpg
rename .JPG .png *.JPG 
    echo "-------------------------------------------------"
	;; 
5 ) echo "This command will create two art assets for Fangando at 1400x2100 & 800x1200."
echo "Please select a file with a 2x3 ratio such as iTunes art."
echo "Drag in file and then hit enter to continue:"
read -er inputFile
convert "$inputFile" -verbose -flatten -resize 1400x2100! "${inputFile%.*}_1400x2100.jpg"
convert "$inputFile" -verbose -flatten -resize 800x1200! "${inputFile%.*}_800x1200.jpg"
    ;;
6 ) echo "This command will create art for Hoopla at 988x1408 at 96 DPI."
echo "Please select a file with a .7 ratio such as Vudu art."
echo "Drag in file and then hit enter to continue:"
read -er inputFile
convert "$inputFile" -verbose -flatten -depth 96 -resize 988x1408! "${inputFile%.*}_988x1408_Hoopla.jpg"
    ;;    
7 ) echo "This command will create poster art for Tubi at 900x1285."
echo "Please select a file with a .7 ratio such as Vudu art."
echo "Drag in file and then hit enter to continue:"
read -er inputFile
convert "$inputFile" -verbose -flatten -depth 72 -resize 900x1285! "${inputFile%.*}_TubiPoster_900x1285.jpg"
;;
8 ) echo "This command will create landscape art for Tubi at 896x504."
echo "Please select a file with a 1.78 ratio such as Amazon BG art. Art MUST have the title in it."
echo "Drag in file and then hit enter to continue:"
read -er inputFile
convert "$inputFile" -verbose -flatten -depth 72 -resize 896x504! "${inputFile%.*}_TubiLandscape_896x504.jpg"
;;
9 ) echo "Exiting Images Menu" ;;
* ) tput setf 7;echo "Please enter 1 - 7";tput setf 7; 
esac
done