# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="Library for guymager"
HOMEPAGE="http://libguytools.sourceforge.net/"
#SRC_URI="mirror://sourceforge/libguytools/${P}.tar.gz"
SRC_URI="mirror://debian/pool/main/libg/libguytools2/${P//-/_}.orig.tar.gz ->  ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

RDEPEND="${DEPEND}"

#S="${WORKDIR}/tools-${PV}"

src_prepare() {
	echo "VERSION = ${PV}" > libguytools_version.pro.inc
	epatch "${FILESDIR}"/toolsysinfo.cpp.diff
	eapply_user
}

src_configure() {
	eqmake5 tools.pro
	eqmake5 toolsstatic.pro
}

src_install() {
	insinto /usr/include/libguytools2
	doins include/*.h
	dolib.a lib/libguytools.a
}
