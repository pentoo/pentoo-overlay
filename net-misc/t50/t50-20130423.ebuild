# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Mixed Packet Injector & Network Stress Testing Tool"
HOMEPAGE="https://github.com/merces/t50"
EGIT_REPO_URI="https://github.com/merces/t50.git"
EGIT_COMMIT="e3853e359e55a7edc83afa991669ecf147ff7467"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	#Fix broken Makefile
	sed -i "s|STRIP=-s|STRIP=|" Makefile || die
	sed -i "s|\$(CFLAGS)|\$(CFLAGS) \$(LDFLAGS)|" Makefile || die
}

src_install() {
	#It's easy to re-write the install script
#	emake DESTDIR="${D}" install
	dosbin ${PN}
	dodoc readme
	doman doc/t50.1
}
