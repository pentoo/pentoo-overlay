# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Small footprint and configurable DRAM core"
HOMEPAGE="https://github.com/enjoy-digital/litedram"
SRC_URI="https://github.com/enjoy-digital/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

#IUSE=test
#RESTRICT="!test? ( test )"
# to be investigated
RESTRICT="test"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-electronics/litex[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]
"

#BDEPEND="
#	test? (
#		dev-python/pexpect[${PYTHON_USEDEP}]
#	)
#"

#distutils_enable_tests pytest
