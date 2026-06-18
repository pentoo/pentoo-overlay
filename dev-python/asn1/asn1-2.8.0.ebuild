# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="a simple ASN.1 encoder and decoder"
HOMEPAGE="https://github.com/andrivet/python-asn1"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64 x86"
IUSE="examples"

RDEPEND="
	dev-python/future[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_test() {
	epytest tests
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
