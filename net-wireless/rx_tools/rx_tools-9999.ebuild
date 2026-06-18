# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit cmake

DESCRIPTION="rx_fm, rx_power, and rx_sdr tools for receiving data from SDRs"
HOMEPAGE="https://github.com/rxseger/rx_tools"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/rxseger/rx_tools.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/rxseger/rx_tools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="net-wireless/soapysdr:="
DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
	# Remove the -fPIE flag from CMakeLists.txt
	# Comment set(CMAKE_POSITION_INDEPENDENT_CODE TRUE) option
	if [[ -f "${CMAKE_USE_DIR}/CMakeLists.txt" ]]; then
	elog "=============================================================================================================="
	    sed -i '/set(CMAKE_POSITION_INDEPENDENT_CODE.*TRUE.*/s/^/# /' "${CMAKE_USE_DIR}/CMakeLists.txt"
	fi
}

src_configure() {
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}
