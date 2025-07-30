import os
import sys
import hashlib
import csv
import MojoModule

#-------------------------------------------------------------------------------
# Greeting and prompt for users
#-------------------------------------------------------------------------------
cow = "/home/Cows/OptimusPrime_PY.cow"
greet = "Which file would you like to checksum?"
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

def checksum(source):

	hasher = hashlib.md5()
	with open(source, 'rb') as afile:
    	buf = afile.read()
    	hasher.update(buf)
	MD5 = (hasher.hexdigest())
	SIZE = os.path.getsize(source)
	print "File size is: %s \nmd5 checksum is: %s " % (SIZE,MD5)
checksum(SOURCE)	