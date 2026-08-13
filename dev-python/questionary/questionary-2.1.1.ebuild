# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="
	https://pypi.org/project/questionary/
"
SRC_URI="https://github.com/tmbo/questionary/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="
	<dev-python/prompt-toolkit-4.0[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-2.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
# https://github.com/tmbo/questionary/issues/461, to be removed in the next release
EPYTEST_DESELECT=(
	'tests/prompts/test_common.py::test_print_with_style'
)
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-rtd-theme \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-autodoc-typehints

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
