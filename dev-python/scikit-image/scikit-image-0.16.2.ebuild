# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="https://scikit-image.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"

#KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
"
#WIP:
#	dev-python/imageio
#	dev-python/tifffile>=2019.7.26
#	dev-python/pyWavelets[${PYTHON_USEDEP}]
#	dev-python/pooch>=0.5.2
#"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
