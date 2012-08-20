# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="2"

inherit python eutils

DESCRIPTION="A Bluetooth discovery scanner"
HOMEPAGE="http://code.google.com/p/haraldscan/"
SRC_URI="http://haraldscan.googlecode.com/files/${PN}-src-${PV}.tar.gz 
	http://haraldscan.googlecode.com/svn/trunk/MACLIST"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$RDEPEND"
RDEPEND="dev-python/pybluez"

#S="${WORKDIR}"/${PN}-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	unpack ${A}
	cd "${S}"
}
src_prepare() {
	epatch "${FILESDIR}"/haraldscan-maclist-path.patch
}
src_install() {
	insinto $(python_get_sitedir)/haraldmodules
	doins haraldmodules/*.py
	dobin haraldscan.py
	insinto /usr/share/haraldscan
#	doins MACLIST
	cp "${DISTDIR}"/MACLIST "${D}"/usr/share/${PN}/
	dodoc doc/README
}

pkg_postinst() {
	python_mod_optimize haraldmodules
#	einfo "Updating MAC database..."
#	haraldscan.py -u >/dev/null 2>&1 || true
	elog "Run 'haraldscan.py -u' to create macinfo.db in a current directory"
}

pkg_postrm() {
	python_mod_cleanup haraldmodules
}
