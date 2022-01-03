# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python social authentication made simple"
HOMEPAGE="https://github.com/python-social-auth/social-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="saml"

RDEPEND=">=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.4.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/defusedxml[${PYTHON_USEDEP}]
		>=dev-python/python3-openid-3.0.10[${PYTHON_USEDEP}]
		saml? ( >=dev-python/python3-saml-1.2.1 )
	')
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
