# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5
inherit base eutils versionator

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+capstone +debugger ssl"

RDEPEND="capstone? ( >dev-util/capstone-2.1.2:= )
	!dev-util/radare2-capstone
	ssl? ( dev-libs/openssl:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf $(use_with ssl) \
		$(use debugger || echo --disable-debugger ) \
		--with-syscapstone
}

src_install() {
	emake DESTDIR="${D}" INSTALL_PROGRAM="install" install
}
