# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="PyBluez"
inherit distutils-r1 pypi

DESCRIPTION="Bluetooth Python extension module"
HOMEPAGE="https://github.com/pybluez/pybluez/ https://pypi.org/project/PyBluez/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PYPI_PN}" "${PV}" ".zip")"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=("${FILESDIR}/${PV}_py311.patch")

RDEPEND="net-wireless/bluez"
BDEPEND="
	app-arch/unzip
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}
