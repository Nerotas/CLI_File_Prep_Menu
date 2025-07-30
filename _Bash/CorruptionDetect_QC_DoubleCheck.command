echo "This command will scan a video file for corruption, create a proxy for timed text and a metadata xml of the file."
            cowsay -f OptimusPrime "Drag in video file and then hit enter to continue:"
echo "-------------------------------------------------"
read -er inputFile
echo "-------------------------------------------------"
ln -v $inputFile /${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/CorruptionDetectProxies
ffprobe -v error -pretty -show_format -show_streams -i "$inputFile" > "${inputFile%.*}_PROBE.xml"
cowsay -f DarthVader "What Is the title of the asset? Do NOT use any spaces or I will destroy your galaxy!"
read -er assetTitle
echo "-------------------------------------------------"
echo Any red lines of text that appear indicate corruption.
echo "-------------------------------------------------"
FFREPORT=file=/${DataSource}/5_QC/_Logs/"$assetTitle"_CorruptionDetect_%t.log ffmpeg -i "$inputFile" -map 0:v -f null -an -y /dev/null/
cowsay "Corruption Detection is complete! Any red lines indicate corruption. Moo!"
echo "-------------------------------------------------"