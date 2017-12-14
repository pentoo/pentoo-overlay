# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="A generic system for filtering Django QuerySets based on user selections"
HOMEPAGE="https://github.com/alex/django-filter https://django-filter.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	rm -rfv "${S}"/tests/rest_framework || die
	sed -i -e 's/.*rest_framework.*//g' "${S}"/tests/settings.py || die
	${EPYTHON} runtests.py || die
}

python_prepare_all() {
	use test || rm -rvf "${S}"/tests
	distutils-r1_python_prepare_all
}
