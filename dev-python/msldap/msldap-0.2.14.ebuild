# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="Python library to play with MS LDAP"
HOMEPAGE="https://github.com/skelsec/msldap"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#FIXME: https://github.com/skelsec/msldap/issues/13
KEYWORDS="~amd64 ~x86"
IUSE="test"

#'winsspi;platform_system=="Windows"',
RDEPEND="
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/winsspi[${PYTHON_USEDEP}]
	dev-python/aiocmd[${PYTHON_USEDEP}]
	dev-python/asciitree[${PYTHON_USEDEP}]
	dev-python/asysocks[${PYTHON_USEDEP}]
	>=dev-python/winacl-0.0.2[${PYTHON_USEDEP}]
	dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	#https://github.com/skelsec/msldap/issues/12
	sed -i "s|prompt-toolkit<3.0.0|prompt-toolkit|g" setup.py
	sed -i "s|minikerberos==0.2.1|minikerberos|g" setup.py
	eapply_user
}
