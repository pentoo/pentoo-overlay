# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://github.com/kimocoder/bully/issues/3
MY_PV="${PV}-00"

DESCRIPTION="A wifi-protected-setup (WPS) brute force attack tool, similar to reaver"
HOMEPAGE="https://github.com/aanarchyy/bully/releases"
SRC_URI="https://github.com/kimocoder/bully/archive/${MY_PV}-00.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3+ GPL-2 BSD"
KEYWORDS="amd64 arm x86"

DEPEND="net-libs/libpcap"

S="${WORKDIR}/${PN}-${MY_PV}/src"

#src_compile() {
#	cd "${S}/src"
#	emake
#}

src_install() {
#	cd "${S}/src"
	emake DESTDIR="${D}" prefix=/usr install
	dodoc "${S}/../README.md"
}
