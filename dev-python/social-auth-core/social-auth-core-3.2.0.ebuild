# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
# python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Python social authentication made simple"
HOMEPAGE="https://github.com/python-social-auth/social-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.4.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/python-openid[${PYTHON_USEDEP}]' python2_7)"

#	$(python_gen_cond_dep 'dev-python/defusedxml[${PYTHON_USEDEP}]' python3)

#FIXME:
#python2 and saml? python-saml>=2.2.0

#python3
#python3-openid>=3.0.10
#saml? python3-saml>=1.2.1

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
