import subprocess, os, sys
from datetime import datetime
from time import sleep
import MojoModule

LOGNAME = os.getlogin()
#-------------------------------------------------------------------------------
# CONFIGURABLE SETTINGS
#-------------------------------------------------------------------------------

# Audio Codec
AUDIO_PROFILE = '-an'

# Video Codec
Video_PROFILE = 'null'

# path to ffmpeg bin
#FFMPEG_PATH = "ffmpeg"
FFMPEG_PATH = "/home/" + LOGNAME + "/bin/ffmpeg"

# font dir
FONT_DIR = '/var/www/.fonts'

#output
OUTPUT = "/dev/null"

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
MojoModule.greeting()

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
# Cropping Script
#-------------------------------------------------------------------------------

def checkcropping(VIDEO_FILE):
    VideoSplit = VIDEO_FILE.split(os.path.sep)
    VideoName = VideoSplit[-1]
    NAME = VideoName.replace(".mov","")
    now = datetime.now()
    sleep(1)
    print
    print "The program will now begin checking:\n%s." % VIDEO_FILE
    sleep(1)
    print "This program will check a five minute intercal starting after the logos."
    print "Cropping numbers provided should be increased and checked by eye."
    sleep(3)
    os.system("%s -ss 30 -t 60 -i %s -vf cropdetect=round=2 -f %s %s -y %s" % (FFMPEG_PATH,VIDEO_FILE,Video_PROFILE,AUDIO_PROFILE, OUTPUT))
    print
    print
    sleep(1)
    print
    print
    return

#-------------------------------------------------------------------------------
# Summary of cropping program
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Begin cropping 
#-------------------------------------------------------------------------------

checkcropping(SOURCE)

#-------------------------------------------------------------------------------
# Wrap up
#-------------------------------------------------------------------------------

