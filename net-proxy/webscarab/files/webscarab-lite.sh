#!/bin/sh
#export AWT_TOOLKIT=MToolkit
exec java -Xms128M -Xmx256M -jar /usr/lib/webscarab.jar Lite >/dev/null 2>&1 &
