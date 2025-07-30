"""
This program is designed to vaildate .itmsp packages meant for iTunes via Transporter. This program will read the file path to determine the provider and therefore the who the package should upload under. After it makes it's conclusion, the user will be prompted to continue or abort the validation.
Coded by Nick Erotas in Python - 07/12/2018
Updated on 12/20/2018
"""

# This imports the necessary modules for this program to run successfully.

import os
from datetime import datetime
from time import sleep
import subprocess
import sys
import cowsay
from xml.dom import minidom

#The location of the iTunes Transporter program

COMMAND = "/usr/local/itms/bin/iTMSTransporter"

# Greeting and confirmation for user to know what the program is.

LOGNAME = os.getlogin()
real_name = {
	"nerotas": "Nick",
	"jbroadwater": "Jimmy",
	"srios": "Man Rocksmasher",
	"akazenoff": "Alex, Eternal Servant of The Morgan",
	"momann": "Daenerys of the House Targaryen, the First of Her Name, The Unburnt, Queen of the Andals, the Rhoynar and the First Men, Queen of Meereen, Khaleesi of the Great Grass Sea, Protector of the Realm, Lady Regnant of the Seven Kingdoms, Breaker of Chains and Mother of Dragons",
	"anthonyTEMP": "Anthony",
	"wnash": "Bill",
	"rmellette": "Rob",
	"mjones": "Jonesy",
	"srinaldi": "Sam",
	"tgonzales": "Toni <3"
	}
Greeting_Name = real_name[LOGNAME]

GREETING = "Hello, %s! \nWhat file would you like to vaildate?" % Greeting_Name

cowsay.tux(GREETING)

# Prompt for the user to drag in the ITMSP package

ITMSP = raw_input("Drag in ITMSP here: ")

if ITMSP == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()

# The credientials for logging into iTunes Transporter

USER = "upload@mojomakers.com"
PASSWORD = "1990Mojo"

#Below reads the file path to gather the name of the asset and the provider. It is based off of the grid naming conventions.

split = ITMSP.split(os.path.sep)
PROVIDER = str(split[4])
TYPE = str(split[5])
TITLE = str(split[6])

# Below is a command to read the metadata file and find the <provider> tag.

META = "%s/metadata.xml" % (ITMSP)
mydoc = minidom.parse(META)
items = mydoc.getElementsByTagName('provider')


for elem in items:
  AGG = str(elem.firstChild.data)

#title = mydoc.getElementsByTagName('title')
#for elem in title:
#  XML_TITLE = str(elem.firstChild.data)

def anti_space(text):
    t=""
    for c in text:
        for i in " ":
            if c==i:
                c=""
            else:
                c=c
        t=t+c
    return t

#META_TITLE = anti_space(XML_TITLE)

now = datetime.now()

#Below checks for a METADATA folder to place a log into and creates one if it does not exist.

META_FOLDER = "/${DataSource}/6_Packaging/%s/%s/%s/METADATA" % (PROVIDER, TYPE, TITLE)
Meta_folder = "/${DataSource}/6_Packaging/%s/%s/%s/Metadata" % (PROVIDER, TYPE, TITLE)
meta_folder = "/${DataSource}/6_Packaging/%s/%s/%s/metadata" % (PROVIDER, TYPE, TITLE)

if os.path.exists(meta_folder):
	os.rename(meta_folder,META_FOLDER)
if os.path.exists(Meta_folder):
	os.rename(Meta_folder,META_FOLDER)
if not os.path.exists(META_FOLDER):
	os.makedirs(META_FOLDER)

#Create a name for the log

LOG = "/${DataSource}/6_Packaging/%s/%s/%s/METADATA/%s_%04d_%02d_%02d_pkg_VALIDATE.txt" % (PROVIDER, TYPE, TITLE, TITLE, now.year, now.month, now.day)

#Function to execute the validation command.

def upload():
	print "The title is %s." % TITLE
	sleep(1)
	print "The provider is %s and will validated under %s." % (PROVIDER, AGG)
	sleep(1)
	print "The current date is %04d_%02d_%02d." % (now.year, now.month, now.day)
	sleep(1)
	print "Output file will be named %s" % (LOG)
	sleep(1)
	print
	print
	FINALANSWER = str(raw_input("Is this correct?\nYes or no: "))
	FINALANSWER = FINALANSWER.lower()
	if FINALANSWER == "yes" or FINALANSWER == "y":
		subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "verify", "-f", ITMSP, "-v", "eXtreme", "-s", AGG, "-o", LOG])
	else:
		print "Exiting now!"
		sleep(2)
		sys.exit()
	return

upload()


def upload_short():
	subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "verify", "-f", ITMSP, "-v", "eXtreme", "-s", AGG, "-o", LOG])

cowsay.tux("Validate again?")

REPEAT = str(raw_input("Yes or no: ")).lower()

while REPEAT == "yes" or REPEAT == "y":
	upload_short()
	print
	print
	print
	cowsay.tux("Validate again?")
	REPEAT = str(raw_input("Yes or no: ")).lower()