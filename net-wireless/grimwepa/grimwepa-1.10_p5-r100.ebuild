# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/webscarab/webscarab-20070504.ebuild,v 1.1 2007/06/17 16:14:46 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A password cracker for both WEP and WPA-encrypted access points"
HOMEPAGE="http://code.google.com/p/grimwepa/"
SRC_URI="http://grimwepa.googlecode.com/files/grimwepa1.10a5.jar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wep +extra"

#	pyrit, gpu attack, FIXME use flag

DEPEND=">=virtual/jre-1.5
	net-wireless/wpa_supplicant
	wep? ( net-analyzer/macchanger )
	extra? ( app-crypt/crunch
		net-analyzer/wireshark
		net-analyzer/hydra
		app-crypt/pyrit )"
RDEPEND="${DEPEND}"

src_install() {
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	insinto /usr/lib
	newins "${DISTDIR}/${A}" "${PN}.jar"
	insinto /etc
	doins "${FILESDIR}"/grimwepa.conf
	domenu "${FILESDIR}"/grimwepa.desktop
}
