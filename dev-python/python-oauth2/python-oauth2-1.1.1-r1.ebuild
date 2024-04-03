# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="OAuth 2.0 provider for python"
HOMEPAGE="https://pypi.python.org/pypi/python-oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/python-memcached[${PYTHON_USEDEP}]
	dev-python/redis[${PYTHON_USEDEP}]
	dev-python/tornado[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
#	test? ( dev-python/mock[${PYTHON_USEDEP}]
#	)"

#python_test() {
#	# Skip tests which require network access
#	py.test -k "not (test_access_token_post or test_access_token_get \
#		or test_two_legged_post or test_two_legged_get)" || die \
#		"tests failed with ${EPYTHON}"
#}
