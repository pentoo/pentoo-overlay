# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="things needed by pentoo for livecd only"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="livecd"

S="${WORKDIR}"

DEPEND=""
RDEPEND="!<pentoo/pentoo-system-2014.3-r4"
PDEPEND="livecd? ( pentoo/pentoo-installer
		app-misc/livecd-tools
		virtual/eject
		sys-apps/hwsetup
		sys-block/disktype
		x11-misc/mkxf86config
		sys-apps/gentoo-functions
	)"

pkg_setup() {
	use !livecd && die "Failed safety check, please run 'emerge --depclean' and/or manually remove pentoo-livecd"
}

src_install() {
	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-2018.0 flushchanges
	newsbin "${FILESDIR}"/makemo-2018.0-r1 makemo
	newsbin "${FILESDIR}"/livecd-setpass-r1 livecd-setpass

	newinitd "${FILESDIR}"/binary-driver-handler.initd-2018.0 binary-driver-handler

	exeinto /root/Desktop
	doexe "${FILESDIR}"/networkmanager.desktop
	exeinto /etc/skel/Desktop
	newexe "${FILESDIR}"/sudo-networkmanager.desktop networkmanager.desktop
}
