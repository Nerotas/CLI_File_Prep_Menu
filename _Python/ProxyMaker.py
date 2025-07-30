import os
from datetime import datetime
from time import sleep
import subprocess
import sys
import MojoModule
#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/Moon.cow"
greet = "Which file would you like to make a proxy of?"
MojoModule.greeting(cow, greet)

#-------------------------------------------------------------------------------
# Gathering info on file
#-------------------------------------------------------------------------------

INPUT = raw_input("Drag in file here: ")

if INPUT == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()

#---------------------------------------------------------------------------------
# The next command will correct the name if the Media Grid is not properly mounted
#---------------------------------------------------------------------------------

SOURCE = MojoModule.pathfixer(INPUT)

#-------------------------------------------------------------------------------
# Will create hard link based on user input
#-------------------------------------------------------------------------------

def Hardlink(link_input):
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
      os.link(link_input, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE == 24 and FRAMERATE != 25 and FRAMERATE != 2997 and FRAMERATE != 29.97:
    print "Framerate is 24"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_24_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(link_input, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE != 24 and FRAMERATE == 25 and FRAMERATE != 2997 and FRAMERATE != 29.97:
    print "Framerate is 25"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_25_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(link_input, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  elif FRAMERATE != 23.98 and FRAMERATE != 2398 and FRAMERATE != 24 and FRAMERATE != 25 and FRAMERATE == 2997 or FRAMERATE == 29.97:
    print "Framerate is 29.97"
    DEST = "/${DataSource}/2_Transcoding/_Proxy_Watchfolders_DELETES_FILES/Proxy_2997_TimeCode/" + BASENAME
    if os.path.exists(DEST):
      print "Proxy already in progress. Will not create a new one."
    else:
      os.link(link_input, DEST)
      print "File is queued at %s" % DEST
      print "________________________________________________________________________"
      print "Proxy has been queued. CS techs can check it's progress at 192.168.8.131"
  else:
    print "ERROR!! Invalid framerate!"
    sys.exit()
proxy(SOURCE)