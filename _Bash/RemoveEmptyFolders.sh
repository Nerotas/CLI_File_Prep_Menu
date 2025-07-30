#!/bin/bash

find ${Deep Storage Location}*/*/* -depth -type d -empty -exec rmdir "{}" \;

find /${DataSource}/3_Repair/*/*/ -depth -type d -empty -exec rmdir "{}" \;

find /${DataSource}/0_In_Out/*/* -depth -type d -empty -exec rmdir "{}" \;