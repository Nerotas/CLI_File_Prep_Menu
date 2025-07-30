import subprocess, os, sys
import hashlib
import csv
from datetime import datetime
from time import sleep

#---------------------------------------------------------------------------------
# Reads login name and generates a greeting
#---------------------------------------------------------------------------------

LOGNAME = os.getlogin()

def checkcropping(VIDEO_FILE):
    #-------------------------------------------------------------------------------
    # CONFIGURABLE SETTINGS
    #-------------------------------------------------------------------------------

    # Audio Codec
    AUDIO_PROFILE = '-an'

    # Video Codec
    Video_PROFILE = 'null'

    # path to ffmpeg bin
    FFMPEG_PATH = "/home/" + LOGNAME + "/bin/ffmpeg"

    # font dir
    FONT_DIR = '/var/www/.fonts'

    #output
    OUTPUT = "/dev/null"
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

def corruptiondetect(VIDEO_FILE):
    #-------------------------------------------------------------------------------
    # CONFIGURABLE SETTINGS
    #-------------------------------------------------------------------------------
    # Audio Codec
    AUDIO_PROFILE = '-an'

    # Video Codec
    Video_PROFILE = 'null'

    # path to ffmpeg bin
    FFMPEG_PATH = "/home/" + LOGNAME + "/bin/ffmpeg"

    # font dir
    FONT_DIR = '/var/www/.fonts'

    #output
    OUTPUT = "/dev/null"

    #-------------------------------------------------------------------------------
    # Filename info
    #-------------------------------------------------------------------------------

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

def probe(VIDEO_FILE):
    PROBE_LOG_V1 = VIDEO_FILE + "_PROBE.xml"
    PROBE_LOG_V2 = PROBE_LOG_V1.replace(".mov","")
    os.system("ffprobe -v error -pretty -show_format -show_streams -i %s >  %s" % (VIDEO_FILE,PROBE_LOG_V2))