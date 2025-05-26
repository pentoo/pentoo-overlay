# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Kerberos manipulation library in pure Python"
HOMEPAGE="https://github.com/skelsec/minikerberos"
SRC_URI="https://github.com/skelsec/minikerberos/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples"

RDEPEND="
	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.8[${PYTHON_USEDEP}]
	>=dev-python/oscrypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

# ignore and deselect online test (async and must use an active kerberos server)
EPYTEST_IGNORE=(
	'tests/test_conn_blocking.py'
	'tests/test_conn.py'
	'tests/test_security.py'
)

EPYTEST_DESELECT=(
	'tests/test_examples.py::test_spnroast_base'
	'tests/test_examples.py::test_spnroast_23'
	'tests/test_examples.py::test_spnroast_all'
	'tests/test_examples.py::test_spnroast_list'
	'tests/test_examples.py::test_spnroast_file'
	'tests/test_examples.py::test_spnroast_filedomain'
	'tests/test_examples.py::test_spnroast_listdomain'
	'tests/test_examples.py::test_gettgt'
	'tests/test_examples.py::test_gettgt_nopac'
	'tests/test_examples.py::test_gettgs'
	'tests/test_examples.py::test_getS4U2Self'
	'tests/test_examples.py::test_getS4U2Self_ccache'
	'tests/test_examples.py::test_getS4U2proxy'
	'tests/test_examples.py::test_getS4U2proxy_ccache'
	'tests/test_examples.py::test_getnt'
	'tests/test_examples.py::test_cve_2022_33679'
)

python_install_all() {
	if use examples; then
		docinto examples
		dodoc -r minikerberos/examples/.
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}
