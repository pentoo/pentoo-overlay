# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Records calls from a Trunked Radio System (P25 & SmartNet)"
HOMEPAGE="https://github.com/robotastic/trunk-recorder"

if [[ "${PV}" == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/robotastic/trunk-recorder.git"
	inherit git-r3
	RESTRICT="strip"
else
	SRC_URI="https://github.com/robotastic/trunk-recorder/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/libfmt:=
	dev-libs/log4cpp:=
	dev-libs/openssl:0=
	dev-libs/spdlog:=
	dev-libs/boost:=
	net-misc/curl
	net-wireless/gnuradio:=[uhd]
	net-wireless/gr-osmosdr:=
	net-wireless/uhd:=
	!net-wireless/op25
	sci-libs/volk:=
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	cmake_src_install
	# https://github.com/robotastic/trunk-recorder/issues/722
	rm "${ED}/usr/include/${PN}/git.h" || die
	cp git.h "${ED}/usr/include/${PN}/git.h" || die
	cp "${BUILD_DIR}/libgit.so" "${ED}/usr/lib/trunk-recorder/libgit.so" || die
}
