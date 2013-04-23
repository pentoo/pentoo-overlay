# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 autotools pax-utils toolchain-funcs

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="http://www.gat3way.eu/hashkill"
EGIT_REPO_URI="git://github.com/gat3way/hashkill.git"
EGIT_COMMIT="65dfc0cf1e0d455278fd1330c07d6f3f00c0cd40"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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

src_compile() {
	if use video_cards_nvidia; then
		# we need write access to nvidia devices
		addwrite /dev/nvidia0
		addwrite /dev/nvidiactl
	fi
	if use video_cards_fglrx; then
		# we need write access to ati devices
		addwrite /dev/ati
	fi

	emake
}

src_install() {
	if use pax_kernel; then
		pax-mark m src/hashkill
	fi

	emake DESTDIR="${D}" install
	dodoc README
}
