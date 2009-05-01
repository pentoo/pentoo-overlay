#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostapd/files/hostapd-0.6.9-init.d,v 1.1 2009/03/24 23:23:30 gurligebis Exp $

opts="start stop reload"

depend() {
	local iface

	for iface in ${INTERFACES}; do
		need net.${iface}
	done

	use logger
}

checkconfig() {
	local file

	for file in ${CONFIGS}; do
		if [[ ! -r ${file} ]]; then
			eerror "hostapd configuration file (${CONFIG}) not found"
			return 1
		fi
	done
}

start() {
	checkconfig || return 1

	ebegin "Starting hostapd"
	start-stop-daemon --start --exec /usr/sbin/hostapd \
		-- -B ${OPTIONS} ${CONFIGS}
	eend ${?}
}

stop() {
	ebegin "Stopping hostapd"
	start-stop-daemon --stop --exec /usr/sbin/hostapd
	eend ${?}
}

reload() {
	checkconfig || return 1

	ebegin "Reloading hostapd configuration"
	kill -HUP $(pidof /usr/sbin/hostapd) > /dev/null 2>&1
	eend ${?}
}
