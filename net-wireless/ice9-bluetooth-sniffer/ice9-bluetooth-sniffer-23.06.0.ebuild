# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Wireshark Bluetooth sniffer for HackRF, BladeRF, and USRP"
HOMEPAGE="https://github.com/mikeryan/ice9-bluetooth-sniffer"

LICENSE="GPL-2"
SLOT="0"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mikeryan/ice9-bluetooth-sniffer.git"
else
	SRC_URI="https://github.com/mikeryan/ice9-bluetooth-sniffer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	net-libs/libhackrf:=
	net-libs/liquid-dsp
	net-wireless/bladerf:=
	net-wireless/uhd:=
	sci-libs/fftw:3.0=
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DEXTCAP_INSTALL_PATH="${EPREFIX}/usr/$(get_libdir)/wireshark"
	)
	cmake_src_configure
}
