# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"
inherit autotools eutils python

DESCRIPTION="a distributed portscanner"
HOMEPAGE="http://events.ccc.de/congress/2009/wiki/Wolpertinger"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libdnet
	 net-libs/libpcap
	 dev-libs/openssl
	 dev-db/sqlite:3"

pkg_setup() {
    python_set_active_version 2
    python_pkg_setup
}

src_prepare() {
	#epatch "${FILESDIR}"/${PN}-makefile.patch
	#epatch "${FILESDIR}"/${P}-as-needed.patch
	eautoreconf
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	DESTDIR="${D}" emake install
	# the initscript is pretty useless
	rm "${D}"/etc/init.d/wolper-init.sh
	# so are the docs, but for sake of completeness I'll add them
	dodoc README NEWS
}
