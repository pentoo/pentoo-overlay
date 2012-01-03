#!/bin/sh
#export AWT_TOOLKIT=MToolkit
exec java -Xms256M -Xmx512M -jar /usr/lib/webscarab.jar >/dev/null 2>&1 &
