"""
This program is designed to test transfers meant for iTunes via Transporter. Currently, Transporter does not support Aspera testing only Signiant.
Per their guide Transporter uses 10000 Kbits throttle speed to transport the specified providers file to the Signiant server during upload.
Coded by Nick Erotas in Python - 12/20/2018
"""

# This imports the necessary modules for this program to run successfully.

import os
from datetime import datetime
from time import sleep
import subprocess
import sys
import cowsay
from xml.dom import minidom
from shutil import copyfile
#The location of the iTunes Transporter program

COMMAND = "/usr/local/itms/bin/iTMSTransporter"

# Greeting and confirmation for user to know what the program is.

GREETING = "Hello, Mojo! This program will run Transporter in Transfer test mode. \nLet's start!"

cowsay.tux(GREETING)

# Prompt for the user to drag in the ITMSP package

SPEED = "10000"
SIZE = "1G"
# The credientials for logging into iTunes Transporter

USER = "user"
PASSWORD = "password"

now = datetime.now()

#Below creates the path and name of the log file created by transporter.

LOG = "/${DataSource}/6_Packaging/TRANSFERTEST_iTUNES_%04d_%02d_%02d.txt" % (now.year, now.month, now.day)
SPEED = str(SPEED)

#if not os.path.exists(LOG_DEST):
#	os.makedirs(LOG_DEST)

#Function to execute the upload command.

def upload():
	print "The current date is %04d_%02d_%02d." % (now.year, now.month, now.day)
	sleep(1)
	print "Output log will be named:\n%s" % (LOG)
	sleep(1)
	print "Upload speed will be the default 10k and test file will be 1G"
	sleep(1)
	print
	print
	FINALANSWER = str(raw_input("Is this correct?\nYes or no: "))
	FINALANSWER = FINALANSWER.lower()
	if FINALANSWER == "yes" or FINALANSWER == "y":
		subprocess.call([COMMAND, "-u", USER, "-p", PASSWORD, "-m", "transferTest", "-v", "eXtreme", "-s", "WALLALLC", "-o", LOG, "-t", "Signiant", "-k", SPEED, "-size", SIZE])
	else:
		print "Exiting now!"
		sleep(2)
		sys.exit()
	return

upload()
