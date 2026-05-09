# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Small footprint and configurable PCIe core"
HOMEPAGE="https://github.com/enjoy-digital/litepcie"
SRC_URI="https://github.com/enjoy-digital/litepcie/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-electronics/litex[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

# some tests are broken due to Python version. It's the same issue than
# https://github.com/enjoy-digital/liteeth/issues/189
EPYTEST_DESELECT=(
	test/test_dma.py::TestDMA::test_dma_64b_data_width_32b_address_width
	test/test_dma.py::TestDMA::test_dma_64b_data_width_64b_address_width
	test/test_examples.py::TestExamples::test_ac701_gen

	# missing package litex_board
	test/test_examples.py::TestExamples::test_fk33_target
	test/test_examples.py::TestExamples::test_kc705_target
	test/test_examples.py::TestExamples::test_kcu105_target
	test/test_examples.py::TestExamples::test_xcu1525_target
)
