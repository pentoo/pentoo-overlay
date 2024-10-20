# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A perl script to enumerate SNMP table dumper"
HOMEPAGE="http://packetstormsecurity.org"
#SRC_URI="https://dl.packetstormsecurity.net/UNIX/scanners/${PN}.zip -> ${P}.zip"
SRC_URI="https://pentoo.org/~zero/distfiles/${P}.zip"

S="${WORKDIR}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
BDEPEND="app-arch/unzip"
RDEPEND="dev-perl/Net-SNMP"

src_prepare() {
	eapply -p0 "${FILESDIR}"/${PN}-gentoo.patch
	default
}

src_install() {
	dodoc *.txt
	newsbin ${PN}.pl ${PN}
}
