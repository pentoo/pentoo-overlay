# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#THIS FAILS WITH EAPI7
EAPI=6

CMAKE_MAKEFILE_GENERATOR=ninja
inherit git-r3 cmake-utils

DESCRIPTION="Records calls from a Trunked Radio System (P25 & SmartNet)"
HOMEPAGE="https://github.com/robotastic/trunk-recorder"
EGIT_REPO_URI="https://github.com/robotastic/trunk-recorder.git"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-wireless/gr-osmosdr:=
	net-wireless/gnuradio:=
	net-wireless/uhd:=
	net-wireless/op25:=
	dev-libs/openssl:0=
	dev-libs/boost"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	cmake-utils_src_prepare
	#so this compiles against the bundled op25 then runs with the system op25.  I should probably fix that
	#rm -r lib/op25_repeater
}

src_install() {
	newbin "${BUILD_DIR}/recorder" "${PN}"
	insinto /usr/share/"${PN}"
	doins -r examples
}
