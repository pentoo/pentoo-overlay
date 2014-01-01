# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

inherit eutils multilib

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="http://www.capstone-engine.org/download/${PV}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

#TODO: add java and python bindings

src_prepare() {
	epatch "${FILESDIR}/${PN}-coname.patch"

	#https://github.com/aquynh/capstone/issues/57
	sed -e 's|${CC} $(CFLAGS)|$(CC) $(LDFLAGS) $(CFLAGS)|g' -i tests/Makefile || die "sed failed"
	#https://github.com/aquynh/capstone/issues/51
	epatch "${FILESDIR}/${PN}-libdir.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/share/"${PN}"/
	cp -R "${S}/tests" "${D}/usr/share/${PN}/" || die "Install failed!"
	dodoc README
}
