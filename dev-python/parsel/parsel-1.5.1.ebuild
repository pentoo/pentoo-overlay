# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3.0

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Parsel is a library to extract data from HTML and XML using XPath and CSS selectors"
HOMEPAGE="https://github.com/scrapy/parsel"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/w3lib-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/six-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/cssselect-0.9[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/functools32[${PYTHON_USEDEP}]' python2_7)"

DEPEND="${REDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
#	test? ( >=dev-python/pytest-runner[${PYTHON_USEDEP}] )

src_prepare() {
	# don't require pytest-runner
	sed -i "/setup_require/d" setup.py || die
	eapply_user
}
