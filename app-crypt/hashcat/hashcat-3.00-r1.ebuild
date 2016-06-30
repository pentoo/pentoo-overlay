# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="An advanced CPU-based password recovery utility"
HOMEPAGE="https://github.com/hashcat/hashcat"
SRC_URI="https://github.com/hashcat/hashcat/archive/v3.00.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

#eselect-opencl provides required headers
DEPEND="app-eselect/eselect-opencl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}"-release.patch
	#do not strip
	sed -i "/CFLAGS_NATIVE            += -s/d" src/Makefile || einfo "stripping failed"
}

src_compile(){
	emake DESTDIR="${D}" PREFIX=/usr
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
