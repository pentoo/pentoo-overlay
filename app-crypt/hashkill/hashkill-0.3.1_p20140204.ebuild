# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs pax-utils flag-o-matic

DESCRIPTION="Multi-threaded password recovery tool with multi-GPU support"
HOMEPAGE="https://github.com/gat3way/hashkill"

HASH_COMMIT="50ba2b5971e1b7228df9d1c9e1e775881b18f96c" # 20140204
SRC_URI="https://github.com/gat3way/hashkill/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

# GPL-2 — *
# public-domain — src/lzma/*
LICENSE="GPL-2 public-domain"

KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="video_cards_amdgpu video_cards_nvidia +opencl +json pax_kernel"
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

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

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

	sed -i \
		-e "s/AC_INIT(hashkill, \(.*\),/AC_INIT(hashkill, ${PV},/" \
		configure.ac || die

	# do not add random CFLAGS
	sed -i \
		-e "s/ -O3//g" \
		src/Makefile.am src/Makefile.in \
		src/plugins/Makefile || die

	#the following might fail if gcc is built with USE="multislot"
	if has_version sys-devel/gcc[-lto]; then
	    einfo "Warning: compiling without LTO optimisaiton"
	    sed -i 's/ -flto -fwhole-program//g' src/Makefile || die
	fi

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
	filter-flags -O2
	econf \
		$(use_with json) \
		$(use_enable video_cards_amdgpu amd-ocl) \
		$(use_enable video_cards_nvidia nv-ocl)
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

	# Your building speed heavily depends on your equipment.
	# Without -j1 param you can get random screen freezes and errors during building:
	# * [hashkill] (../../ocl-base.c:312) clCreateContextFromType: CL_DEVICE_NOT_AVAILABLE
	emake CC="$(tc-getCC)" -j1
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

pkg_postinst() {
	ewarn "    ... # after installing:"
	ewarn "    ~$ sudo gpasswd -d portage video\n"
}
