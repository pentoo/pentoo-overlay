# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_P=${P/_/}

DESCRIPTION="Some tools for NetBIOS and DNS investigation, attacks, and communication"
HOMEPAGE="http://www.skullsecurity.org/wiki/index.php/Nbtool"
SRC_URI="http://www.skullsecurity.org/downloads/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-makefile.patch || die
}

src_install() {
	dobin nbquery nbsniff dnsxss dnslogger dnscat dnstest || die
	dodoc CHANGELOG TODO
}
