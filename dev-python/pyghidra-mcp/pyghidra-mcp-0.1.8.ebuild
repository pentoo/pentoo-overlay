# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python Command-Line Ghidra MCP"
HOMEPAGE="https://pypi.org/project/pyghidra-mcp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

#RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/click-8.2.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.9.4[cli,${PYTHON_USEDEP}]
	>=dev-python/pyghidra-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/chromadb-0.5.5[${PYTHON_USEDEP}]

"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
