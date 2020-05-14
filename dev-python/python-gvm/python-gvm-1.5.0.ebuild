# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Library to communicate with remote servers over GMP or OSP"
HOMEPAGE="https://github.com/greenbone/python-gvm"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="GPL-3+"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/defusedxml-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.7.1[${PYTHON_USEDEP}]
	"

PATCHES=( "${FILESDIR}/${PV}-notests.patch" )

#src_prepare(){
#	rm -r tests
#	eapply_user
#}
