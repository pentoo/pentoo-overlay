# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Kubernetes python client"
HOMEPAGE="
	https://github.com/kubernetes-client/python
	https://pypi.org/project/kubernetes/
"
SRC_URI="https://github.com/kubernetes-client/python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/python-${PV}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/certifi-2026.7.22[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.13.5[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.32.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.16.0[${PYTHON_USEDEP}]
	<dev-python/urllib3-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/durationpy-0.11[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.14.3[${PYTHON_USEDEP}]
	dev-python/aiohttp-retry[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	# too long
	kubernetes/base/leaderelection/leaderelection_test.py
	kubernetes/leaderelection/leaderelection_test.py
)
EPYTEST_DESELECT=(
	# too many open files, the ulimit must be changed by hand
	'kubernetes/stream/ws_client_test.py::test_rest_call_ignores_env'
	'kubernetes/stream/ws_client_test.py::test_websocket_call_honors_env'
	'kubernetes/test/test_api_client.py::TestApiClient::test_atexit_closes_threadpool'
	'kubernetes/test/test_api_client.py::TestApiClient::test_context_manager_closes_threadpool'
)
distutils_enable_tests pytest

# need more packages to work, but they are not in gentoo nor pentoo, TBD
# distutils_enable_sphinx doc/source dev-python/recommonmark
