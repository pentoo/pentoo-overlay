# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="REPL (Read-Eval-Print Loop) tool for working with Modbus devices using the Pymodbus library."
HOMEPAGE="https://github.com/pymodbus-dev/repl https://pypi.org/project/pymodbus-repl/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	$(python_gen_cond_dep '>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]' python3_12)
	$(python_gen_cond_dep '>=dev-python/aiohttp-3.8.6[${PYTHON_USEDEP}]' python3_11)
"

distutils_enable_tests pytest
