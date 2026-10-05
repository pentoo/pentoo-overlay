# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Python Command-Line Ghidra MCP"
HOMEPAGE="https://pypi.org/project/pyghidra-mcp/"
SRC_URI="https://github.com/clearbluejar/pyghidra-mcp/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/chromadb-1.3.5[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/click-8.2.1[${PYTHON_USEDEP}]
		>=dev-python/click-option-group-0.5.9[${PYTHON_USEDEP}]
		<dev-python/mcp-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/mcp-1.26.0[cli,${PYTHON_USEDEP}]
		>=dev-python/pyghidra-2.2.1[${PYTHON_USEDEP}]
		>=dev-python/ghidrecomp-0.5.8[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]
			dev-python/aiohttp[${PYTHON_USEDEP}]
		')
	)
"

#RESTRICT="test"
EPYTEST_PLUGINS=( pytest-asyncio )
EPYTEST_IGNORE=(
	cli
)
EPYTEST_DESELECT=(
	# need dependency
	'tests/unit/test_code_index_completion.py::test_incomplete_collection_is_deleted_and_rebuilt'
	'tests/unit/test_code_index_completion.py::test_complete_collection_is_reused'
	# should a warning (can't find ghidra_dir)
	'tests/unit/test_gui_launcher.py::test_request_shutdown_closes_frontend_tool'
	'tests/unit/test_gui_launcher.py::test_launcher_accepts_user_agreement_vmarg'
	'tests/unit/test_gui_launcher.py::test_request_shutdown_is_idempotent'
)
distutils_enable_tests pytest

#
#python_test() {
#	GHIDRA_INSTALL_DIR=/usr/share/ghidra epytest
#}
