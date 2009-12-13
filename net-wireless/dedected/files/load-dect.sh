#!/bin/bash

/lib/udev/load-modules.sh com_on_air_cs

if [ ! -c /dev/coa ]; then
	mknod /dev/coa --mode 660 c 3564 0
	chgrp dect /dev/coa
fi
