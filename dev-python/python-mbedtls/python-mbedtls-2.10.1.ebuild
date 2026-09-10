# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1
DISTUTILS_EXT=1

inherit distutils-r1

DESCRIPTION="free cryptographic library for Python that uses mbed TLS for back end"
HOMEPAGE="
	https://pypi.org/project/python-mbedtls/
"
SRC_URI="https://github.com/Synss/python-mbedtls/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	net-libs/mbedtls:0=
"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx "docs/source" dev-python/sphinx-rtd-theme \
	dev-python/sphinxcontrib-applehelp \
	dev-python/sphinxcontrib-devhelp \
	dev-python/sphinxcontrib-htmlhelp \
	dev-python/sphinxcontrib-jquery \
	dev-python/sphinxcontrib-jsmath \
	dev-python/sphinxcontrib-qthelp \
	dev-python/sphinxcontrib-serializinghtml

src_prepare () {
	sed -i -e "/startdir/d" tests/conftest.py
	eapply_user
}
