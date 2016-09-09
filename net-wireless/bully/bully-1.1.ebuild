# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
inherit versionator
MY_PV=$(replace_version_separator 2 '-' )

DESCRIPTION="A wifi-protected-setup (WPS) brute force attack tool, similar to reaver"
HOMEPAGE="https://github.com/aanarchyy/bully/releases"
SRC_URI="https://github.com/aanarchyy/bully/archive/${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3+ GPL-2 BSD"
KEYWORDS="amd64 arm x86"

DEPEND=">=dev-libs/openssl-1
	net-libs/libpcap"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	cd "${S}/src"
	emake
}

src_install() {
	cd "${S}/src"
	emake DESTDIR="${D}" prefix=/usr install
	dodoc "${S}/README.md"
}
