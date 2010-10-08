#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/files/acpid-2.0.3-init.d,v 1.1 2010/04/04 16:39:09 ssuominen Exp $

opts="reload"

depend() {
	need localmount
	use logger
	before hald
}

start() {
	ebegin "Starting acpid"
	start-stop-daemon --start --quiet --exec /usr/sbin/acpid -- ${ACPID_OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping acpid"
	start-stop-daemon --stop --exec /usr/sbin/acpid
	eend $?
}

reload() {
	ebegin "Reloading acpid configuration"
	start-stop-daemon --stop --oknodo --exec /usr/sbin/acpid --signal HUP
	eend $?
}
