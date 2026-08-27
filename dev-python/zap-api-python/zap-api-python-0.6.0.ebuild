# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="OWASP ZAP Python API"
HOMEPAGE="https://github.com/zaproxy/zap-api-python"
SRC_URI="https://github.com/zaproxy/zap-api-python/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pyhamcrest[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		dodoc -r src/examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
