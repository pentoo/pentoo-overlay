# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="things needed by pentoo for livecd only"
HOMEPAGE="http://www.pentoo.ch"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="livecd"

S="${WORKDIR}"

DEPEND=""
RDEPEND="!<pentoo/pentoo-system-2014.3-r4"
PDEPEND="livecd? ( pentoo/pentoo-installer
		app-admin/pwgen
		app-misc/livecd-tools
		virtual/eject
		sys-apps/hwsetup
		sys-block/disktype
		sys-boot/shim
		sys-boot/mokutil
		x11-misc/mkxf86config
		sys-apps/gentoo-functions
		net-wireless/b43-fwcutter
	)"

pkg_setup() {
	use !livecd && die "Failed safety check, please run 'emerge --depclean' and/or manually remove pentoo-livecd"
}

src_install() {
	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-2018.0 flushchanges
	newsbin "${FILESDIR}"/makemo-2018.0-r1 makemo
	newsbin "${FILESDIR}"/livecd-setpass-r1 livecd-setpass

	newinitd "${FILESDIR}"/binary-driver-handler.initd-2018.3-r1 binary-driver-handler

	exeinto /root/Desktop
	doexe "${FILESDIR}"/networkmanager.desktop
	exeinto /etc/skel/Desktop
	newexe "${FILESDIR}"/sudo-networkmanager.desktop networkmanager.desktop
	newbin "${FILESDIR}/pentoo-sudo-start-nm-r2" pentoo-sudo-start-nm
	newsbin "${FILESDIR}/pentoo-start-nm-r2" pentoo-start-nm
}
