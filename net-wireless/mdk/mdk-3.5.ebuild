# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${PN}${PV/./-v}

DESCRIPTION="Bruteforce hidden SSID"
HOMEPAGE="http://homepages.tu-darmstadt.de/~p_larbig/wlan/"
SRC_URI="http://homepages.tu-darmstadt.de/~p_larbig/wlan/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}
src_install() {
	einstall || die "install failed"
	dodoc SSID.txt CHANGELOG TODO
}
