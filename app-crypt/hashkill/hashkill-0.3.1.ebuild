# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs autotools

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="http://www.gat3way.eu/hashkill"
SRC_URI="https://github.com/gat3way/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/opencl-sdk"
RDEPEND="${DEPEND}"

src_prepare() {
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
