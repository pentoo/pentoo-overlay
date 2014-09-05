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
        newsbin "${FILESDIR}"/flushchanges-${PVR} flushchanges
        newsbin "${FILESDIR}"/makemo-${PVR} makemo

	exeinto /etc/local.d
	newexe "${FILESDIR}"/binary-driver-handler.sh-${PVR} 01-binary-driver-handler.sh
}
