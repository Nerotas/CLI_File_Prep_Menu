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
from xml.dom import minidom
import shutil
import MojoModule
#The location of the iTunes Transporter program

COMMAND = "/usr/local/itms/bin/iTMSTransporter"

# Greeting and confirmation for user to know what the program is.

cow = "/home/Cows/Cowunt.cow"
greet = "Which asset would you like to upload to iTunes?"
MojoModule.greeting(cow, greet)

# Prompt for the user to drag in the ITMSP package

ITMSP = raw_input("Drag in ITMSP here: ")
SPEED = raw_input("Upload speed in kilobytes? Suggested between 25000 and 300000: ")

if ITMSP == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()

if SPEED == "":
    print "No speed selected. Exiting program."
    sleep(1)
    sys.exit()

# The credientials for logging into iTunes Transporter

USER = "upload@mojomakers.com"
PASSWORD = "1990Mojo"

#Below reads the file path to gather the name of the asset and the provider. It is based off of the grid naming conventions. It also determines the TYPE (FEATURE OR MUSIC VIDEO) to allow the script to create a proper location for a log.

split = ITMSP.split(os.path.sep)
PROVIDER = str(split[4])
TYPE = str(split[5])
TITLE = str(split[6])

PKG_NAME = str(split[-1])

#Old Vendor ID method based on file name

"""
VendorID, EXT = os.path.splitext(PKG_NAME)
"""
PROVIDER_UPPER = PROVIDER.upper()

# Below is a command to read the metadata file and find the <provider> tag.

META = "%s/metadata.xml" % (ITMSP)
mydoc = minidom.parse(META)
items = mydoc.getElementsByTagName('provider')
ID = mydoc.getElementsByTagName("vendor_id")

for elem in items:
  AGG = str(elem.firstChild.data)

for elem in ID:
    VendorID = str(elem.firstChild.data)

now = datetime.now()

#Below the script will inspect the metadata for title of the asset. It creates two different types of titles. One with space (XML_Title) and one without (META_TITLE)


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

#Below creates the path and name of the log file created by transporter.

LOG = "/${DataSource}/6_Packaging/%s/%s/%s/METADATA/iTUNES_%s_%s_%s_%04d_%02d_%02d.txt" % (PROVIDER, TYPE, TITLE, PROVIDER, TITLE, VendorID, now.year, now.month, now.day)
SPEED = str(SPEED)
LOG_DEST = "/Volumes/LOGS/iTUNES_Transporter/%s" % PROVIDER_UPPER

#if not os.path.exists(LOG_DEST):
#	os.makedirs(LOG_DEST)

#Function to execute the upload command.

def upload():
	print "The title is %s." % TITLE
	sleep(1)
	print "The provider is %s and will upload under %s." % (PROVIDER, AGG)
	sleep(1)
	print "The vendor ID is %s" % VendorID
	sleep(1)
	print "The current date is %04d_%02d_%02d." % (now.year, now.month, now.day)
	sleep(1)
	print "Output file will be named:\n%s" % (LOG)
	sleep(1)
	print "Upload speed will be %sk" % (SPEED)
	sleep(1)
	print
	print
	FINALANSWER = str(raw_input("Is this correct?\nYes or no: "))
	FINALANSWER = FINALANSWER.lower()
	if FINALANSWER == "yes" or FINALANSWER == "y":
		subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "upload", "-f", ITMSP, "-v", "eXtreme", "-s", AGG, "-o", LOG, "-k", SPEED])
#		shutil.copy2(LOG,LOG_DEST)
	else:
		print "Exiting now!"
		sleep(2)
		sys.exit()
	return

def status_short():
	subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "status", "-s", AGG, "-vendor_id", VendorID])


def check_status():
	cowsay.tux("Do you want to check the iTunes status?")
	STATUS_CHECK = raw_input("Yes or no?: ")
	STATUS_CHECK = STATUS_CHECK.lower()
	if STATUS_CHECK == "yes" or STATUS_CHECK == "y":
		status_short()
	else:
		print "Exiting now!"
		sleep(2)
		sys.exit()


upload()
check_status()