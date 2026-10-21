# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=hatchling
PYPI_VERIFY_REPO=https://github.com/modelcontextprotocol/python-sdk

inherit distutils-r1 pypi

DESCRIPTION="Model Context Protocol wire types"
HOMEPAGE="https://github.com/modelcontextprotocol/python-sdk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/pydantic-2.12.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.13.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/uv-dynamic-versioning[${PYTHON_USEDEP}]"

python_compile() {
	local -x UV_DYNAMIC_VERSIONING_BYPASS=${PV}
	distutils-r1_python_compile
}
