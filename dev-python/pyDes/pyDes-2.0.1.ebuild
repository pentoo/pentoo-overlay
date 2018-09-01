# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="Pure python implementation of DES and TRIPLE DES encryption algorithm"
HOMEPAGE="http://twhiteman.netfirms.com/des.html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64"

#DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#PDEPEND=""
