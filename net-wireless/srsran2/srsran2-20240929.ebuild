# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Open source SDR 4G software suite from Software Radio Systems"
HOMEPAGE="https://github.com/hdtuanss/srsRAN2"

# Possible issues to look into
#https://bugs.gentoo.org/713684
#https://bugs.gentoo.org/731720
#https://bugs.gentoo.org/733662
#https://bugs.gentoo.org/832618

HASH_COMMIT="0acc79d3fe5b153a18b62e8ef5af1a0fb2327a18"
SRC_URI="https://github.com/hdtuanss/srsRAN2/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/srsRAN2-${HASH_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bladerf cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_avx512f cpu_flags_x86_fma3 cpu_flags_x86_sse simcard soapysdr test uhd zeromq"

RESTRICT="!test? ( test )"

#Add cpu_flags_x86_avx2= after fixing whatever build failure
DEPEND="
	dev-libs/boost:=
	dev-libs/elfutils
	dev-libs/libconfig:=[cxx]
	net-misc/lksctp-tools
	net-libs/mbedtls:=
	sci-libs/fftw:3.0=[cpu_flags_x86_avx=,cpu_flags_x86_fma3=,cpu_flags_x86_sse=]
	bladerf? ( net-wireless/bladerf:= )
	simcard? ( sys-apps/pcsc-lite )
	soapysdr? ( net-wireless/soapysdr:= )
	uhd? ( net-wireless/uhd:= )
	zeromq? ( net-libs/zeromq:= )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	eapply "${FILESDIR}"/srsran2_array.patch
	eapply "${FILESDIR}"/srsran2_asn1_lib.patch

	sed -i '/ -Werror"/d' CMakeLists.txt || die
	#break upstream hijacking of cflags
	sed -i \
		-e 's/"GNU"/"NERF"/g' \
		-e 's/"Clang"/"NERF"/g' \
		-e 's/Ninja/NERF/g' \
		-e 's/GNUCXX/NERF/g' \
		-e 's/set(CMAKE_C_FLAGS/set(CMAKE_C_FLAGS_NERF/g' \
		CMakeLists.txt
	cmake_src_prepare

}

src_configure() {
	#This may be a bad idea, and it is a bad idea for sure when other tests are failing
	#-DENABLE_ALL_TEST="$(usex test)"
	#-DENABLE_TTCN3="$(usex test)"
	#Maybe make this one depend on zmq instead?
	#-DENABLE_ZMQ_TEST="$(usex test)"

	# Add missing srsGUI
	#-DENABLE_GUI="$(usex gui)"
	mycmakeargs=(
		-DENABLE_UHD="$(usex uhd)"
		-DENABLE_BLADERF="$(usex bladerf)"
		-DENABLE_SOAPYSDR="$(usex soapysdr)"
		-DENABLE_ZEROMQ="$(usex zeromq)"
		-DENABLE_HARDSIM="$(usex simcard)"
		-DCMAKE_C_FLAGS_RELWITHDEBINFO="${CFLAGS}"
	)
	# readd nerfed cflags that are required
	append-cflags "-std=c99 -fno-strict-aliasing -D_GNU_SOURCE"
	append-cxxflags "-std=c++14 -fno-strict-aliasing -D_GNU_SOURCE"
	# "fix" "auto-detection" from use flags, this is probably horrible
	if use cpu_flags_x86_sse; then
		append-cflags "-DLV_HAVE_SSE -mfpmath=sse -msse4.1"
		append-cxxflags "-DLV_HAVE_SSE -mfpmath=sse -msse4.1"
	fi
	if use cpu_flags_x86_avx; then
		append-cflags "-DLV_HAVE_AVX -mavx"
		append-cxxflags "-DLV_HAVE_AVX -mavx"
	fi
	#if use cpu_flags_x86_avx2; then
	#	append-cflags "-DLV_HAVE_AVX2 -mavx2"
	#	append-cxxflags "-DLV_HAVE_AVX2 -mavx2"
	#fi
	#https://github.com/pentoo/pentoo-overlay/issues/1491
	#if use cpu_flags_x86_avx512f; then
	#	append-cflags "-DLV_HAVE_AVX512 -mavx512f"
	#	append-cxxflags "-DLV_HAVE_AVX512 -mavx512f"
	#fi
	if use cpu_flags_x86_fma3; then
		append-cflags "-DLV_HAVE_FMA -mfma"
		append-cxxflags "-DLV_HAVE_FMA -mfma"
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install

	for my_include in srsenb srsepc srsue
	do
		insinto "usr/include/srsran/${my_include}"
		doins -r "${S}/${my_include}/hdr"/*
	done
}
