# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Collection of common interactive command line user interfaces"
HOMEPAGE="https://github.com/guysalt/python-inquirer3"
SRC_URI="https://github.com/guysalt/python-inquirer3/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="!test? ( test )"
IUSE="examples test"

RDEPEND="
	dev-python/blessed[${PYTHON_USEDEP}]
	dev-python/readchar[${PYTHON_USEDEP}]
	dev-python/editor[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
# hanging, to be investigated
EPYTEST_IGNORE=(
	tests/acceptance
)
distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
