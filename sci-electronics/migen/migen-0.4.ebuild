# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

#https://github.com/mlen/gentoo-overlay/tree/master/sci-electronics/migen

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="A Python toolbox for building complex digital hardware"
HOMEPAGE="https://m-labs.hk/gateware.html"
SRC_URI="https://github.com/m-labs/migen/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
		 dev-python/colorama[${PYTHON_USEDEP}]
		 dev-python/sphinx[${PYTHON_USEDEP}]
		 dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]"
