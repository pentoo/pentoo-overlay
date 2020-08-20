# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Custom firmware for the HackRF SDR + PortaPack H1 addon"
HOMEPAGE="https://github.com/eried/portapack-mayhem"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [ "${PV}" == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/eried/portapack-mayhem.git"
	EGIT_BRANCH="gcc9.3-assert-redefinition"
else
	KEYWORDS="~amd64 ~arm ~x86"
	SRC_URI="https://github.com/eried/portapack-mayhem/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DEPEND="sys-devel/gcc-arm-none-eabi"
PDEPEND=">=net-wireless/hackrf-tools-2015.07.2-r1
	>=app-mobilephone/dfu-util-0.7"

src_configure() {
	strip-flags
	filter-flags "-march=*" "-mtune=*"
	cmake_src_configure
}

src_compile() {
	V=1 cmake_src_compile
}

src_install() {
	insinto /usr/share/${PN}
	doins -r "${S}"/sdcard
	newins ${BUILD_DIR}/firmware/portapack-h1_h2-mayhem.bin portapack-h1_h2-mayhem-${PV}.bin
	dodir /usr/share/hackrf
	ln -s ../${PN}/portapack-h1_h2-mayhem-${PV}.bin "${ED}/usr/share/hackrf/portapack-h1_h2-mayhem.bin" || die
}
