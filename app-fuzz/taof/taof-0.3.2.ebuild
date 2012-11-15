# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"
inherit python

DESCRIPTION="A generic fuzzer framework"
HOMEPAGE="http://taof.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/twisted"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	insinto /usr/lib/"${PN}"
	doins -r *
	dodoc Changelog
	dobin "${FILESDIR}"/taof
#	dosym /usr/lib/"${PN}"/taof.py /usr/bin/taof
}
