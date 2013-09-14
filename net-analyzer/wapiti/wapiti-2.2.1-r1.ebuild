# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_COMPAT=( python2_{6,7} )
inherit python-r1

DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=""

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins -r src/*
	chmod +x "${D}/usr/$(get_libdir)/${PN}/${PN}.py"
	dosym "/usr/$(get_libdir)/${PN}/${PN}.py" /usr/bin/"${PN}"
	dodoc README
}
