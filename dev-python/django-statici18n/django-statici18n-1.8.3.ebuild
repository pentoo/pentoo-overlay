# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Django helper for generating Javascript catalog to static files"
HOMEPAGE="https://django-statici18n.readthedocs.org/ https://django-filter.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86"  # Rquires dev-python/django-appconf which is not in Gentoo, nor Pentoo
IUSE=""

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
	dev-python/django-appconf[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
