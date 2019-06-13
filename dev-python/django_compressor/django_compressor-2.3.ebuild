# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Compresses linked and inline JavaScript or CSS into single cached files"
HOMEPAGE="https://django-compressor.readthedocs.io/en/latest/ https://django-filter.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
	>=dev-python/django-appconf-1.0[${PYTHON_USEDEP}]
	>=dev-python/rcssmin-1.0.6[${PYTHON_USEDEP}]
	>=dev-python/rjsmin-1.1.0[${PYTHON_USEDEP}]
"
RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
