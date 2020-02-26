# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A very simple, yet powerful, Django captcha application"
HOMEPAGE="https://github.com/mbi/django-simple-captcha https://django-filter.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=">=dev-python/six-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/django-1.8[${PYTHON_USEDEP}]
	>=dev-python/pillow-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/django-ranged-response-0.2.0[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
