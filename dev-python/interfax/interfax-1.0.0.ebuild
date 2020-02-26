# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="InterFAX Python Package"
HOMEPAGE="https://github.com/interfax/interfax-python https://www.interfax.net/en"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/cached-property-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/inflection-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/python-magic-0.4.12[${PYTHON_USEDEP}]
	>=dev-python/requests-2.11.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
