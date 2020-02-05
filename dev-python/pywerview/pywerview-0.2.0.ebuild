# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="A Python port of PowerSploit's PowerView"
HOMEPAGE="https://github.com/the-useless-one/pywerview"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/impacket-0.9.16[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycryptodomex[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
#	sed -i -e "/pycrypto/d" setup.py || die
	sed -i -e '/bs4/d' setup.py || die
	eapply_user
}
