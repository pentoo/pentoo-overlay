# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to parse remote lsass dumps"
HOMEPAGE="https://github.com/Hackndo/lsassy/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=app-exploits/pypykatz-0.6.9[${PYTHON_USEDEP}]
	>=dev-python/impacket-0.11.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

# need a connection to a local server with Session
EPYTEST_DESELECT=(
	'tests/test_lsassy.py::TestWriter'
	'tests/test_lsassy.py::TestWorkflow'
	'tests/test_lsassy.py::TestExecMethods'
	'tests/test_lsassy.py::TestDumpMethods'
)

distutils_enable_tests pytest
