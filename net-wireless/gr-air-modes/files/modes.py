#!/bin/sh
echo "Please call modes_rx or modes_gui instead of $0 directly"
if [ "$0" == "rtl_modes.py" ]
then
	echo "for rtl devices remember to use the -d flag"
fi
