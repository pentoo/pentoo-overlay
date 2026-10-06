# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry-core
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="A generic SAST library built on top of semgrep and regex"
HOMEPAGE="https://github.com/ajinabraham/libsast/"
SRC_URI="https://github.com/ajinabraham/libsast/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/requests-2.27.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/billiard-4.2.1[${PYTHON_USEDEP}]
"
#BDEPEND="
#	${RDEPEND}
#	>=dev-python/semgrep-1.172.0[${PYTHON_USEDEP}]
#"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# download
	'tests/unit/test_rules.py::test_load_url'
	# need semgrep
	'tests/unit/test_semgrep.py::test_semgrep'
	'tests/unit/test_semgrep.py::test_semgrep_metadata'
)
distutils_enable_tests pytest
