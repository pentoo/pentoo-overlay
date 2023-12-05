# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A tool to help extracting information from structured PDFs."
HOMEPAGE="https://github.com/jstockwin/py-pdf-parser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="developer"

RDEPEND="
	app-text/pdfminer[${PYTHON_USEDEP}]
	>=dev-python/docopt-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/wand-0.6.10[${PYTHON_USEDEP}]
	developer? (
		>=dev-python/matplotlib-3.5.1[${PYTHON_USEDEP}]
		>=dev-python/pillow-9.2.0[${PYTHON_USEDEP}]
		>=dev-python/pyvoronoi-1.0.7[${PYTHON_USEDEP}]
		>=dev-python/shapely-1.8.2[${PYTHON_USEDEP}]
	)"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	rm -r tests
	sed -i -e 's|==|>=|g' setup.py || die
	eapply_user
}
