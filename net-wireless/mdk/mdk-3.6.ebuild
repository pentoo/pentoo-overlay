# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${PN}${PV/./-v}

DESCRIPTION="Bruteforce hidden SSID"
HOMEPAGE="http://homepages.tu-darmstadt.de/~p_larbig/wlan/"
SRC_URI="http://homepages.tu-darmstadt.de/~p_larbig/wlan/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/fix_wids_mdk3_v5.patch
}

src_compile() {
	make -j1 || die "make failed"
}

src_install() {
	dosbin mdk3 || die "dobin failed"
	dodoc AUTHORS CHANGELOG TODO docs/* useful_files/* || die "dodoc failed"
}
