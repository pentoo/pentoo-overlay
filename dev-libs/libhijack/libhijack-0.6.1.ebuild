# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit multilib

DESCRIPTION="Make injecting arbitrary code and other shared objects into another process during runtime easy"
HOMEPAGE="http://0xfeedface.org/"
SRC_URI="https://github.com/SoldierX/libhijack/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_prepare() {
	eapply_user
	sed -i "s/-g -Wall -DDEBUG/${CFLAGS}/" Makefile || die
}

src_install() {
	dolib libhijack.so.0.6.1
	dosym libhijack.so.0.6.1 /usr/$(get_libdir)/libhijack.so.0
	dosym libhijack.so.0.6.1 /usr/$(get_libdir)/libhijack.so
	insinto /usr/include
	doins ../include/hijack.h
	doins ../include/hijack_func.h
}
