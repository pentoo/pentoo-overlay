# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The swiss army knife of subGHz"
HOMEPAGE="https://github.com/atlas0fd00m/rfcat"

SRC_URI="
	https://github.com/atlas0fd00m/rfcat/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatChronosCCBootloader-161009.hex -> RfCatChronosCCBootloader-${PV}.hex
	https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatDonsCCBootloader-161010.hex -> RfCatDonsCCBootloader-${PV}.hex
	https://github.com/atlas0fd00m/rfcat/releases/download/v${PV}/RfCatYS1CCBootloader-161010.hex -> RfCatYS1CCBootloader-${PV}.hex
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="specan"

DEPEND="
	>=dev-python/pyusb-1.0.0[${PYTHON_USEDEP}]
	virtual/libusb:1
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	specan? ( dev-python/pyside[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -r tests || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	insinto /usr/share/rfcat
	doins "${DISTDIR}/RfCatChronosCCBootloader-${PV}.hex"
	doins "${DISTDIR}/RfCatDonsCCBootloader-${PV}.hex"
	doins "${DISTDIR}/RfCatYS1CCBootloader-${PV}.hex"
}

pkg_postinst() {
	einfo "Pre-compiled firmwares from upstream are installed in /usr/share/rfcat"
}
