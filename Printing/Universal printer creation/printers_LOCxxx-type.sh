#!/usr/bin/env bash
#
# Constructing a printer on Mac OS X 10.6+
#
# Script written by Karel Geerts


# variables
# ---------
# LOGFILE		= location of the log-file (prefix PREF_ to keep log-files together)
# PRINTERNAME	= queue-name of the printer in cups
# DISPLAYNAME	= name of the printer in System Preferences
# LOCATION		= location info of the printer in System Preferences 
# URL			= ip-address of the printer (prefix is lpd://) 
# PPD			= location of the ppd-file on the system 
# SHARED		= is this printer shared from this system onto the network (e.g. usb-printers)
# COLORMODE     = default Black & White (FalseM) or Color (TrueM) - this value can differ depending on the ptinter driver
# DUPLEX		= default singlesided (None) or doublesided (DuplexNoTumble)  - this value can differ depending on the ptinter driver
# TRAYS		    = Optional Trays

LOGFILE="/var/log/PREF_printers.log"
PRINTERNAME="The_actual_printername"
DISPLAYNAME="The displayname"
LOCATION="COUNTRY - DPT - Floor"
URL="lpd://xxx.xxx.xxx.xxx"
PPD="/Library/Printers/PPDs/Contents/Resources/someprinterdriver.gz"
SHARED=false
COLORMODE=TrueM
DUPLEX=None
TRAYS="OptTray2=True OptTray3=True OptTray4=True"

# main
#-----
# deleting possible corrupted printer from last session
# considers only printers with the same name, so user-defines printers (home-printers) are left untouched
echo "`date -u` | cleaning up possible leftovers of $PRINTERNAME" >> $LOGFILE
lpadmin -x $PRINTERNAME >> $LOGFILE

# constructing the printer in cups, setting the necessary options
# -u allow:all so all users can use this device
# -E enable the device and accept jobs
echo "`date -u` | start making printer $PRINTERNAME" >> $LOGFILE
lpadmin -p $PRINTERNAME -L "$LOCATION" -D $DISPLAYNAME -v $URL -P "$PPD" -o printer-is-shared=$SHARED -o ColorMode=$COLORMODE -o Duplex=$DUPLEX -o "$TRAYS" -u allow:all -E >> $LOGFILE
echo "`date -u` | stop making printer $PRINTERNAME" >> $LOGFILE

exit 0