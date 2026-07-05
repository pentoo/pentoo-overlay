# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="Run a block of text as a subprocess"
HOMEPAGE="
	https://pypi.org/project/runs/
"
SRC_URI="https://github.com/rec/runs/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/xmod[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/tdir[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
# check if .git folder is here
EPYTEST_DESELECT=(
	'test/test_runs.py::TestRunsActual::test_many'
)
distutils_enable_tests pytest
