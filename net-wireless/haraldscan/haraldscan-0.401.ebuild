# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="A Bluetooth discovery scanner"
HOMEPAGE="http://code.google.com/p/haraldscan/"
SRC_URI="http://haraldscan.googlecode.com/files/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$RDEPEND"
RDEPEND="dev-python/pybluez"

S="${WORKDIR}"/${PN}-src-${PV}

src_install() {
	insinto /usr/share/haraldscan/
	doins *.py MACLIST
	dodoc README
	dobin "${FILESDIR}"/$PN
}

pkg_postinst() {
	python_mod_optimize /usr/share/haraldscan/
	einfo "Updating MAC database..."
	haraldscan -u
}

pkg_postrm() {
	python_mod_cleanup
}

