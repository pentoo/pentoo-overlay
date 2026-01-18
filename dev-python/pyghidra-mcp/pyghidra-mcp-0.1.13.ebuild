# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python Command-Line Ghidra MCP"
HOMEPAGE="https://pypi.org/project/pyghidra-mcp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/click-8.2.1[${PYTHON_USEDEP}]
	>=dev-python/click-option-group-0.5.9[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.9.4[cli,${PYTHON_USEDEP}]
	>=dev-python/pyghidra-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/chromadb-1.3.5[${PYTHON_USEDEP}]
	>=dev-python/ghidrecomp-0.5.8[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
