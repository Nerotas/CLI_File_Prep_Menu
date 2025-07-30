import subprocess, os, sys
import hashlib
import csv
from datetime import datetime
from time import sleep

#---------------------------------------------------------------------------------
# Reads login name and generates a greeting
#---------------------------------------------------------------------------------

LOGNAME = os.getlogin()
real_name = {
        "nerotas": "Nick",
        }
"""
for key in real_name:
    if LOGNAME != key:
        LOGNAME = "anon"
"""
Greeting_Name = real_name[LOGNAME]


def greeting_standard():
    cow_loc = "/home/Cows/OptimusPrime_PY.cow"
    cow_open = open(cow_loc, "r+")
    cow = cow_open.read()
    GREETING = "Greetings, %s! \nWhat file are you using?" % Greeting_Name
    print "\n", GREETING
    print cow
    cow_open.close()


def greeting(cow_in,GREET_STRING):
    cow_loc = cow_in
    cow_open = open(cow_loc, "r+")
    cow = cow_open.read()
    GREETING = "Greetings, %s! \n%s" % (Greeting_Name, GREET_STRING)
    print "\n", GREETING
    print cow
    cow_open.close()

#---------------------------------------------------------------------------------
# The next command will correct the name if the Media Grid is not properly mounted
#---------------------------------------------------------------------------------

def pathfixer(input_path):
    splitP = input_path.split(os.path.sep)
    VOLUMES_NAME = str(splitP[1])
    GRID_NAME = str(splitP[2])
    PATH = str("/" + VOLUMES_NAME + "/" + GRID_NAME + "/")
    our_path = "/${DataSource}/"
    OS_PATH = str(os.path.abspath(input_path))
    if input_path != our_path:
        NewPath = OS_PATH.replace(PATH,our_path)
        return NewPath

#-------------------------------------------------------------------------------
# Will create hard link based on user input
#-------------------------------------------------------------------------------

def proxy_corruptiondetect(link_input):
    print "A proxy is being created for Timed Text."
    sleep(1)
    BASENAME = os.path.basename(link_input)
    PROXY_DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/CorruptionDetectProxies/" + BASENAME
    if os.path.exists(PROXY_DEST):
        print "Proxy already in progress. Will not create a new one."
    else:
        os.link(link_input, PROXY_DEST)

#-------------------------------------------------------------------------------
# Will create hard link based on user input
#-------------------------------------------------------------------------------

def proxy(link_input):
  BASENAME = os.path.basename(link_input)
  FRAMERATE = float(raw_input("What is the framerate? (23.98, 24, 25 or 29.97): "))
  if FRAMERATE == 23.98 or FRAMERATE == 2398 and FRAMERATE != 24 and FRAMERATE != 25 and FRAMERATE != 2997 and FRAMERATE != 29.97:
    print "Framerate is 23.98"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_2398_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(WorkingFile, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE == 24 and FRAMERATE != 25 and FRAMERATE != 2997 and FRAMERATE != 29.97:
    print "Framerate is 24"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_24_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(WorkingFile, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE != 24 and FRAMERATE == 25 and FRAMERATE != 2997 and FRAMERATE != 29.97:
    print "Framerate is 25"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_25_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(WorkingFile, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE != 24 and FRAMERATE != 25 and FRAMERATE == 2997 or FRAMERATE == 29.97:
    print "Framerate is 29.97"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_2997_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(WorkingFile, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  else:
    print "ERROR!! Invalid framerate!"
    sys.exit()

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

def Hardlink(infile):
  #-------------------------------------------------------------------------------
  # Will gather info about file
  #-------------------------------------------------------------------------------
  split = infile.split(os.path.sep)
  PROVIDER = str(split[4])
  TYPE = str(split[5])
  TITLE = str(split[6])
  ASSET_TYPE = str(split[7])
  ASSET = str(split[8])

  PATH, EXT = os.path.splitext(infile)

  DEST = str(PATH) + "_HardLink" + str(EXT)
  SOURCE_PATH = "/${DataSource}/6_Packaging/%s/%s/%s/FEATURE/" % (PROVIDER, TYPE, TITLE)
  PREVIEW_PATH = "/${DataSource}/6_Packaging/%s/%s/%s/TRAILER/" % (PROVIDER, TYPE, TITLE)

  STAT = os.stat(infile)
  LINKS = STAT.st_nlink
  if ASSET_TYPE == "FEATURE":
    print "Hard link being created in source folder."
    os.link(infile, DEST)
    print "There are currently %s hardlinks for this file on the Media Grid." % LINKS
  elif ASSET_TYPE == "TRAILER":
    print "Hard link being created in source folder."
    os.link(infile, DEST)
    print "There are currently %s hardlinks for this file on the Media Grid." % LINKS
  else:
    print "ERROR!! Must be in a FEATURE or TRAILER folder!"
    sleep(2)
    sys.exit()

def checksum(source):

  hasher = hashlib.md5()
  with open(source, 'rb') as afile:
      buf = afile.read()
      hasher.update(buf)
  MD5 = (hasher.hexdigest())
  SIZE = os.path.getsize(source)
  print "File size is: %s \nmd5 checksum is: %s " % (SIZE,MD5)