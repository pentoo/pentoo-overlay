#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/files/acpid-2.0.11-init.d,v 1.6 2011/08/05 08:47:40 ssuominen Exp $

extra_commands="reload"
command="/usr/sbin/acpid"
command_args="${ACPID_OPTIONS}"
start_stop_daemon_args="--quiet"
description="Daemon for Advanced Configuration and Power Interface"

depend() {
	need localmount
	use logger
}

if [ "${RC_VERSION:-0}" = "0" ]; then
	start() {
		eerror "This script cannot be used for baselayout-1."
		return 1
	}
fi

reload() {
	ebegin "Reloading acpid configuration"
	start-stop-daemon --exec $command --signal HUP
	eend $?
}
