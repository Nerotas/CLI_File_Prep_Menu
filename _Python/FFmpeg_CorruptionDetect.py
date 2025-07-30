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
cow = "/home/Cows/OptimusPrime_PY.cow"
greet = "Which file would you like to check for corruption?"
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
# encoding script; is found in Mojo Module also
#-------------------------------------------------------------------------------

def encode(VIDEO_FILE):
    VideoSplit = VIDEO_FILE.split(os.path.sep)
    VideoName = VideoSplit[-1]
    NAME = VideoName.replace(".mov","")
    now = datetime.now()
    #-------------------------------------------------------------------------------
    # Name the report log
    #-------------------------------------------------------------------------------
    REPORT = "/${DataSource}/5_QC/_Logs/%s_CorruptionDetect_%04d_%02d%02d-%02d%02d%02d.log" % (NAME, now.year, now.month, now.day, now.hour, now.minute, now.second)
    REPORT = str(REPORT)
    REPORT_CMD = "FFREPORT=file=%s" % REPORT
    #-------------------------------------------------------------------------------
    # Summary of program
    #-------------------------------------------------------------------------------
    sleep(1)
    print
    print "The program will now begin checking:\n%s." % VIDEO_FILE
    sleep(1)
    print
    print "A log will be created at:\n%s" % REPORT
    sleep(1)
    print
    print "Any red lines indicate corruption."
    sleep(3)
    os.system("%s %s -i %s -map 0:v -f %s %s -y %s" % (REPORT_CMD,FFMPEG_PATH,VIDEO_FILE,Video_PROFILE,AUDIO_PROFILE, OUTPUT))
    #-------------------------------------------------------------------------------
    # Wrap up
    #-------------------------------------------------------------------------------
    print
    print
    print "Corruption Detection is complete! Any red lines indicate corruption.\nPress enter to return to the main menu"
    sleep(3)
    print
    print
    return

#-------------------------------------------------------------------------------
# Begin Corruption detect
#-------------------------------------------------------------------------------

encode(SOURCE)