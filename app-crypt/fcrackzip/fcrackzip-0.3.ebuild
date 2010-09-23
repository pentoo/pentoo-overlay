# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-4.20.ebuild,v 1.15 2007/09/07 23:16:58 spock Exp $

inherit eutils toolchain-funcs x-modular

#MY_P="0.1"
#MY_PV="${PV/_p/p}"
MY_P="${PN}-${PV}"

DESCRIPTION=""
HOMEPAGE="http://www.goof.com/pcg/marc/fcrackzip.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

#DEPEND="net-libs/libpcap"
#RDEPEND="${DEPEND}"
PATCHES="${FILESDIR}/${P}-include.patch"

#src_unpack(){
#	elog
#	elog "The ebuild is broken. Please FIXME"
#	elog "Use hints from http://www.freshports.org/security/fcrackzip/"
#	elog
#}
#src_compile() {
#	emake || die
#}

src_install() {
#	dobin pbounce || die "dobin failed"
	elog
	elog "The ebuild is broken. Please FIXME"
	elog "Use hints from http://www.freshports.org/security/fcrackzip/"
	elog
}

