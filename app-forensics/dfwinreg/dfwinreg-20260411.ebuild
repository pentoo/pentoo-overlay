# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Digital Forensics Windows Registry (dfWinReg)"
HOMEPAGE="https://github.com/log2timeline/dfwinreg"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/dfdatetime-20160814
	>=dev-python/dtfabric-20170524
	>=dev-libs/libcreg-20210502[python]
	>=app-forensics/libregf-20201002[python]
"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	'tests/registry.py::RegistryTest::testGetKeyByPathOnSystem'
)
distutils_enable_tests pytest

python_test() {
	epytest tests/* || die "Tests failed with ${EPYTHON}"
}
