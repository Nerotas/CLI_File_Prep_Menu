import os
from datetime import datetime
from time import sleep
import subprocess
import sys




#-------------------------------------------------------------------------------
# Will create hard link based on user input
#-------------------------------------------------------------------------------
NUM = 210
DEST = "/Users/localadmin/Library/Application\ Support/mTape\ LTFS\ Utility/.MountIndexData/107964532/1.9_UHD_AND_HDR_FILES/2.7.2_UHD_AQUISITION_MASTER/1.78/2.7.2_UHD_AQUISITION_MASTER_178_TEXTED/"
while NUM <= 223:
  NUM_String = str(NUM)
  INPUT = "/${DataSource}/6_Packaging/FabricationFilms/FILM/KillersAnonymous/CAPTURE/Tape_8720/1.9_UHD_AND_HDR_FILES/2.7.2_UHD_AQUISITION_MASTER/1.78/2.7.2_UHD_AQUISITION_MASTER_178_TEXTED/UHD_AQUISITION_MASTER_178_TEXTED_00" + NUM_String
  os.system("cp -nv %s* %s" % (INPUT,DEST))
  NUM = (NUM+1)

sleep(2)
sys.exit()
"""
#  elif fnmatch.fnmatch(ASSET_TYPE, '*.itmsp'):
#   if fnmatch.fnmatch(infile, '*source*'):
#     subprocess.call([COMMAND, "-v", infile, SOURCE_PATH])
#     print "Hard link being created in FEATURE folder."
#   elif fnmatch.fnmatch(infile, '*preview*'):
#     subprocess.call([COMMAND, "-v", infile, PREVIEW_PATH])
#     print "Hard link being created in TRAILER folder."
"""