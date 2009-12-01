# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="rcracki_mt can be used to perform a rainbow table attack on password hashes"
HOMEPAGE="http://sourceforge.net/projects/rcracki/"
SRC_URI="mirror://sourceforge/rcracki/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}_${PV}_src"

src_prepare() {
	cd "${S}"
	epatch "${FILESDIR}/${PN}-share.patch"
	sed -i "s#@@SHARE@@#/usr/share/${P}#g" ChainWalkContext.cpp || die
	sed -i "s|-O3|$CXXFLAGS|" Makefile || die
}

src_install() {
	dobin rcracki_mt
	insinto "/usr/share/${P}"
	doins charset.txt
}
