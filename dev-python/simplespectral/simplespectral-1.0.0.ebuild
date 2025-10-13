# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYPI_PN="SimpleSpectral"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Heavily simplified scipy.signal.spectral module"
HOMEPAGE="https://github.com/xmikos/simplespectral"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

IUSE="+faster fastest"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
		faster? ( dev-python/scipy[${PYTHON_USEDEP}] )
		fastest? ( dev-python/pyFFTW[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
