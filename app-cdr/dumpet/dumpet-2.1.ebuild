# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="A tool to dump and debug bootable CD-like images"
HOMEPAGE="http://fedorahosted.org/dumpet/"
SRC_URI="http://fedorahosted.org/releases/d/u/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libxml2
	dev-libs/popt"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup(){
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}/${P}"-flags.patch
}
