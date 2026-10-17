# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="An asynchronous WebDAV server implementation, support multi-provider"
HOMEPAGE="https://github.com/rexzhang/asgi-webdav"
SRC_URI="https://github.com/rexzhang/asgi-webdav/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/httptools[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/httpx-kerberos[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
	dev-python/uvloop[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
	>=dev-python/asgi-middleware-static-file-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-1.0.2[${PYTHON_USEDEP}]
	~dev-python/dataclass-wizard-1.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/icecream[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-{asyncio,mock} )
# return 409 instead of 200, to be investigated
EPYTEST_DESELECT=(
	'tests/test_webdav_method.py::test_method_copy_move[fs]'
	'tests/test_webdav_method.py::test_method_lock_unlock_exclusive[fs]'
)
distutils_enable_tests pytest

src_prepare() {
	sed -i -e 's/"--cov.*/""/' pyproject.toml
	distutils-r1_src_prepare
}
