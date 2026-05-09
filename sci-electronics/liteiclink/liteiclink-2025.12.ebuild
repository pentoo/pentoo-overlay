# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Small footprint and configurable Inter-Chip communication cores"
HOMEPAGE="https://github.com/enjoy-digital/liteiclink"
SRC_URI="https://github.com/enjoy-digital/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-electronics/liteeth[${PYTHON_USEDEP}]
	sci-electronics/litex[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest
