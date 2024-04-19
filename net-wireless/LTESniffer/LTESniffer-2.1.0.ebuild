# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="LTE Downlink/Uplink Eavesdropper"
HOMEPAGE="https://github.com/SysSec-KAIST/LTESniffer"
SRC_URI="https://github.com/SysSec-KAIST/LTESniffer/archive/refs/tags/LTESniffer-v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
# WIP
#KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/LTESniffer-LTESniffer-v${PV}"

RDEPEND="net-misc/lksctp-tools
	dev-libs/libconfig
	dev-libs/c-mnalib
	net-wireless/srsran2"
DEPEND="${RDEPEND}"

#src_prepare() {
#	-Werror=maybe-uninitialized
#	srsRAN-src/lib/include/srsran/srslog/bundled/fmt/core.h <- #include <array>
#	sed '/set(CMAKE_CXX_FLAGS/d' -i CMakeLists.txt

#	sed -i "s|WORK_DIR|${WORKDIR}|g" srcRAN-src/lib || die "sed failed"

#	cmake_src_prepare
#}

#no-maybe-uninitialized
src_configure() {
#	append-cxxflags $(test-flags-CXX -Wno-uninitialized)
#	append-cxxflags $(test-flags-CXX -Wno-uninitialized -Wno-maybe-uninitialized)
	local mycmakeargs=(
#		-Wno-dev -Wno-uninitialized -Wno-maybe-uninitialized
		-DFORCE_SUBPROJECT_CMNALIB=OFF
		-DFORCE_SUBPROJECT_SRSRAN=OFF
	)
#		option(DISABLE_SIMD    "disable simd instructions"                OFF)
#		option(FORCE_SUBPROJECT_CMNALIB "Download and build CMNALIB"      OFF)
#		option(FORCE_SUBPROJECT_SRSRAN  "Download and build SRSRAN"       OFF)
#		option(ENABLE_GUI      "Enable GUI (using srsGUI)"                ON)
#		option(ENABLE_UHD      "Enable UHD"                               ON)
#		option(ENABLE_BLADERF  "Enable BladeRF"                           ON)
#		option(ENABLE_SOAPYSDR "Enable SoapySDR"                          ON)
#		option(BUILD_STATIC    "Attempt to statically link external deps" OFF)
#		option(ENABLE_ASAN     "Enable gcc/clang address sanitizer"       OFF)
#		option(ENABLE_MSAN     "Enable clang memory sanitizer"            OFF)
#		option(ENABLE_TIDY     "Enable clang tidy"                        OFF)

	cmake_src_configure
}

#src_install() {
#	cmake_src_install
#	find "${ED}" -name "*.py[co]" -delete || die
#	python_optimize

	#this isn't right, but cmake is broken somehow
#	dodir /usr/share/${PN}
#	cp -r "${S}/op25/gr-op25_repeater/apps" "${ED}/usr/share/${PN}" || die
#}
