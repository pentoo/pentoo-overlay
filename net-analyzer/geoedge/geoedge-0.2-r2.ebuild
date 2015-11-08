# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="This little tools is designed to get geolocalization information of a host"
HOMEPAGE="http://www.edge-security.com/edge-soft.php"
SRC_URI="http://www.edge-security.com/soft/${PN}.py"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	elog "Nothing to unpack"
	mkdir "${S}"
	cp "${DISTDIR}"/${A} "${S}"
}

src_install() {
	newbin ${PN}.py ${PN}
	python_fix_shebang "${ED}"usr/bin
}
