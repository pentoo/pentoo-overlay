# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Pure python implementation of DES and TRIPLE DES encryption algorithm"
HOMEPAGE="https://twhiteman.netfirms.com/des.html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64"

#DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#PDEPEND=""
