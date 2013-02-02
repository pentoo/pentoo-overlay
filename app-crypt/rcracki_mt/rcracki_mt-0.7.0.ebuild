# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="perform a rainbow table attack on password hashes"
HOMEPAGE="http://sourceforge.net/projects/rcracki/"
SRC_URI="mirror://sourceforge/rcracki/${PN}_${PV}_src.7z"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
		 app-arch/p7zip"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}_${PV}_src/${PN}"

src_prepare() {
	sed -i "s#GetApplicationPath() + "charset.txt"#"/usr/share/charset.txt"${P}#g" ChainWalkContext.cpp || die
	sed -i "s|-O3|$CXXFLAGS|" Makefile || die
	sed -i "s|\$(LFLAGS)|$LDFLAGS|" Makefile || die
}

src_install() {
	dobin rcracki_mt || die
	insinto "/usr/share/${P}"
	doins charset.txt || die
}
