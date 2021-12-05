# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#THIS FAILS WITH EAPI7
EAPI=6

CMAKE_MAKEFILE_GENERATOR=ninja
inherit cmake-utils multilib

DESCRIPTION="Records calls from a Trunked Radio System (P25 & SmartNet)"
HOMEPAGE="https://github.com/robotastic/trunk-recorder"
if [[ "${PV}" = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/robotastic/trunk-recorder.git"
	EGIT_BRANCH="4.0-beta"
	inherit git-r3
else
	SRC_URI="https://github.com/robotastic/trunk-recorder/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="net-wireless/gr-osmosdr:=
	net-wireless/gnuradio:=
	net-wireless/uhd:=
	!net-wireless/op25
	net-misc/curl:=
	dev-libs/log4cpp:=
	dev-libs/openssl:0=
	dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	cmake-utils_src_configure
	sed -i "s#-Wl,-rpath,${BUILD_DIR}/lib/op25_repeater/lib ##" "${BUILD_DIR}"/build.ninja || die
}

src_install() {
	newbin "${BUILD_DIR}/recorder" "${PN}"
	exeinto /usr/$(get_libdir)/
	doexe "${BUILD_DIR}/lib/op25_repeater/lib/libgnuradio-op25_repeater.so"
	insinto /usr/share/"${PN}"
	doins -r examples
}
