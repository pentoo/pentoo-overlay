# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 udev

MY_COMMIT="c216cc41a2f9e4b4bc356fb2ca17359275a4f3cd"

DESCRIPTION="USB FT60x driver"
HOMEPAGE="https://github.com/lambdaconcept/ft60x_driver"
SRC_URI="https://github.com/lambdaconcept/ft60x_driver/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_COMMIT}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

pkg_setup() {
	if use kernel_linux; then
		linux-mod-r1_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_compile() {
	local modlist=( ft60x=usb )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	udev_dorules 51-ft60x.rules
}
