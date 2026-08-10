# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="${PN}3"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/py4n6/pytsk

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for The Sleuth Kit (libtsk)"
HOMEPAGE="https://github.com/py4n6/pytsk/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

DEPEND="
	>=app-forensics/sleuthkit-4.11
	sys-libs/talloc[python]
"
RDEPEND="${DEPEND}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest tests/* || die "Tests failed with ${EPYTHON}"
}
