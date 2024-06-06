# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
#PYPI_NO_NORMALIZE=1
#PYPI_PN="PyBluez"
DISTUTILS_EXT=1
inherit distutils-r1

HASH_COMMIT="82cbba8a1ebd4c1e3442dfafd8581d58c50fa39e"

DESCRIPTION="Bluetooth Python extension module"
HOMEPAGE="https://github.com/pybluez/pybluez/ https://pypi.org/project/PyBluez/"
SRC_URI="https://github.com/pybluez/pybluez/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/pybluez-${HASH_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

#PATCHES=("${FILESDIR}/pybluez-0.23_2to3.patch")

RDEPEND="net-wireless/bluez"
BDEPEND="
	app-arch/unzip
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}
