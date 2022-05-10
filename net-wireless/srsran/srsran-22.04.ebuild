# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Open source SDR 4G/5G software suite from Software Radio Systems"
HOMEPAGE="https://srs.io"

# Possible issues to look into
#https://bugs.gentoo.org/713684
#https://bugs.gentoo.org/731720
#https://bugs.gentoo.org/733662
#https://bugs.gentoo.org/832618

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/srsran/srsRAN.git"
else
	inherit vcs-snapshot
	KEYWORDS="~amd64 ~x86"
	MY_PV=${PV//./_}
	SRC_URI="https://github.com/srsran/srsRAN/archive/refs/tags/release_${MY_PV}.tar.gz -> ${P}.tar.gz"
fi
#https://github.com/srsran/srsRAN/issues/834
RESTRICT="test"

LICENSE="GPL-3"
SLOT="0"
IUSE="bladerf simcard soapysdr test uhd zeromq"

DEPEND="
	dev-libs/boost:=
	dev-libs/elfutils
	dev-libs/libconfig:=[cxx]
	net-misc/lksctp-tools
	net-libs/mbedtls:=
	sci-libs/fftw:3.0=
	bladerf? ( net-wireless/bladerf:= )
	simcard? ( sys-apps/pcsc-lite )
	soapysdr? ( net-wireless/soapysdr:= )
	uhd? ( net-wireless/uhd:= )
	zeromq? ( net-libs/zeromq:= )
"
RDEPEND="${DEPEND}
		!net-wireless/srslte"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/srsran-22.04-fix-shared.patch" )

src_prepare() {
	sed -i '/ -Werror"/d' CMakeLists.txt || die
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
	)
	cmake_src_configure
}
