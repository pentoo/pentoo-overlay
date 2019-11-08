# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs pax-utils

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="https://github.com/gat3way/hashkill"
EGIT_REPO_URI="https://github.com/gat3way/hashkill"

# GPL-2 — *
# public-domain — src/lzma/*
LICENSE="GPL-2 public-domain"
SLOT="0"

IUSE="video_cards_amdgpu video_cards_nvidia opencl +json pax_kernel"
REQUIRED_USE="
	video_cards_amdgpu? ( opencl )
	video_cards_nvidia? ( opencl )
	opencl? (
		|| ( video_cards_amdgpu video_cards_nvidia )
	)"

DEPEND="
	opencl? ( virtual/opencl[video_cards_amdgpu=,video_cards_nvidia=] )
	json? ( dev-libs/json-c:0= )
	>=dev-libs/openssl-1.0.0:="

RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	if use opencl; then
		ewarn "\nWARNING!!!\nTo compile this package 'portage' user likely must be in the 'video' group temporary."
		ewarn "Please run:"
		ewarn "    ~$ sudo gpasswd -a portage video"
		ewarn "    ~$ sudo emerge -av app-crypt/hashkill"
		ewarn "    ... # after installing:"
		ewarn "    ~$ sudo gpasswd -d portage video\n"
		ewarn "More info:"
		ewarn "    https://github.com/gat3way/hashkill/issues/32"
		ewarn "    https://wiki.gentoo.org/wiki/OpenCL\n"
	fi
}

src_prepare() {
	eapply "${FILESDIR}"

	rm -f src/kernels/nvidia_bfunix.cl || die

	sed -i \
		-e "s/AC_INIT(hashkill, \(.*\),/AC_INIT(hashkill, ${PV},/" \
		configure.ac || die

	if use pax_kernel && use opencl; then
		sed -i \
			-e "s|amd-compiler$|amd-compiler \n\t\t paxctl -m amd-compiler |g" \
			-e "s|nvidia-compiler$|nvidia-compiler \n\t\t paxctl -m nvidia-compiler |g" \
			src/kernels/compiler/Makefile || die
	fi

	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_with json) \
		$(usex video_cards_amdgpu '' '--disable-amd-ocl') \
		$(usex video_cards_nvidia '' '--disable-nv-ocl')

	#the following might fail if gcc is built with USE="multislot"
	if has_version sys-devel/gcc[-lto]; then
	    einfo "Warning: compiling without LTO optimisaiton"
	    sed -i 's/ -flto -fwhole-program//g' src/Makefile || die
	fi
}

src_compile() {
	if use opencl; then
		# The way opencl is doing compilation it requires this no matter what for both devices for enumeration
		# Upstream bug https://github.com/gat3way/hashkill/issues/35
		# we need write access to nvidia/ati devices
		addwrite /dev/nvidia0
		addwrite /dev/nvidiactl
		addwrite /dev/ati
	fi

	# Without -j1 param you can get random errors while building.
	# [hashkill] (../../ocl-base.c:312) clCreateContextFromType: CL_DEVICE_NOT_AVAILABLE
	# Don't remove it
	emake -j1 CC="$(tc-getCC)"
}

src_install() {
	if use pax_kernel; then
		pax-mark m src/hashkill
	fi

	emake DESTDIR="${D}" install
	dodoc README
}

src_test() {
	cd tests
	./test.sh || die
}
