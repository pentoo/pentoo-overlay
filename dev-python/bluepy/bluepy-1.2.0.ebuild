# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit distutils-r1

DESCRIPTION="Python interface to Bluetooth LE on Linux"
HOMEPAGE="https://github.com/IanHarvey/bluepy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="dev-libs/glib"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
