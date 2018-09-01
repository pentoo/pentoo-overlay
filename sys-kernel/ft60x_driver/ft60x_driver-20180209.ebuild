# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod udev

MY_COMMIT="4299a497c043cc3ddf4cb8dfcc0d4a45d44b80f9"

DESCRIPTION="USB FT60x driver"
HOMEPAGE="https://github.com/lambdaconcept/ft60x_driver"
SRC_URI="https://github.com/lambdaconcept/ft60x_driver/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""

S="${WORKDIR}/${PN}-${MY_COMMIT}"

MODULE_NAMES="ft60x(usb:${S}:${S})"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install
	udev_dorules 51-ft60x.rules
}
