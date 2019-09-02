# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic

DESCRIPTION="tools for communicating with HackRF SDR platform"
HOMEPAGE="http://greatscottgadgets.com/hackrf/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/mossmann/hackrf.git"
	inherit git-r3
	KEYWORDS=""
	EGIT_CHECKOUT_DIR="${WORKDIR}/hackrf"
	S="${WORKDIR}/hackrf/firmware/hackrf_usb"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="=net-libs/libhackrf-${PV}:=
		=net-wireless/hackrf-tools-${PV}:=
		sys-devel/gcc-arm-none-eabi:0
		sci-libs/fftw:3.0="
RDEPEND="${DEPEND}
		!<net-wireless/hackrf-tools-${PV}"

src_configure() {
	strip-flags
	filter-flags "-march=*" "-mtune=*"
	cmake-utils_src_configure
}

src_compile() {
	V=s cmake-utils_src_compile
}

src_install() {
	insinto /usr/share/hackrf
	newins "${BUILD_DIR}/hackrf_usb.bin" hackrf_one_usb-${PV}.bin
	newins "${BUILD_DIR}/hackrf_usb.dfu" hackrf_one_usb-${PV}.dfu
	newins "${WORKDIR}/hackrf/firmware/cpld/sgpio_if/default.xsvf" hackrf_cpld_default-${PV}.xsvf
	ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb_rom_to_ram.bin"
	ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb.bin"
	ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb_ram.dfu"
	ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb.dfu"
}
