import os
from datetime import datetime
from time import sleep
import subprocess
import sys
import shutil
import MojoModule

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/Homer.cow"
greet = "Which file would you like to copy?"
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
# encoding script
#-------------------------------------------------------------------------------

PATH, EXT = os.path.splitext(SOURCE)

CVCP = "cvcp"

DEST = str(PATH) + "_COPY" + str(EXT)

print
print "File is copying..."
subprocess.call([CVCP, "-u", SOURCE, DEST])
print
print "The new file is at %s" % DEST