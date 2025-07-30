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
cow = "/home/Cows/Ghostbusters.cow"
greet = "Type in a name to look for and then hit enter to continue."
MojoModule.greeting(cow, greet)

INPUT = raw_input("Type Here: ")

if INPUT == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()
#-------------------------------------------------------------------------------
# Correct File name if needed
#-------------------------------------------------------------------------------

# SOURCE = MojoModule.pathfixer(INPUT)

#-------------------------------------------------------------------------------
# search script
#-------------------------------------------------------------------------------

print "-------------------------------------------------"
os.system("find /${DataSource}/ -iname \"*" + INPUT + "*\" -print")
print "-------------------------------------------------"