# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Small footprint and configurable embedded FPGA logic analyzer"
HOMEPAGE="https://github.com/enjoy-digital/litescope"
SRC_URI="https://github.com/enjoy-digital/litescope/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-electronics/litex[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

# one test from example is broken due to python 3.14, will be fixed in a futur
# release of migen https://git.m-labs.hk/M-Labs/migen/issues/2
EPYTEST_DESELECT=(
	test/test_analyzer.py::TestAnalyzer::test_analyzer

	# missing package litex_board
	test/test_examples.py::TestExamples::test_arty
)
