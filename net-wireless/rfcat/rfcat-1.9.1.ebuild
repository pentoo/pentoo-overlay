# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1

DESCRIPTION="The swiss army knife of subGHz"
HOMEPAGE="https://github.com/atlas0fd00m/rfcat.git"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/atlas0fd00m/rfcat.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/atlas0fd00m/rfcat/archive/v${PV}.tar.gz -> ${P}.tar.gz \
		https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatChronosCCBootloader.hex -> RfCatChronosCCBootloader-${PV}.hex \
		https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatDonsCCBootloader.hex -> RfCatDonsCCBootloader-${PV}.hex \
		https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatYS1CCBootloader.hex -> RfCatYS1CCBootloader-${PV}.hex"
	KEYWORDS="~amd64 ~x86"
#	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="BSD"
SLOT="0"
IUSE="gui"

DEPEND=">=dev-python/pyusb-1.0.0[${PYTHON_USEDEP}]
	virtual/libusb:1
	gui? ( >=dev-python/pyside2-5.12.0[${PYTHON_USEDEP}] )
	>=dev-python/future-0.17.1[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install

	if [ "${PV}" != "9999" ]; then
		insinto /usr/share/rfcat
		doins "${DISTDIR}"/*.hex
	fi
}

pkg_postinst() {
	if [ "${PV}" = "9999" ]; then
		ewarn "Right now, this only installs the rfcat host tools, nothing related to firmware"
	else
		einfo "Pre-compiled firmwares from upstream are installed in /usr/share/rfcat"
	fi
}
