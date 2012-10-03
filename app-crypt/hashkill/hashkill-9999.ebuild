# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

#WANT_AUTOMAKE="1.12"
#WANT_AUTOCONF="2.5"

inherit git-2 eutils toolchain-funcs autotools

DESCRIPTION="http://www.gat3way.eu/hashkill"
HOMEPAGE="Multi-threaded password recovery tool with multi-GPU support"
EGIT_REPO_URI="git://github.com/gat3way/hashkill.git"
#SRC_URI="https://github.com/downloads/gat3way/hashkill/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/opencl-sdk"
RDEPEND="${DEPEND}"

src_prepare () {
	epatch "${FILESDIR}"/${PN}-automake.patch
	eautoreconf
}

src_configure() {
	econf
	#the following might fail if gcc is built with USE="multislot"
	if [[ $(gcc-version) == 4.5 ]] && has_version sys-devel/gcc:4.5[-lto]; then
	    einfo "Compiling without LTO optimisaiton"
	    sed -i 's| -flto -fwhole-program||g' src/Makefile
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
