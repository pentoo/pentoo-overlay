# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2 autotools pax-utils toolchain-funcs

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="http://www.gat3way.eu/hashkill"
EGIT_REPO_URI="git://github.com/gat3way/hashkill.git"
EGIT_COMMIT="e2a11efc3a580b0c509f1809e969b2f8d240f8ef"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="${IUSE_VIDEO_CARDS} opencl pax_kernel json"

DEPEND="opencl? ( virtual/opencl-sdk )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	video_cards_fglrx?  ( x11-drivers/ati-drivers )
	json? ( <dev-libs/json-c-0.11 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use video_cards_nvidia; then
		if [ ! -w /dev/nvidia0 ]; then
			einfo "To compile this package  portage likely must be in the video group."
			einfo "Please run \"gpasswd -a portage video\" if build fails."
		fi
	fi
	if use video_cards_fglrx; then
		if [ ! -w /dev/ati ]; then
			einfo "To compile this package portage likely must be in the video group."
			einfo "Please run \"gpasswd -a portage video\" if build fails."
		fi
	fi
}

src_prepare() {
	if use pax_kernel; then
		sed -e "s|amd-compiler$|amd-compiler \
		\n\t\t paxctl -m amd-compiler |g" -i src/kernels/compiler/Makefile
		sed -e "s|nvidia-compiler$|nvidia-compiler \
		\n\t\t paxctl -m nvidia-compiler |g" -i src/kernels/compiler/Makefile
	fi

	#bug https://github.com/gat3way/hashkill/issues/52
	use json || sed -e 's|JS_LIBS="-ljson"|JS_LIBS=""|g' -i json.m4

	eautoreconf
}

src_configure() {
	econf \
	$(use_enable video_cards_nvidia nv-ocl) \
	$(use_enable video_cards_fglrx amd-ocl) \
	$(use_with json)
	#the following might fail if gcc is built with USE="multislot"
	if has_version sys-devel/gcc[-lto]; then
	    einfo "Warning: compiling without LTO optimisaiton"
	    sed -i 's| -flto -fwhole-program||g' src/Makefile
	fi
}

src_compile() {
	#the way opencl is doing compilation it requires this no matter what for both devices for enumeration
	# Upstream bug https://github.com/gat3way/hashkill/issues/35
	# we need write access to nvidia devices
	addwrite /dev/nvidia0
	addwrite /dev/nvidiactl
	# we need write access to ati devices
	addwrite /dev/ati

	emake
}

src_test() {
	cd tests
	./test.sh
}

src_install() {
	if use pax_kernel; then
		pax-mark m src/hashkill
	fi

	emake DESTDIR="${D}" install
	dodoc README
}
