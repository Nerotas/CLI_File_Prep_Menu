import os
from datetime import datetime
from time import sleep
import subprocess
import sys
import cowsay
import fnmatch
import MojoModule

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/Ghostbusters.cow"
greet = "Which file would you like to make a hardlink of?"
MojoModule.greeting(cow, greet)

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
# Will create hard link based on user input
#-------------------------------------------------------------------------------


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
Hardlink(SOURCE)


"""
#  elif fnmatch.fnmatch(ASSET_TYPE, '*.itmsp'):
#   if fnmatch.fnmatch(infile, '*source*'):
#     subprocess.call([COMMAND, "-v", infile, SOURCE_PATH])
#     print "Hard link being created in FEATURE folder."
#   elif fnmatch.fnmatch(infile, '*preview*'):
#     subprocess.call([COMMAND, "-v", infile, PREVIEW_PATH])
#     print "Hard link being created in TRAILER folder."
"""