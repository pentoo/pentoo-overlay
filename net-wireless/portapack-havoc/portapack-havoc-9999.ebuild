# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Custom firmware for the HackRF SDR + PortaPack H1 addon"
HOMEPAGE="https://github.com/furrtek/portapack-havoc/wiki"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

if [ "${PV}" == "9999" ]; then
	DEPEND="sys-devel/gcc-arm-none-eabi"
	inherit git-r3 cmake-utils
	#EGIT_REPO_URI="https://github.com/furrtek/portapack-havoc.git"
	EGIT_REPO_URI="https://github.com/jboone/portapack-havoc.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
fi

PDEPEND=">=net-wireless/hackrf-tools-2015.07.2-r1
	>=app-mobilephone/dfu-util-0.7"

src_configure() {
	if [ "${PV}" = "9999" ]; then
		strip-flags
		filter-flags "-march=*" "-mtune=*"
		cmake-utils_src_configure
	else
		true
	fi
}

src_install() {
	insinto /usr/share/hackrf
	newins firmware/portapack-h1-havoc.bin portapack-h1-havoc-${PV}.bin
	ln -s portapack-h1-havoc-${PV}.bin "${ED}/usr/share/hackrf/portapack-h1-havoc.bin"
}
