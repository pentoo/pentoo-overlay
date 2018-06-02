# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="A Python toolbox for building complex digital hardware"
HOMEPAGE="https://m-labs.hk/migen/index.html"
SRC_URI="https://github.com/m-labs/migen/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	sed -i "s|0.5.dev|${PV}|" setup.py
	eapply_user
}
