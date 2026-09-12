# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Python SDK for Model Context Protocol"
HOMEPAGE="https://github.com/modelcontextprotocol/python-sdk"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="cli examples rich test ws"
RESTRICT="!test? ( test )"

REQUIRED_USE="test? ( cli ws )"

RDEPEND="
	>=dev-python/anyio-4.5[${PYTHON_USEDEP}]
	<dev-python/httpx-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.27.1[${PYTHON_USEDEP}]
	>=dev-python/httpx-sse-0.4[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.0[${PYTHON_USEDEP}]
	>=dev-python/starlette-0.48.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/sse-starlette-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.31.1[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.20.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.10.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9.0[${PYTHON_USEDEP}]
	>=dev-python/typing-inspection-0.4.1[${PYTHON_USEDEP}]

	rich? ( >=dev-python/rich-13.9.4[${PYTHON_USEDEP}] )
	cli? (
		>=dev-python/typer-0.16.0[${PYTHON_USEDEP}] 
		>=dev-python/python-dotenv-1.0.0[${PYTHON_USEDEP}]
	)
	ws? ( >=dev-python/websockets-15.0.1[${PYTHON_USEDEP}] )
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/inline-snapshot-0.23.0[${PYTHON_USEDEP}]
		>=dev-python/dirty-equals-0.9.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( anyio )
EPYTEST_XDIST=1
EPYTEST_IGNORE=(
	# use pytest-example, that needs missing python binding from ruff
	tests/test_examples.py
)
EPYTEST_DESELECT=(
	# need network connection
	'tests/client/test_config.py::test_command_execution'
)
distutils_enable_tests pytest

src_prepare() {
	sed -i -e "/--numproc/d" pyproject.toml
	eapply_user
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
