# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Command-line client for pyghidra-mcp server"
HOMEPAGE="https://pypi.org/project/pyghidra-mcp-cli/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.2.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.9.4[cli,${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
"
