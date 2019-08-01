# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6}} )

inherit distutils-r1

DESCRIPTION="A python module for converting complex JSON oject to HTML Table representation"
HOMEPAGE="https://github.com/softvar/json2html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/ordereddict[${PYTHON_USEDEP}]' python2_7)
	dev-python/simplejson[${PYTHON_USEDEP}]"
