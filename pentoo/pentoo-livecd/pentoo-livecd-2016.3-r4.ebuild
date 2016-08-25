# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="things needed by pentoo for livecd only"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="livecd"

S="${WORKDIR}"

DEPEND=""
RDEPEND="!<pentoo/pentoo-system-2014.3-r4
	livecd? ( pentoo/pentoo-installer
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
	newsbin "${FILESDIR}"/flushchanges-2014.3-r5 flushchanges
    newsbin "${FILESDIR}"/makemo-2014.3-r7 makemo
	newsbin "${FILESDIR}"/livecd-setpass-r1 livecd-setpass

	newinitd "${FILESDIR}"/binary-driver-handler.initd-2014.3-r10 binary-driver-handler

	exeinto /root/Desktop
	doexe "${FILESDIR}"/networkmanager.desktop
	exeinto /etc/skel/Desktop
	newexe "${FILESDIR}"/sudo-networkmanager.desktop networkmanager.desktop
}
