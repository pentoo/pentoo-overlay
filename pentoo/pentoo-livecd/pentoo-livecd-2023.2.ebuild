# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="things needed by pentoo for livecd only"
HOMEPAGE="http://www.pentoo.ch"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="livecd"

S="${WORKDIR}"

DEPEND=""
RDEPEND=""
PDEPEND="livecd? ( pentoo/pentoo-installer
		app-admin/pwgen
		app-misc/livecd-tools
		app-portage/eix
		app-portage/smart-live-rebuild
		net-wireless/b43-fwcutter
		sys-apps/gentoo-functions
		sys-apps/util-linux
		sys-block/disktype
		sys-fs/squashfs-tools
	)"

pkg_setup() {
	use !livecd && die "Failed safety check, please run 'emerge --depclean' and/or manually remove pentoo-livecd"
}

src_install() {
	#/usr/sbin
	newsbin "${FILESDIR}"/flushchanges-2018.0 flushchanges
	newsbin "${FILESDIR}"/makemo-2020.3 makemo
	newsbin "${FILESDIR}"/livecd-setpass-r13 livecd-setpass

	newinitd "${FILESDIR}"/binary-driver-handler.initd-2023.2 binary-driver-handler

	exeinto /etc/skel/Desktop
	#network manager shortcuts
	newexe "${FILESDIR}"/sudo-networkmanager.desktop networkmanager.desktop
	newbin "${FILESDIR}/pentoo-sudo-start-nm-r2" pentoo-sudo-start-nm
	#hidpi shortcuts
	doexe "${FILESDIR}"/toggle_hidpi.desktop
	dobin "${FILESDIR}/toggle_hidpi"

	exeinto /etc/local.d
	doexe "${FILESDIR}"/00-fix-distdir.start
}
