# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy )

inherit distutils-r1

DESCRIPTION="OAuth 2.0 provider for python"
HOMEPAGE="https://pypi.python.org/pypi/python-oauth2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/nose[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/python-memcached[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	dev-python/mysql-connector-python[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	!!dev-python/oauth2
	dev-python/setuptools[${PYTHON_USEDEP}]
	"
#	test? ( dev-python/mock[${PYTHON_USEDEP}]
#	)"

#python_test() {
#	# Skip tests which require network access
#	py.test -k "not (test_access_token_post or test_access_token_get \
#		or test_two_legged_post or test_two_legged_get)" || die \
#		"tests failed with ${EPYTHON}"
#}
