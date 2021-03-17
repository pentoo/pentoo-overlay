# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for the RFHS RFCTF game"
HOMEPAGE="https://rfhackers.com/rfctf/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gui +wifi"

PDEPEND="
		app-admin/supervisor
		gui? (
			pentoo/pentoo-desktop
			www-apps/novnc
			x11-misc/x11vnc
		)
		wifi? (
			net-wireless/aircrack-ng
			app-crypt/asleap
			app-crypt/hashcat
			net-analyzer/wireshark[tshark]
			net-analyzer/termshark
			net-dialup/freeradius[wpe]
			net-wireless/hostapd[wpe]
			net-wireless/iw
			net-wireless/kismet
			net-wireless/mdk
			net-wireless/pixiewps
			net-wireless/reaver-wps-fork-t6x
			net-wireless/wifite
			net-wireless/wpa_supplicant
			pentoo/pentoo-opencl
		)
"
