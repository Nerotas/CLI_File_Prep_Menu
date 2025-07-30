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
import MojoModule
#The location of the iTunes Transporter program

COMMAND = "/usr/local/itms/bin/iTMSTransporter"

# Greeting and confirmation for user to know what the program is.

cow = "/home/Cows/DarthVader_PY.cow"
greet = "Which asset would you like to check the iTunes Status of?"
MojoModule.greeting(cow, greet)

# Prompt for the user to drag in the ITMSP package

META =  raw_input("Drag in iTunes metadata here: ")

if META == "":
    print "Nothing selected. Exiting program."
    sleep(1)
    sys.exit()

# The credientials for logging into iTunes Transporter

USER = "user"
PASSWORD = "password"

#Below reads the file path to gather the name of the asset and the provider. It is based off of the grid naming conventions.

splitP = META.split(os.path.sep)
PROVIDER = str(splitP[4])
TITLE = str(splitP[6])

# Below is a command to read the metadata file and find information from tags.

XML = minidom.parse(META)


MetaProvider = XML.getElementsByTagName("provider")
ID = XML.getElementsByTagName("vendor_id")
MetaTitle = XML.getElementsByTagName("title")
for elem in MetaProvider:
    AGG = str(elem.firstChild.data)
for elem in ID:
    VendorID = str(elem.firstChild.data)

now = datetime.now()

def status():
	print "The title is %s." % TITLE
	sleep(1)
	print "The provider is %s and was uploaded under %s." % (PROVIDER, AGG)
	sleep(1)
	print "The vendor ID is %s" % VendorID
	FINALANSWER = str(raw_input("Is this correct?\nYes or no: "))
	FINALANSWER = FINALANSWER.lower()
	if FINALANSWER == "yes" or FINALANSWER == "y":
		subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "status", "-s", AGG, "-vendor_id", VendorID])
	else:
		print "Exiting now!"
		sleep(2)
		sys.exit()
	return

def status_short():
	subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "status", "-s", AGG, "-vendor_id", VendorID])



status()

cowsay.tux("Check status again?")
REPEAT = str(raw_input("Yes or no: ")).lower()

while REPEAT == "yes" or REPEAT == "y":
	status_short()
	print
	print
	print
	cowsay.tux("Check status again?")
	REPEAT = str(raw_input("Yes or no: ")).lower()
