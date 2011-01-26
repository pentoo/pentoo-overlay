# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit python eutils

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

src_prepare() {
	epatch "${FILESDIR}"/haraldscan-maclist-path.patch
}
src_install() {
	insinto /usr/lib/python$(python_get_version)/haraldmodules
	doins haraldmodules/*.py
	dobin haraldscan.py
	insinto /usr/share/haraldscan
	doins MACLIST
	dodoc doc/README
}

pkg_postinst() {
	python_mod_optimize /usr/lib/python$(python_get_version)/haraldmodules
	einfo "Updating MAC database..."
	haraldscan.py -u >/dev/null 2>&1 || true
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/python$(python_get_version)/haraldmodules
}
