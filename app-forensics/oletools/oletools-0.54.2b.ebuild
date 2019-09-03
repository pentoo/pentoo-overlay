# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A python tools to analyze MS OLE2 files and MS Office documents"
HOMEPAGE="https://github.com/decalage2/oletools"
SRC_URI="https://github.com/decalage2/oletools/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/olefile-0.46[${PYTHON_USEDEP}]
	dev-python/easygui[${PYTHON_USEDEP}]
	dev-python/msoffcrypto-tool[${PYTHON_USEDEP}]
	dev-python/colorclass[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
