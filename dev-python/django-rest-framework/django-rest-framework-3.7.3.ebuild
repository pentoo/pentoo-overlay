# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 ) # ,3_2,3_4 due to dependency to oauth-plus

inherit distutils-r1

DESCRIPTION="Powerful and flexible toolkit that makes it easy to build Web APIs using Django"
HOMEPAGE="http://django-rest-framework.org/"
SRC_URI="https://github.com/tomchristie/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=dev-python/markdown-2.6.4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/django-guardian-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/django-filter-0.13[${PYTHON_USEDEP}]
	>=dev-python/coreapi-1.32.0[${PYTHON_USEDEP}]

"
#	oauth? (
#		>=dev-python/django-oauth-plus-2.0[${PYTHON_USEDEP}]
#	)

DEPEND="${RDEPEND}
>=dev-python/django-1.8[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
"

#		>=dev-python/defusedxml-0.3[${PYTHON_USEDEP}]
#	>=dev-python/oauth2-1.5.211[${PYTHON_USEDEP}]
#	python-oauth2

#RESTRICT="test"
