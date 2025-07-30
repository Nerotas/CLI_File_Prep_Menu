import subprocess, os, sys
from datetime import datetime
from time import sleep
import MojoModule

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/DarthVader_PY.cow"
greet = "Which file would you like to double check?"
MojoModule.greeting(cow, greet)

#-------------------------------------------------------------------------------
# Gathering info on file
#-------------------------------------------------------------------------------

INPUT = raw_input("Drag in file here: ")

if INPUT == "":
    print "Nothing selected. Exiting program"
    sleep(1)
    sys.exit()

#-------------------------------------------------------------------------------
# Correct File name if needed
#-------------------------------------------------------------------------------

SOURCE = MojoModule.pathfixer(INPUT)

#-------------------------------------------------------------------------------
# Hard link into proxy folder NEED ADD CHECK FIRST
#-------------------------------------------------------------------------------

MojoModule.proxy_corruptiondetect(SOURCE)

#-------------------------------------------------------------------------------
# Create probe of the file
#-------------------------------------------------------------------------------

MojoModule.probe(SOURCE)


#-------------------------------------------------------------------------------
# Summary of cropping program
#-------------------------------------------------------------------------------

MojoModule.checkcropping(SOURCE)


#-------------------------------------------------------------------------------
# Begin Corruption detect
#-------------------------------------------------------------------------------
 
MojoModule.corruptiondetect(SOURCE)
