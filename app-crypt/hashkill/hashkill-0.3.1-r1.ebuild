# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit toolchain-funcs autotools pax-utils

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="http://www.gat3way.eu/hashkill"
SRC_URI="https://github.com/gat3way/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="${IUSE_VIDEO_CARDS} opencl pax_kernel"

DEPEND="opencl? ( virtual/opencl )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	video_cards_fglrx?  ( x11-drivers/ati-drivers )
	<dev-libs/json-c-0.11"

RDEPEND="${DEPEND}"

src_prepare() {
	if use pax_kernel; then
		sed -e "s|amd-compiler$|amd-compiler \
		\n\t\t paxctl -m amd-compiler |g" -i src/kernels/compiler/Makefile
		sed -e "s|nvidia-compiler$|nvidia-compiler \
		\n\t\t paxctl -m nvidia-compiler |g" -i src/kernels/compiler/Makefile
	fi
	eautoreconf
}

src_configure() {
	econf
	#the following might fail if gcc is built with USE="multislot"
	if has_version sys-devel/gcc[-lto]; then
	    einfo "Warning: compiling without LTO optimisaiton"
	    sed -i 's| -flto -fwhole-program||g' src/Makefile
	fi
}

src_install() {
	if use pax_kernel; then
		pax-mark m src/hashkill
	fi

	emake DESTDIR="${D}" install || die
	dodoc README
}
