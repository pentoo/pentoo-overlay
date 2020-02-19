# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Android Package Identifier"
HOMEPAGE="https://github.com/rednaga/APKiD"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/yara-python[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare(){
	sed "s|yara-python==3.11.0|yara-python>=3.11.0|g" -i setup.py || die
	#https://github.com/rednaga/APKiD/issues/211
	sed '/argparse/d' -i setup.py || die
	default
}
