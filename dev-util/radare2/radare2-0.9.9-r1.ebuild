# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+capstone debug ssl"

RDEPEND="capstone? ( >dev-util/capstone-2.1.2:= )
	!dev-util/radare2-capstone
	ssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.9-nogit.patch
}

src_configure() {
	econf \
		$(use_with ssl openssl) \
		$(use_enable debug debugger ) \
		$(use_with capstone syscapstone)
}
