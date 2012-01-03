# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_P=${P/-wps/}

DESCRIPTION="Reaver implements a brute force attack against Wifi Protected Setup (WPS)"
HOMEPAGE="https://code.google.com/p/reaver-wps/"
SRC_URI="https://reaver-wps.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}/src

src_install() {
	newsbin reaver reaver_wps
	cd ../docs
	dodoc README
}
