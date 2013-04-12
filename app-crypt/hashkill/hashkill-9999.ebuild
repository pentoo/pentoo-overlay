# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 toolchain-funcs autotools pax-utils

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="http://www.gat3way.eu/hashkill"
EGIT_REPO_URI="git://github.com/gat3way/hashkill.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="${IUSE_VIDEO_CARDS} opencl pax_kernel"

DEPEND="opencl? ( virtual/opencl-sdk )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	video_cards_fglrx?  ( x11-drivers/ati-drivers )
	dev-libs/json-c"
RDEPEND="${DEPEND}"

# We need write acccess /dev/nvidia0 and /dev/nvidiactl and the portage
# user is (usually) not in the video group
RESTRICT="userpriv"

src_prepare() {
	if use pax_kernel; then
		sed -e "s|-Wno-unused-result -D_7ZIP_ST -ldl$|-Wno-unused-result -D_7ZIP_ST -ldl \
			\n\t\paxctl -m *-compiler|g" -i src/kernels/compiler/Makefile
	fi
	eautoreconf
}

src_test() {
	if use video_cards_nvidia; then
		einfo "adding write access to /dev/nvidia*"
		# we need write access to this to run the tests
		addpredict /dev/nvidia0
		addpredict /dev/nvidiactl
	fi
}

src_configure() {
	econf \
	$(use_enable video_cards_nvidia nv-ocl) \
	$(use_enable video_cards_fglrx amd-ocl)
	#the following might fail if gcc is built with USE="multislot"
	if [[ $(gcc-version) == 4.5 ]] && has_version sys-devel/gcc:4.5[-lto]; then
	    einfo "Compiling without LTO optimisaiton"
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
