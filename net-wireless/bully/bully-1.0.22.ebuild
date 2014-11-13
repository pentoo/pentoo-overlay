# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit versionator
MY_PV=$(replace_version_separator 2 '-' )

DESCRIPTION="A wifi-protected-setup (WPS) brute force attack tool, similar to reaver"
HOMEPAGE="https://github.com/bdpurcell/bully"
SRC_URI="https://github.com/blshkv/bully/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3+ GPL-2 BSD"
KEYWORDS="amd64 arm x86"

DEPEND=">=dev-libs/openssl-1
	net-libs/libpcap"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	cd "${S}/src"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/src"
	emake DESTDIR="${D}" prefix=/usr install || die "emake failed"
	dodoc "${S}/README.md"
}
