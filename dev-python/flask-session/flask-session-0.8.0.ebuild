# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Adds server-side session support to your Flask application"
HOMEPAGE="https://github.com/pallets-eco/flask-session"
SRC_URI="https://github.com/pallets-eco/flask-session/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/cachelib-0.10.2[${PYTHON_USEDEP}]
	>=dev-python/flask-2.2[${PYTHON_USEDEP}]
	>=dev-python/flask-sqlalchemy-3.0.5[${PYTHON_USEDEP}]
	>=dev-python/msgspec-0.18.6[${PYTHON_USEDEP}]
	>=dev-python/pymongo-4.6.2[${PYTHON_USEDEP}]
	>=dev-python/redis-5.0.3[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/boto3[${PYTHON_USEDEP}]
	)
"

# need more dependencies that are not in pentoo nor gentoo overlay
EPYTEST_IGNORE=(
	tests/test_dynamodb.py
	tests/test_memcached.py
)

# need to have a local redis or mongo server running
EPYTEST_DESELECT=(
	'tests/test_mongodb.py::TestMongoSession::test_mongo_default'
	'tests/test_redis.py::TestRedisSession::test_redis_default'
)
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
