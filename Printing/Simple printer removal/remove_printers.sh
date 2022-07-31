#!/bin/bash
#
# Removing multiple printers on Mac OS X 10.6+
#
# Script written by Karel Geerts


echo "Deleting Printer1..." 
lpadmin -x Printer1

echo "Deleteing Printer2..."
lpadmin -x Printer2

exit 0