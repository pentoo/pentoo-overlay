# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A password cracker for both WEP and WPA-encrypted access points"
HOMEPAGE="http://code.google.com/p/grimwepa/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${PN}1.10a6.jar"

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
		net-wireless/pyrit )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	insinto /usr/lib
	newins "${DISTDIR}/${A}" "${PN}.jar"
	insinto /etc
	doins "${FILESDIR}"/grimwepa.conf
	domenu "${FILESDIR}"/grimwepa.desktop
}
