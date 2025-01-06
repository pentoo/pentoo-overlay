# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HEX_PV=2.0.1
DATE=201231

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="The swiss army knife of subGHz"
HOMEPAGE="https://github.com/atlas0fd00m/rfcat.git"

SRC_URI="https://github.com/atlas0fd00m/rfcat/archive/v${PV}.tar.gz -> ${P}.tar.gz \
	https://github.com/atlas0fd00m/rfcat/releases/download/v${HEX_PV}/RfCatChronosCCBootloader-${DATE}.hex -> RfCatChronosCCBootloader-${PV}.hex \
	https://github.com/atlas0fd00m/rfcat/releases/download/v${HEX_PV}/RfCatDonsCCBootloader-${DATE}.hex -> RfCatDonsCCBootloader-${PV}.hex \
	https://github.com/atlas0fd00m/rfcat/releases/download/v${HEX_PV}/RfCatYS1CCBootloader-${DATE}.hex -> RfCatYS1CCBootloader-${PV}.hex"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#future needed until https://github.com/atlas0fd00m/rfcat/issues/158
DEPEND=">=dev-python/pyusb-1.0.0[${PYTHON_USEDEP}]
	virtual/libusb:1
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare() {
	rm -r tests || die
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	if [ "${PV}" != "9999" ]; then
		insinto /usr/share/rfcat
		doins "${DISTDIR}/RfCatChronosCCBootloader-${PV}.hex"
		doins "${DISTDIR}/RfCatDonsCCBootloader-${PV}.hex"
		doins "${DISTDIR}/RfCatYS1CCBootloader-${PV}.hex"
	fi
}

pkg_postinst() {
	if [ "${PV}" = "9999" ]; then
		ewarn "Right now, this only installs the rfcat host tools, nothing related to firmware"
	else
		einfo "Pre-compiled firmwares from upstream are installed in /usr/share/rfcat"
	fi
}
