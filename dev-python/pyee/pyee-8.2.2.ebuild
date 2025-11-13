# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A port of node.js's EventEmitter to python."
HOMEPAGE="https://pypi.python.org/pypi/pyee"
SRC_URI="https://github.com/jfhbrook/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/trio[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
"

DEPEND="
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	'tests/test_async.py::test_asyncio_emit'
	'tests/test_async.py::test_asyncio_once_emit'
	'tests/test_async.py::test_asyncio_error'
	'tests/test_async.py::test_asyncio_cancellation'
	'tests/test_async.py::test_sync_error'
	'tests/test_trio.py::test_sync_error'
)

distutils_enable_tests pytest
distutils_enable_sphinx docs
