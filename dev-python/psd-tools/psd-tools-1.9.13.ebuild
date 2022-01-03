# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Package for working with Adobe Photoshop PSD files"
HOMEPAGE="https://pypi.org/project/psd-tools/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#sci-libs/scikits_image is not stable in Gentoo yet
KEYWORDS="amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/aggdraw[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
