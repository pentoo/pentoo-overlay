# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Package for working with Adobe Photoshop PSD files"
HOMEPAGE="https://pypi.org/project/psd-tools/"

LICENSE="MIT"
SLOT="0"
#sci-libs/scikits_image is not stable in Gentoo yet
KEYWORDS="amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/aggdraw[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/scikit-image[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/cython"
