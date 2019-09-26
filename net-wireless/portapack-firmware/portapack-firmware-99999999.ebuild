# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Portability Add-On for the HackRF Software-Defined Radio"
HOMEPAGE="https://github.com/sharebrained/portapack-hackrf/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [ "${PV}" == "99999999" ]; then
	DEPEND="sys-devel/gcc-arm-none-eabi"
	inherit git-r3 cmake-utils
	EGIT_REPO_URI="https://github.com/sharebrained/portapack-hackrf.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
fi

PDEPEND=">=net-wireless/hackrf-tools-2015.07.2-r1
	>=app-mobilephone/dfu-util-0.7"

src_configure() {
	if [ "${PV}" = "99999999" ]; then
		#strip-flags
		#filter-flags "-march=*" "-mtune=*"
		unset CFLAGS CPPFLAGS CXXFLAGS FFLAGS FCFLAGS LDFLAGS
		cmake-utils_src_configure
	else
		true
	fi
}

src_install() {
	insinto /usr/share/hackrf
	if [ "${PV}" = "99999999" ]; then
		newins "${BUILD_DIR}"/firmware/portapack-h1-firmware.bin portapack-h1-firmware-${PV}.bin
	else
		newins firmware/portapack-h1-firmware.bin portapack-h1-firmware-${PV}.bin
	fi
	ln -s portapack-h1-firmware-${PV}.bin "${ED}/usr/share/hackrf/portapack-h1-firmware.bin"
}
