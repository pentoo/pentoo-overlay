# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="OAuth2 goodies for the Djangonauts"
HOMEPAGE="https://github.com/evonove/django-oauth-toolkit"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/evonove/django-oauth-toolkit/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/django-1.11[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-2.0.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.13.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
#	test? ( ${RDEPEND}
#		>=dev-python/mockldap-0.2[${PYTHON_USEDEP}] )
#	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

