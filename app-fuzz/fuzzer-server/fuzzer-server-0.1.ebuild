# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/fuzzer-server/fuzzer-server-0.1.ebuild,v 1.1.1.1 2006/03/08 21:22:06 grimmlin Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A html/wml fuzzer for proxy or client"
HOMEPAGE="http://www.atstake.com/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/fuzzer-server-less-insane-behaviour.patch
}

src_compile() {
	gcc $CFLAGS -o fuzzer-server fuzzer-server.c
}

src_install() {
	dobin fuzzer-server
	dodoc README.txt
}
