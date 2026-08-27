# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Small footprint and configurable Ethernet core"
HOMEPAGE="https://github.com/enjoy-digital/liteeth"
SRC_URI="https://github.com/enjoy-digital/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-electronics/liteiclink[${PYTHON_USEDEP}]
	sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

# some tests are broken due to Python version
# https://github.com/enjoy-digital/liteeth/issues/189
EPYTEST_DESELECT=(
	test/test_arp.py::TestARP::test
	test/test_etherbone.py::TestEtherbone::test_etherbone
	test/test_icmp.py::TestICMP::test
	test/test_ip.py::TestIP::test
	test/test_mac_core.py::TestMACCore::test
	test/test_mac_wishbone.py::TestMACWishbone::test
	test/test_udp.py::TestUDP::test
	test/test_xgmii_phy.py::TestXGMIIPHY::test_xgmii_stream_loopback
	test/test_gen.py::TestExamples::test_udp_raw_rgmii
	test/test_gen.py::TestExamples::test_udp_s7phyrgmii
	test/test_gen.py::TestExamples::test_wishbone_mii
)
