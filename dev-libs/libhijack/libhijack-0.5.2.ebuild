# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit multilib

DESCRIPTION="Make injecting arbitrary code and other shared objects into another process during runtime easy"
HOMEPAGE="http://0xfeedface.org/"
SRC_URI="https://github.com/downloads/lattera/libhijack/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_compile() {
	emake || die "Failed to compile"
}

src_install() {
	dolib libhijack.so.0.5
	dosym libhijack.so.0.5 /usr/$(get_libdir)/libhijack.so.0
	dosym libhijack.so.0.5 /usr/$(get_libdir)/libhijack.so
	insinto /usr/include
	doins ../include/hijack.h
	doins ../include/hijack_func.h
}
