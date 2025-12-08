# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="${PN}3"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for The Sleuth Kit (libtsk)"
HOMEPAGE="https://github.com/py4n6/pytsk/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	>=app-forensics/sleuthkit-4.11
	>=dev-python/pip-7.0[${PYTHON_USEDEP}]
	sys-libs/talloc[python]
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}
