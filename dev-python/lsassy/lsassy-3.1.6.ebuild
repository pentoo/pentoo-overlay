# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python library to parse remote lsass dumps"
HOMEPAGE="https://github.com/Hackndo/lsassy/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=">=dev-python/netaddr-0.8.0[${PYTHON_USEDEP}]
	>=app-exploits/pypykatz-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/impacket-0.9.22[${PYTHON_USEDEP}]
	>=dev-python/rich-10.6.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare(){
	rm -r tests
	eapply_user
}
