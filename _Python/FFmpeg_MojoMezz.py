import os
from datetime import datetime
from time import sleep
import cowsay
import subprocess
import sys
import MojoModule
from ffmpy import FFmpeg
LOGNAME = os.getlogin()

#-------------------------------------------------------------------------------
# CONFIGURABLE SETTINGS
#-------------------------------------------------------------------------------

# Audio Codec
AUDIO_PROFILE = 'pcm_s24be'

# Video Codec
Video_CODEC = "prores"
Video_PROFILE = "3"
Video_PIX = "yuv422p10"

# encoding speed:compression ratio
# PRESET = 'fast'

# path to ffmpeg bin
FFMPEG_PATH = "/home/" + LOGNAME + "/bin/ffmpeg"

# font dir
FONT_DIR = '/var/www/.fonts'

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/OptimusPrime_PY.cow"
greet = "Which file would you like to encode into a Pro Res file?"
MojoModule.greeting(cow, greet)

#-------------------------------------------------------------------------------
# Gathering info on file
#-------------------------------------------------------------------------------

INPUT = raw_input("Drag in file here: ")

if INPUT == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()

#-------------------------------------------------------------------------------
# Correct File name if needed
#-------------------------------------------------------------------------------

SOURCE = MojoModule.pathfixer(INPUT)

#-------------------------------------------------------------------------------
# encoding script
#-------------------------------------------------------------------------------

def MojoMezz(VideoFile):
	VideoSplit = VideoFile.split(os.path.sep)
	VideoName = VideoSplit[-1]
	now = datetime.now()
	FileName, FileEXT = os.path.splitext(VideoFile)
	OUTPUT = str(FileName) + "_FFmpeg.mov"
	subprocess.call([FFMPEG_PATH, "-i", VideoFile, "-map", "0:v", "-c:v", Video_CODEC, "-profile:v", Video_PROFILE, "-pix_fmt", Video_PIX, "-map", "0:a", "-c:a", AUDIO_PROFILE, "-sn", "-y", OUTPUT])
	cowsay.tux("Your file is complete! Asset needs to be run through Elemental or FCP to be accept for iTunes delivery!")
	print "File is located at %s" % OUTPUT
	return
MojoMezz(SOURCE)

"""
	ff = FFmpeg(
		inputs={VideoFile: None},
		outputs={OUTPUT:"-c:v prores -profile:v 3 -pix_fmt yuv422p10 -map 0:a -c:a pcm_s24be -sn -y"}
		)
"""